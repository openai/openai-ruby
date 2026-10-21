# frozen_string_literal: true

require_relative "openai/test_helper"

# Offline regression coverage for consent lifecycle and existing voice creation.
class VoiceConsentsContractTest < Minitest::Test
  class Capture < OpenAI::HTTPClient
    attr_reader :requests, :bodies

    def initialize(*responses)
      super()
      @responses = responses
      @requests = []
      @bodies = []
    end

    def execute(request)
      @requests << request
      @bodies <<
        case request.body
        when nil, String
          request.body
        else
          request.body.to_a.join
        end
      status, body = @responses.shift || raise("Unexpected extra request")
      OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"content-type" => "application/json", "x-request-id" => "req_synthetic"},
        body: [JSON.generate(body)]
      )
    end
  end

  def consent(id = "cons_synthetic")
    {id: id, object: "audio.voice_consent", name: "Synthetic", language: "en-US", created_at: 1_734_220_800}
  end

  def client(transport)
    OpenAI::Client.new(
      api_key: "synthetic-unused",
      base_url: "https://example.invalid/v1",
      http_client: transport,
      max_retries: 0
    )
  end

  def test_upload_preserves_file_bytes_filename_mime_and_metadata
    transport = Capture.new([200, consent])
    file = OpenAI::FilePart.new(
      StringIO.new("RIFF\x00\xffsynthetic".b),
      filename: "consent.wav",
      content_type: "audio/wav"
    )
    result = client(transport).audio.voice_consents.create(name: "Synthetic", language: "en-US", recording: file)
    assert_instance_of(OpenAI::Audio::VoiceConsent, result)
    assert_equal("cons_synthetic", result.id)
    assert_equal("Synthetic", result.name)
    assert_equal("en-US", result.language)
    assert_equal(:"audio.voice_consent", result.object)
    assert_equal(1_734_220_800, result.created_at)
    request = transport.requests.fetch(0)
    assert_equal(:post, request.method)
    assert_equal("/v1/audio/voice_consents", URI(request.url.to_s).path)
    assert_match(/multipart\/form-data; boundary=/, request.headers.fetch("content-type"))
    assert_includes(transport.bodies.first, "name=\"recording\"; filename=\"consent.wav\"")
    assert_includes(transport.bodies.first, "Content-Type: audio/wav")
    assert_includes(transport.bodies.first.b, "RIFF\x00\xffsynthetic".b)
    assert_includes(transport.bodies.first, "name=\"name\"\r\nContent-Type: text/plain\r\n\r\nSynthetic")
    assert_includes(transport.bodies.first, "name=\"language\"\r\nContent-Type: text/plain\r\n\r\nen-US")
  end

  def test_retrieve_update_and_delete_use_shared_typed_results
    transport = Capture.new(
      [200, consent],
      [200, consent.merge(name: "Renamed")],
      [200, {id: "cons_synthetic", object: "audio.voice_consent", deleted: true}]
    )
    resource = client(transport).audio.voice_consents
    assert_instance_of(OpenAI::Audio::VoiceConsent, resource.retrieve("cons_synthetic"))
    updated = resource.update("cons_synthetic", name: "Renamed")
    assert_instance_of(OpenAI::Audio::VoiceConsent, updated)
    assert_equal("Renamed", updated.name)
    deleted = resource.delete("cons_synthetic")
    assert_instance_of(OpenAI::Audio::VoiceConsentDeleted, deleted)
    assert_equal("cons_synthetic", deleted.id)
    assert_equal(:"audio.voice_consent", deleted.object)
    assert_equal(true, deleted.deleted)
    assert_equal([:get, :post, :delete], transport.requests.map(&:method))
    assert_equal(["/v1/audio/voice_consents/cons_synthetic"] * 3, transport.requests.map { URI(_1.url.to_s).path })
    assert_equal({"name" => "Renamed"}, JSON.parse(transport.bodies[1]))
  end

  def test_pagination_preserves_limit_and_advances_after_last_item
    first = {object: "list", data: [consent("cons_one")], first_id: "cons_one", last_id: "cons_one", has_more: true}
    last = {object: "list", data: [consent("cons_two")], first_id: "cons_two", last_id: "cons_two", has_more: false}
    transport = Capture.new([200, first], [200, last])
    page = client(transport).audio.voice_consents.list(limit: 1, after: "cons_zero")
    assert_instance_of(OpenAI::Internal::CursorPage, page)
    seen = []
    page.auto_paging_each { seen << _1 }
    assert_equal(["cons_one", "cons_two"], seen.map(&:id))
    assert(seen.all? { _1.is_a?(OpenAI::Audio::VoiceConsent) })
    assert_equal(
      [{"after" => "cons_zero", "limit" => "1"}, {"after" => "cons_one", "limit" => "1"}],
      transport.requests.map { URI.decode_www_form(URI(_1.url.to_s).query).to_h }
    )
  end

  def test_empty_terminal_page_does_not_request_more
    transport = Capture.new([200, {object: "list", data: [], first_id: nil, last_id: nil, has_more: false}])
    page = client(transport).audio.voice_consents.list
    refute(page.next_page?)
    page.auto_paging_each { flunk("Unexpected consent") }
    assert_equal(1, transport.requests.length)
  end

  def test_api_errors_preserve_sdk_error_types
    [[400, OpenAI::Errors::BadRequestError], [404, OpenAI::Errors::NotFoundError]].each do |status, klass|
      transport = Capture.new(
        [status, {error: {message: "Synthetic failure", type: "invalid_request_error", code: "synthetic"}}]
      )
      error = assert_raises(klass) { client(transport).audio.voice_consents.retrieve("cons_missing") }
      assert_equal(status, error.status)
    end
  end

  def test_existing_recording_and_prompt_voice_creation
    voice = {
      id: "voice_synthetic",
      object: "audio.voice",
      name: "Synthetic",
      created_at: 1_734_220_800,
      type: "audio_sample"
    }
    transport = Capture.new([200, voice], [200, voice.merge(type: "prompt", prompt: "Calm adult voice")])
    resource = client(transport).audio.voices
    assert_instance_of(
      OpenAI::Audio::Voice,
      resource.create(body: {name: "Synthetic", consent: "cons_synthetic", audio_sample: StringIO.new("synthetic")})
    )
    assert_instance_of(
      OpenAI::Audio::Voice,
      resource.create(body: {name: "Synthetic", type: :prompt, prompt: "Calm adult voice"})
    )
    assert_equal(["/v1/audio/voices"] * 2, transport.requests.map { URI(_1.url.to_s).path })
  end
end

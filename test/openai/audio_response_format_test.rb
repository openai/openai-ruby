# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AudioResponseFormatTest < Minitest::Test
  class Capture < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(body, content_type: "application/json")
      super()
      @body = body
      @content_type = content_type
      @requests = []
    end

    def execute(request)
      @requests << request
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => @content_type, "x-request-id" => "req_audio_format"},
        body: [@body]
      )
    end
  end

  def test_verbose_translation_uses_the_effective_format
    body = JSON.generate(
      duration: 1.25,
      language: "english",
      text: "hello",
      segments: [verbose_segment],
      future: {value: 1}
    )
    [
      {response_format: :verbose_json},
      {response_format: "verbose_json"},
      {response_format: :json, request_options: {extra_body: {response_format: :verbose_json}}},
      {response_format: :json, request_options: {extra_body: {"response_format" => "verbose_json"}}},
      {request_options: OpenAI::RequestOptions.new(extra_body: {"response_format" => "verbose_json"})}
    ].each do |params|
      client, transport = client_for(body)
      response = client.audio.translations.create(**audio_params, **params)

      assert_instance_of(OpenAI::Audio::TranslationVerbose, response)
      assert_instance_of(OpenAI::Audio::TranscriptionSegment, response.segments.fetch(0))
      assert_equal(7, response.segments.fetch(0).id)
      assert_equal({value: 1}, response[:future])
      assert_equal("req_audio_format", response._request_id)
      assert_match(/name="response_format".*?\r\n\r\nverbose_json\r\n/m, transport.requests.last.body.to_a.join)
    end
  end

  def test_empty_transcription_segments_follow_the_effective_rich_format
    body = JSON.generate(duration: 1.25, language: "en", task: "transcribe", text: "hello", segments: [])
    [
      [:diarized_json, {}, OpenAI::Audio::TranscriptionDiarized],
      ["diarized_json", {}, OpenAI::Audio::TranscriptionDiarized],
      [:verbose_json, {extra_body: {response_format: :diarized_json}}, OpenAI::Audio::TranscriptionDiarized],
      [:verbose_json, {extra_body: {"response_format" => "diarized_json"}}, OpenAI::Audio::TranscriptionDiarized],
      [:diarized_json, {extra_body: {response_format: :verbose_json}}, OpenAI::Audio::TranscriptionVerbose],
      [:diarized_json, {extra_body: {"response_format" => "verbose_json"}}, OpenAI::Audio::TranscriptionVerbose]
    ].each do |format, options, expected|
      client, = client_for(body)
      response = client.audio.transcriptions.create(
        **audio_params,
        response_format: format,
        request_options: {**options, include_raw_body: true}
      )

      assert_instance_of(expected, response)
      assert_empty(response.segments)
      assert_equal(body, response.last_response.body)
      assert_equal("req_audio_format", response.last_response.request_id)
    end
  end

  def test_diarized_override_preserves_typed_segments_and_future_fields
    body = JSON.generate(
      duration: 1.25,
      task: "transcribe",
      text: "hello",
      segments: [diarized_segment],
      future: {value: 1}
    )
    client, transport = client_for(body)
    response = client.audio.transcriptions.create(
      **audio_params,
      request_options: OpenAI::RequestOptions.new(extra_body: {"response_format" => "diarized_json"})
    )

    assert_instance_of(OpenAI::Audio::TranscriptionDiarized, response)
    segment = response.segments.fetch(0)
    assert_instance_of(OpenAI::Audio::TranscriptionDiarizedSegment, segment)
    assert_equal("seg_1", segment.id)
    assert_equal("A", segment.speaker)
    assert_equal({value: 1}, response[:future])
    assert_match(/name="response_format".*?\r\n\r\ndiarized_json\r\n/m, transport.requests.last.body.to_a.join)
  end

  def test_missing_speaker_falls_back_to_basic_with_overrides
    body = JSON.generate(
      duration: 1.25,
      task: "transcribe",
      text: "hello",
      segments: [diarized_segment.except(:speaker)]
    )
    [{response_format: :diarized_json}, {"response_format" => "diarized_json"}].each do |extra_body|
      client, = client_for(body)
      response = client.audio.transcriptions.create(
        **audio_params,
        response_format: :json,
        request_options: {extra_body: extra_body}
      )

      assert_instance_of(OpenAI::Audio::Transcription, response)
      assert_instance_of(Hash, response[:segments].fetch(0))
      assert_equal("seg_1", response[:segments].fetch(0).fetch(:id))
    end
  end

  def test_translation_default_json_and_future_formats_keep_aggregate_fallback
    body = JSON.generate(duration: 1.25, language: "english", text: "hello", segments: [])
    [
      {},
      {response_format: :json},
      {response_format: "future_format"},
      {response_format: :verbose_json, request_options: {extra_body: {response_format: :json}}},
      {response_format: :verbose_json, request_options: {extra_body: {"response_format" => "json"}}}
    ].each do |params|
      client, = client_for(body)
      response = client.audio.translations.create(**audio_params, **params)

      assert_instance_of(OpenAI::Audio::Translation, response)
      assert_equal(1.25, response[:duration])
    end
  end

  def test_plaintext_overrides_keep_string_io
    ["text", "srt", "vtt"].each do |format|
      client, = client_for("synthetic plaintext", content_type: "text/plain")
      options = {extra_body: {"response_format" => format}}
      [client.audio.transcriptions, client.audio.translations].each do |resource|
        response = resource.create(**audio_params, response_format: :verbose_json, request_options: options)

        assert_instance_of(StringIO, response)
        assert_equal("synthetic plaintext", response.read)
        refute_respond_to(response, :last_response)
      end
    end
  end

  private def client_for(body, content_type: "application/json")
    transport = Capture.new(body, content_type: content_type)
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "fake-api-key", http_client: transport)
    [client, transport]
  end

  private def audio_params = {file: StringIO.new("synthetic audio"), model: :"whisper-1"}

  private def verbose_segment
    {
      id: 7,
      avg_logprob: -0.1,
      compression_ratio: 1.0,
      end: 1.25,
      no_speech_prob: 0.0,
      seek: 0,
      start: 0.0,
      temperature: 0.0,
      text: "hello",
      tokens: [1]
    }
  end

  private def diarized_segment
    {id: "seg_1", end: 1.25, speaker: "A", start: 0.0, text: "hello", type: "transcript.text.segment"}
  end
end

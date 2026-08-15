# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Realtime::TranslationsTest < Minitest::Test
  class StubHTTPClient < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(*responses)
      super()
      @responses = responses
      @requests = []
    end

    def execute(request)
      @requests << request
      @responses.shift
    end
  end

  class FakeSocket
    attr_reader :writes

    def initialize(*reads)
      @reads = reads
      @writes = []
      @closed = false
    end

    def read = @reads.shift
    def write(message) = @writes << message
    def closed? = @closed
    def close(code: 1000, reason: "") = (@closed = [code, reason].any?)
  end

  class FakeTransport
    attr_reader :url

    def initialize(socket)
      @socket = socket
    end

    def open(url:, **_options)
      @url = url
      yield(@socket)
    end
  end

  def test_create_client_secret
    http_client = StubHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          value: "ek_test",
          expires_at: 123,
          session: {
            id: "sess_123",
            type: "translation",
            model: "gpt-realtime-translate",
            expires_at: 456,
            audio: {}
          }
        )
      )
    )
    client = OpenAI::Client.new(api_key: "test-key", http_client: http_client)

    response = client.realtime.translations.client_secrets.create(
      session: {
        model: "gpt-realtime-translate",
        audio: {output: {language: "es"}}
      }
    )

    refute_respond_to(client.realtime.translations, :calls)
    assert_instance_of(OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse, response)
    assert_equal("ek_test", response.value)
    request = http_client.requests.fetch(0)
    assert_equal("/v1/realtime/translations/client_secrets", request.url.path)
    assert_equal(
      {
        session: {
          model: "gpt-realtime-translate",
          audio: {output: {language: "es"}}
        }
      },
      JSON.parse(request.body, symbolize_names: true)
    )
  end

  def test_create_client_secret_accepts_nested_string_keyed_hashes
    http_client = StubHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          value: "ek_test",
          expires_at: 123,
          session: {
            id: "sess_123",
            type: "translation",
            model: "gpt-realtime-translate",
            expires_at: 456,
            audio: {}
          }
        )
      )
    )
    client = OpenAI::Client.new(api_key: "test-key", http_client: http_client)

    client.realtime.translations.client_secrets.create(
      session: {
        "model" => "gpt-realtime-translate",
        "audio" => {"output" => {"language" => "es"}}
      },
      expires_after: {"anchor" => "created_at", "seconds" => 60}
    )

    request = http_client.requests.fetch(0)
    assert_equal(
      {
        session: {
          model: "gpt-realtime-translate",
          audio: {output: {language: "es"}}
        },
        expires_after: {anchor: "created_at", seconds: 60}
      },
      JSON.parse(request.body, symbolize_names: true)
    )
  end

  def test_create_client_secret_rejects_an_invalid_session_before_http
    http_client = StubHTTPClient.new
    client = OpenAI::Client.new(api_key: "test-key", http_client: http_client)

    error = assert_raises(ArgumentError) do
      client.realtime.translations.client_secrets.create(session: {audio: {}})
    end

    assert_includes(error.message, "missing required fields")
    assert_empty(http_client.requests)
  end

  def test_connect_translation_session_with_typed_events_and_helpers
    socket = FakeSocket.new(
      JSON.generate(
        type: "session.output_transcript.delta",
        event_id: "event_1",
        delta: "hola",
        item_id: "item_1"
      )
    )
    transport = FakeTransport.new(socket)
    client = OpenAI::Client.new(api_key: "test-key")
    event = nil

    client.realtime.translations.connect(
      model: "gpt-realtime-translate",
      transport: transport
    ) do |connection|
      assert_instance_of(OpenAI::Realtime::TranslationConnection, connection)
      refute_respond_to(connection, :response)
      refute_respond_to(connection, :conversation)
      refute_respond_to(connection, :output_audio_buffer)
      assert_respond_to(connection.session, :close)
      refute_respond_to(connection.input_audio_buffer, :commit)
      refute_respond_to(connection.input_audio_buffer, :clear)
      connection.session.update(audio: {output: {language: "es"}})
      connection.input_audio_buffer.append_bytes("\x00\x01".b)
      connection.session.close
      event = connection.receive
    end

    assert_equal(
      "wss://api.openai.com/v1/realtime/translations?model=gpt-realtime-translate",
      transport.url.to_s
    )
    assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent, event)
    assert_equal("hola", event.delta)
    assert_equal(
      [
        "session.update",
        "session.input_audio_buffer.append",
        "session.close"
      ],
      socket.writes.map { JSON.parse(_1).fetch("type") }
    )
  end

  def test_translation_connection_accepts_nested_string_keyed_client_events
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    client = OpenAI::Client.new(api_key: "test-key")
    event = JSON.parse(
      JSON.generate(
        type: "session.update",
        session: {audio: {output: {language: "es"}}}
      )
    )

    client.realtime.translations.connect(
      model: "gpt-realtime-translate",
      transport: transport
    ) do |connection|
      connection.send_event(event)
    end

    sent = JSON.parse(socket.writes.fetch(0))
    assert_equal("session.update", sent.fetch("type"))
    assert_equal("es", sent.dig("session", "audio", "output", "language"))
  end

  def test_connect_requires_a_block
    client = OpenAI::Client.new(api_key: "test-key")

    error = assert_raises(ArgumentError) do
      client.realtime.translations.connect(model: "gpt-realtime-translate")
    end

    assert_includes(error.message, "block is required")
  end
end

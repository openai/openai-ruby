# frozen_string_literal: true

require_relative "../test_helper"
require "async/http/endpoint"
require "async/http/server"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "socket"

class OpenAI::Test::RealtimeTranslationTransportTest < Minitest::Test
  extend Minitest::Serial

  def test_real_translation_handshake_update_input_audio_flush_output_and_close
    accepted = Queue.new
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback) do |socket|
      socket.write(
        JSON.generate(
          type: "session.created",
          event_id: "c1",
          session: {
            id: "rt_fake",
            type: "translation",
            model: "gpt-realtime-translate",
            expires_at: 2_000_000_000,
            audio: {}
          }
        )
      )
      socket.flush
      3.times { wire << JSON.parse(socket.read.to_str) }
      [
        {type: "error", event_id: "e1", error: {type: "invalid_request_error", message: "fake-test-warning"}},
        {type: "session.input_transcript.delta", event_id: "i1", delta: "hello"},
        {type: "session.output_transcript.delta", event_id: "o1", delta: "bon"},
        {type: "session.output_audio.delta", event_id: "a1", delta: "AA==", sample_rate: 24000},
        {type: "session.output_transcript.delta", event_id: "o2", delta: "jour"},
        {type: "session.closed", event_id: "s1"}
      ].each { |event| socket.write(JSON.generate(event)) }
      socket.flush
    end

    app = lambda do |request|
      accepted <<
        [request.method, request.path, request.headers["authorization"], request.headers["x-translation-test"]]
      websocket.call(request)
    end

    server = Async::HTTP::Server.new(app, endpoint)
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        transcript = api
          .realtime
          .connect_translation(
            model: "gpt-realtime-translate",
            request_options: {extra_headers: {"Authorization" => "Bearer fake-override", "X-Translation-Test" => "yes"}}
          ) do |connection|
            assert_equal(
              ["GET", "/v1/realtime/translations?model=gpt-realtime-translate", "Bearer fake-override", ["yes"]],
              accepted.pop(timeout: 1)
            )
            assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent, connection.receive)
            assert_predicate(wire, :empty?)
            connection.send_event(type: "session.update", session: {audio: {output: {language: "fr"}}})
            connection.send_event(OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent.new(audio: "AA=="))
            connection.send_event(type: "session.close")
            text = +""
            heard = +""
            connection.each do |event|
              case event
              when OpenAI::Realtime::RealtimeErrorEvent
                refute_predicate(connection, :closed?)
              when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
                text << event.delta
              when OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
                heard << event.delta
              when OpenAI::Realtime::RealtimeTranslationInputTranscriptDeltaEvent
                assert_equal("hello", event.delta)
              when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
                break
              end
            end

            assert_equal("AA==", heard)
            text
          end

        assert_equal("bonjour", transcript)
      end

      sent = 3.times.map { wire.pop(timeout: 1) }
      assert_equal(
        ["session.update", "session.input_audio_buffer.append", "session.close"],
        sent.map { _1.fetch("type") }
      )
      assert_equal("fr", sent.first.dig("session", "audio", "output", "language"))
    ensure
      server_task&.stop
    end
  end
end

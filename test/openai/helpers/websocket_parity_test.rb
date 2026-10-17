# frozen_string_literal: true

require_relative "../test_helper"
require "async/http/endpoint"
require "async/http/server"
require "async/websocket/server"
require "async/websocket/adapters/http"
require "socket"

class OpenAI::Test::WebSocketParityTest < Minitest::Test
  extend Minitest::Serial

  class HookClient < OpenAI::Client
    private def prepare_request(request, **options)
      super.merge(headers: request.fetch(:headers).merge("x-request-hook" => "called"))
    end
  end

  def test_beta_responses_uses_beta_types_and_preserves_connection_after_response
    frames = [
      {type: "response.inject.created", response_id: "resp_beta", sequence_number: 7, stream_id: "stream_beta"},
      {
        type: "response.completed",
        sequence_number: 8,
        response: {
          id: "resp_beta",
          status: "completed",
          created_at: 1.0,
          object: "response",
          model: "synthetic",
          output: [],
          parallel_tool_calls: false,
          tool_choice: "auto",
          tools: [],
          access_programs: nil,
          error: nil,
          incomplete_details: nil,
          instructions: nil,
          metadata: nil,
          temperature: nil,
          top_p: nil
        }
      },
      {type: "future.beta.event", marker: 42}
    ]
    with_socket(frames, "/v1/responses?test=beta", commands: 1) do |client, sent|
      client.beta.responses.connect(query: {test: "beta"}) do |connection|
        connection.send_event(type: "response.inject", response_id: "resp_beta", input: [])
        event = connection.receive
        assert_instance_of(OpenAI::Beta::BetaResponseInjectCreatedEvent, event)
        assert_equal("resp_beta", event.response_id)
        assert_equal("stream_beta", event.stream_id)
        assert_equal(7, event.sequence_number)
        assert_equal(:"response.completed", connection.receive.type)
        assert_equal({type: "future.beta.event", marker: 42}, connection.receive)
        refute_predicate(connection, :closed?)
      end

      assert_equal({"type" => "response.inject", "response_id" => "resp_beta", "input" => []}, sent.pop(timeout: 1))
    end
  end

  def test_direct_translation_binding_keeps_typed_events_and_request_policy
    frames = [
      {type: "session.output_transcript.delta", event_id: "delta", delta: "bonjour"},
      {type: "session.closed", event_id: "closed"},
      {type: "future.translation.event", marker: 42}
    ]
    with_socket(frames, "/v1/realtime/translations?model=synthetic", commands: 1) do |client, sent|
      client.realtime.translations.connect(query: {model: "synthetic"}) do |connection|
        connection.send_event(type: "session.close")
        event = connection.receive
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent, event)
        assert_equal("bonjour", event.delta)
        assert_equal(:"session.closed", connection.receive.type)
        assert_equal({type: "future.translation.event", marker: 42}, connection.receive)
      end

      assert_equal({"type" => "session.close"}, sent.pop(timeout: 1))
    end
  end

  def test_sideband_keeps_existing_event_classes_and_transport_payloads
    frames = [
      {type: "session.input_audio.append", audio: "AAE="},
      {type: "transport.dtmf.received", event_id: "r1", event: "5"},
      {type: "transport.dtmf.send", event_id: "s1", event: "#", client_event_id: "command1"},
      {type: "transport.ringing", event_id: "r2", session_id: "live_test"},
      {type: "transport.answered", event_id: "a1", session_id: "live_test"},
      {
        type: "transport.failed",
        event_id: "f1",
        session_id: "live_test",
        error: {type: "call_error", code: "provider_invite_failed", message: "synthetic failure", param: nil}
      },
      # Null is outside the server schema; retain the existing lenient decode behavior.
      {type: "transport.dtmf.send", event_id: "s2", event: "#", client_event_id: nil},
      {type: "transport.dtmf.send", event_id: "s3", event: "#"},
      {type: "session.output_audio.delta", delta: "AAE=", start_ms: 10, end_ms: 20},
      {type: "future.transport.event", marker: 42}
    ]
    with_socket(frames, "/v1/live/sessions/live_test/attach") do |client, _sent|
      client.live.sideband.connect("live_test") do |connection|
        events = frames.map { connection.receive }
        assert_instance_of(OpenAI::Live::ServerEvent::SessionInputAudioAppend, events[0])
        assert_equal("AAE=", events[0].audio)
        assert_equal("5", events[1].event)
        assert_equal("command1", events[2].client_event_id)
        assert_equal("live_test", events[3].session_id)
        assert_equal("live_test", events[4].session_id)
        assert_equal("synthetic failure", events[5].error.message)
        assert_nil(events[6].client_event_id)
        assert_nil(events[7].client_event_id)
        assert_instance_of(OpenAI::Live::OutputAudioDeltaEvent, events[8])
        assert_equal(["AAE=", 10, 20], [events[8].delta, events[8].start_ms, events[8].end_ms])
        assert_instance_of(OpenAI::Live::UnknownServerEvent, events[9])
      end
    end
  end

  private def with_socket(frames, expected_path, commands: 0)
    sent = Queue.new
    requests = Queue.new
    closed = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    websocket = Async::WebSocket::Server.new(-> (_) { Protocol::HTTP::Response[404, {}, []] }) do |socket|
      commands.times { sent << JSON.parse(socket.read.to_str) }
      frames.each { socket.write(JSON.generate(_1)) }
      socket.flush
      closed << socket.read
    end

    server = Async::HTTP::Server.new(
      lambda { |request|
        requests << [request.path, request.headers["authorization"], request.headers["x-request-hook"]]
        websocket.call(request)
      },
      endpoint
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      client = HookClient.new(api_key: "synthetic", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) { yield client, sent }
      assert_equal([expected_path, "Bearer synthetic", ["called"]], requests.pop(timeout: 1))
      assert_nil(closed.pop(timeout: 1))
    ensure
      server_task&.stop
    end
  end
end

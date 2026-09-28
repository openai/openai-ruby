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
            assert_nil(connection.send_event(type: "session.update", session: {audio: {output: {language: "fr"}}}))
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

  def test_finish_retains_trailing_output_once_on_the_existing_reader
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback) do |socket|
      # Backpressure: each audio write makes input and output progress together.
      3.times do |i|
        wire << JSON.parse(socket.read.to_str)
        socket.write(JSON.generate(type: "session.input_transcript.delta", event_id: "i#{i}", delta: i.to_s))
        socket.flush
      end

      wire << JSON.parse(socket.read.to_str)
      [
        {type: "session.output_transcript.delta", event_id: "o1", delta: "bon"},
        {type: "error", event_id: "e1", error: {type: "invalid_request_error", message: "not stored"}},
        {type: "future.translation.result", items: [nil, "future"]},
        {type: "session.output_audio.delta", event_id: "a1", delta: "AA==", sample_rate: 24_000},
        {type: "session.output_transcript.delta", event_id: "o2", delta: "jour"},
        {type: "session.closed", event_id: "s1"}
      ].each { |event| socket.write(JSON.generate(event)) }
      socket.flush
      wire << [:eof, socket.read]
    end

    server = Async::HTTP::Server.new(websocket, endpoint)
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        api.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
          sender = task.async do
            3.times { connection.send_event(type: "session.input_audio_buffer.append", audio: "AA==") }
          end

          3.times do |i|
            assert_equal(i.to_s, connection.receive.delta)
          end

          sender.wait
          trailing = []
          terminal = connection.finish(timeout: 2) do |event|
            trailing << event
            if trailing.size == 1
              # Even a rejected send during drain must not poison the reader.
              assert_raises(OpenAI::Errors::TranslationConnectionError) do
                connection.send_event(type: "session.input_audio_buffer.append", audio: "AQ==")
              end

              other_reader = task.async do
                assert_raises(OpenAI::Errors::TranslationConnectionError) { connection.receive }
                assert_raises(OpenAI::Errors::TranslationConnectionError) { connection.receive_raw }
              end

              other_reader.wait
            end
          end

          assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent, terminal)
          assert_equal(
            %w[
              session.output_transcript.delta
              error
              future.translation.result
              session.output_audio.delta
              session.output_transcript.delta
              session.closed
            ],
            trailing.map { |event| event.type.to_s }
          )
          assert_equal(
            "bonjour",
            trailing.grep(OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent).map(&:delta).join
          )
          assert_same(terminal, connection.finish(timeout: 2) { flunk("finish must not redeliver or resend") })
          refute_predicate(connection, :closed?)
        end

        assert_equal(
          %w[
            session.input_audio_buffer.append
            session.input_audio_buffer.append
            session.input_audio_buffer.append
            session.close
          ],
          4.times.map { wire.pop(timeout: 1).fetch("type") }
        )
        assert_equal([:eof, nil], wire.pop(timeout: 1))
        assert_predicate(wire, :empty?)
      end

    ensure
      server_task&.stop
    end
  end

  def test_finish_early_eof_is_not_success_and_does_not_replay_on_a_new_socket
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    server = Async::HTTP::Server.new(
      Async::WebSocket::Server.new(fallback) do |socket|
        wire << JSON.parse(socket.read.to_str)
        socket.write(JSON.generate(type: "session.output_transcript.delta", event_id: "o1", delta: "last"))
        socket.flush
      end,
      endpoint
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        observed = []
        api.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
          err = assert_raises(OpenAI::Errors::TranslationConnectionError) do
            connection.finish(timeout: 1) { |event| observed << event }
          end

          assert_match(/before session.closed/, err.message)
          assert_equal(["last"], observed.map(&:delta))
          assert_raises(OpenAI::Errors::TranslationConnectionError) { connection.finish(timeout: 1) { flunk } }
        end

        assert_equal({"type" => "session.close"}, wire.pop(timeout: 1))
        assert_predicate(wire, :empty?)
      end

    ensure
      server_task&.stop
    end
  end

  def test_finish_bounds_a_peer_that_never_acknowledges_and_does_not_resend
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    server = Async::HTTP::Server.new(
      Async::WebSocket::Server.new(fallback) do |socket|
        wire << JSON.parse(socket.read.to_str)
        # No terminal event. Wait until caller-owned cleanup releases this peer.
        wire << [:eof, socket.read]
      end,
      endpoint
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(3) do
        api.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
          first = assert_raises(Timeout::Error) do
            connection.finish(timeout: 0.025) { flunk("peer never sent events") }
          end

          second = assert_raises(Timeout::Error) do
            connection.finish(timeout: 1) { flunk("retry must not reopen or read") }
          end

          assert_same(first, second)
          assert_equal({"type" => "session.close"}, wire.pop(timeout: 1))
        end

        assert_equal([:eof, nil], wire.pop(timeout: 1))
        assert_predicate(wire, :empty?)
      end

    ensure
      server_task&.stop
    end
  end

  def test_finish_cannot_steal_a_pending_receive_and_bad_timeout_does_not_write
    wire = Queue.new
    release = Async::Condition.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    server = Async::HTTP::Server.new(
      Async::WebSocket::Server.new(fallback) do |socket|
        release.wait
        socket.write(JSON.generate(type: "session.input_transcript.delta", event_id: "i0", delta: "ready"))
        socket.flush
        wire << JSON.parse(socket.read.to_str)
        socket.write(JSON.generate(type: "session.closed", event_id: "s1"))
        socket.flush
        wire << [:eof, socket.read]
      end,
      endpoint
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        api.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
          assert_raises(ArgumentError) { connection.finish(timeout: 1) }
          [0, -1, Float::NAN, Float::INFINITY].each do |timeout|
            assert_raises(ArgumentError) { connection.finish(timeout: timeout) { flunk } }
          end

          reader = task.async { connection.receive }
          error = assert_raises(OpenAI::Errors::TranslationConnectionError) do
            connection.finish(timeout: 1) { flunk("must not add a second reader") }
          end

          assert_match(/receive owner/, error.message)
          assert_predicate(wire, :empty?)
          release.signal
          assert_equal("ready", reader.wait.delta)
          received = []
          terminal = connection.finish(timeout: 1) { |event| received << event }
          assert_equal([terminal], received)
        end

        assert_equal({"type" => "session.close"}, wire.pop(timeout: 1))
        assert_equal([:eof, nil], wire.pop(timeout: 1))
        assert_predicate(wire, :empty?)
      end

    ensure
      server_task&.stop
    end
  end

  def test_consumer_cancellation_during_finish_keeps_original_exception
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    server = Async::HTTP::Server.new(
      Async::WebSocket::Server.new(fallback) do |socket|
        wire << JSON.parse(socket.read.to_str)
        socket.write(JSON.generate(type: "session.output_transcript.delta", event_id: "o0", delta: "trailing"))
        socket.flush
        begin
          wire << [:eof, socket.read]
        rescue EOFError => error
          wire << [:aborted, error.class]
        end
      end,
      endpoint
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "fake-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        cancelled = Timeout::Error.new("consumer's own timeout")
        raised = assert_raises(cancelled.class) do
          api.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
            connection.finish(timeout: 1) do |event|
              assert_equal("trailing", event.delta)
              raise cancelled
            end
          end
        end

        assert_same(cancelled, raised)
        assert_equal({"type" => "session.close"}, wire.pop(timeout: 1))
        assert_equal([:aborted, EOFError], wire.pop(timeout: 1))
        assert_predicate(wire, :empty?)
      end

    ensure
      server_task&.stop
    end
  end
end

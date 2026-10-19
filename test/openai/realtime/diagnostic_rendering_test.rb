# frozen_string_literal: true

require "async/websocket/client"
require "pp"

require_relative "connection_test_support"

class OpenAI::Test::RealtimeDiagnosticRenderingTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::RealtimeConnectionTestSupport

  class FailingConnection
    def initialize(error) = @error = error
    def read = raise @error
    def write(_data) = raise @error
    def close(*) = raise @error
    def abort = raise @error
    def framer = self
    def closed? = false
  end

  def test_unknown_event_rendering_omits_remote_values_but_preserves_explicit_access
    data = {type: "future.synthetic_type_marker", nested: {transcript: "synthetic_payload_marker"}}
    [:realtime, :transcription, :sideband, :translation].each do |kind|
      event = connect(kind, FakeTransport.new(FakeSocket.new(JSON.generate(data))), &:receive)

      assert_equal(data, event.data)
      assert_same(event.data, event.to_h)
      assert_equal(data.fetch(:type).to_sym, event.type)
      assert_predicate(event, :frozen?)
      assert_predicate(event.data.fetch(:nested), :frozen?)
      [event.inspect, event.to_s, PP.pp(event, +"")].each do |rendered|
        assert_includes(rendered, event.class.name)
        refute_includes(rendered, "synthetic_type_marker")
        refute_includes(rendered, "synthetic_payload_marker")
      end
    end
  end

  def test_protocol_error_rendering_omits_parser_input_but_retains_data_and_cause
    data = "synthetic_parser_marker"
    [:realtime, :transcription, :sideband].each do |kind|
      error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
        connect(kind, FakeTransport.new(FakeSocket.new(data)), &:receive)
      end

      assert_equal(data, error.data)
      assert_instance_of(JSON::ParserError, error.cause)
      assert_includes(error.cause.message, "synthetic_parser_marker")
      assert_safe_error_rendering(error, "synthetic_parser_marker")
    end
  end

  def test_protocol_error_rendering_omits_an_ambient_exception
    data = JSON.generate(type: "response.output_text.delta")
    [:realtime, :transcription, :sideband].each do |kind|
      error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
        connect(kind, FakeTransport.new(FakeSocket.new)) do |connection|
          begin
            raise IOError, "synthetic_ambient_marker"
          rescue IOError
            connection.parse_event(data)
          end
        end
      end

      assert_equal(data, error.data)
      assert_instance_of(ArgumentError, error.cause)
      assert_includes(error.cause.message, "required fields")
      assert_safe_error_rendering(error, "synthetic_ambient_marker")
    end
  end

  def test_socket_error_rendering_omits_native_causes_but_preserves_the_original
    [:realtime, :transcription, :sideband].each do |kind|
      [:read, :write, :close, :abort].each do |operation|
        cause = IOError.new("synthetic_transport_marker")
        socket = OpenAI::Realtime::Transports::AsyncWebSocket::Socket.new(
          FailingConnection.new(cause),
          url: URI("wss://example.com/v1/realtime")
        )
        error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
          connect(kind, FakeTransport.new(socket)) do |connection|
            case operation
            when :read
              connection.receive
            when :write
              connection.send_raw("{\"type\":\"response.cancel\"}")
            when :close
              connection.close
            when :abort
              connection.abort
            end
          end
        end

        assert_same(cause, error.cause)
        assert_safe_error_rendering(error, "synthetic_transport_marker")
      end
    end
  end

  def test_open_error_rendering_omits_native_causes_but_preserves_the_original
    cause = IOError.new("synthetic_handshake_marker")
    Async::WebSocket::Client.stub(:open, -> (*) { raise cause }) do
      error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
        client.realtime.connect(model: "gpt-realtime-2.1") { flunk("must not connect") }
      end

      assert_same(cause, error.cause)
      assert_safe_error_rendering(error, "synthetic_handshake_marker")
    end
  end

  def test_closed_send_errors_omit_ambient_causes
    [:realtime, :transcription, :sideband, :translation].each do |kind|
      connect(kind, FakeTransport.new(FakeSocket.new)) do |connection|
        connection.close
        assert_safe_state_error { connection.send_raw("{}") }
      end
    end
  end

  def test_failed_read_errors_omit_ambient_causes
    [:realtime, :transcription, :sideband].each do |kind|
      socket = FakeSocket.new
      socket.define_singleton_method(:write) { |_text| raise IOError, "synthetic_write_failure" }
      connect(kind, FakeTransport.new(socket)) do |connection|
        assert_raises(IOError) { connection.send_raw("{}") }
        assert_safe_state_error { connection.receive }
      end
    end
  end

  def test_translation_finish_owner_and_finished_send_errors_omit_ambient_causes
    terminal = JSON.generate(type: "session.closed", event_id: "synthetic_closed")
    connect(:translation, FakeTransport.new(FakeSocket.new(terminal))) do |connection|
      connection.finish(timeout: 1) do |_event|
        assert_safe_state_error { connection.finish(timeout: 1) { flunk("must not consume another event") } }
        assert_safe_state_error { connection.send_raw("{}") }
        Fiber.new { assert_safe_state_error { connection.receive } }.resume
      end

      assert_safe_state_error { connection.send_raw("{}") }
    end
  end

  def test_translation_unfinished_close_errors_omit_ambient_causes
    connect(:translation, FakeTransport.new(FakeSocket.new)) do |connection|
      assert_safe_state_error { connection.finish(timeout: 1) { flunk("must not consume an event") } }
      assert_safe_state_error { connection.finish(timeout: 1) { flunk("must not consume an event") } }
    end
  end

  def test_translation_cached_callback_failure_preserves_its_original_cause
    terminal = JSON.generate(type: "session.closed", event_id: "synthetic_closed")
    cause = IOError.new("synthetic_callback_cause")
    connect(:translation, FakeTransport.new(FakeSocket.new(terminal))) do |connection|
      original = assert_raises(RuntimeError) do
        connection.finish(timeout: 1) { raise RuntimeError.new("synthetic_callback_failure"), cause: cause }
      end

      replayed = assert_raises(RuntimeError) do
        begin
          raise IOError, "synthetic_ambient_callback_marker"
        rescue IOError
          connection.finish(timeout: 1) { flunk("must not replay a callback") }
        end
      end

      assert_same(original, replayed)
      assert_same(cause, replayed.cause)
      refute_includes(replayed.full_message(highlight: false), "synthetic_ambient_callback_marker")
    end
  end

  def test_translation_cached_sdk_callback_failure_keeps_diagnostics_explicit
    terminal = JSON.generate(type: "session.closed", event_id: "synthetic_closed")
    connect(:realtime, FakeTransport.new(FakeSocket.new("synthetic_callback_parser_marker"))) do |standard|
      connect(:translation, FakeTransport.new(FakeSocket.new(terminal))) do |translation|
        original = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
          translation.finish(timeout: 1) { standard.receive }
        end

        assert_safe_error_rendering(original, "synthetic_callback_parser_marker")
        replayed = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
          translation.finish(timeout: 1) { flunk("must not replay a callback") }
        end

        assert_same(original, replayed)
        assert_instance_of(JSON::ParserError, replayed.cause)
        assert_equal("synthetic_callback_parser_marker", replayed.data)
        assert_safe_error_rendering(replayed, "synthetic_callback_parser_marker")
      end
    end
  end

  def test_translation_escaping_sdk_callback_failure_keeps_diagnostics_explicit
    terminal = JSON.generate(type: "session.closed", event_id: "synthetic_closed")
    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) do
      connect(:realtime, FakeTransport.new(FakeSocket.new("synthetic_callback_parser_marker"))) do |standard|
        connect(:translation, FakeTransport.new(FakeSocket.new(terminal))) do |translation|
          translation.finish(timeout: 1) { standard.receive }
        end
      end
    end

    assert_instance_of(JSON::ParserError, error.cause)
    assert_equal("synthetic_callback_parser_marker", error.data)
    assert_safe_error_rendering(error, "synthetic_callback_parser_marker")
  end

  private def assert_safe_state_error
    error = assert_raises(OpenAI::Errors::WebSocketConnectionError) do
      begin
        raise IOError, "synthetic_ambient_state_marker"
      rescue IOError
        yield
      end
    end

    assert_nil(error.cause)
    assert_safe_error_rendering(error, "synthetic_ambient_state_marker")
  end

  private def assert_safe_error_rendering(error, marker)
    [
      error.message,
      error.to_s,
      error.inspect,
      PP.pp(error, +""),
      error.full_message(highlight: false),
      error.full_message(highlight: false, order: :bottom)
    ].each { |rendered| refute_includes(rendered, marker) }
  end

  private def connect(kind, transport, &block)
    case kind
    when :realtime
      client.realtime.connect(model: "gpt-realtime-2.1", transport: transport, &block)
    when :transcription
      client.realtime.connect_transcription(transport: transport, &block)
    when :sideband
      client.realtime.connect_to_call(call_id: "rtc_synthetic", transport: transport, &block)
    when :translation
      client.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport, &block)
    end
  end
end

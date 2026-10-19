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
    [:realtime, :transcription, :sideband].each do |kind|
      event = connect(kind, FakeTransport.new(FakeSocket.new(JSON.generate(data))), &:receive)

      assert_equal(data, event.data)
      assert_same(event.data, event.to_h)
      assert_equal(data.fetch(:type).to_sym, event.type)
      assert_predicate(event, :frozen?)
      assert_predicate(event.data.fetch(:nested), :frozen?)
      [event.inspect, event.to_s, PP.pp(event, +"")].each do |rendered|
        assert_includes(rendered, "UnknownServerEvent")
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
    end
  end
end

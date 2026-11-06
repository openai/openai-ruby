# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::TranslationCodecCompatibilityTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  MODES = [:specialized, :generic].freeze

  def test_known_events_and_commands_preserve_types_extensions_and_request_shapes
    MODES.each do |mode|
      socket = FakeSocket.new(JSON.generate(type: "session.output_transcript.delta", event_id: "e", delta: "synthetic"))
      transport = FakeTransport.new(socket)
      result = connect(mode, transport) do |connection|
        assert_empty(socket.writes)
        event = connection.receive
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent, event)
        assert_equal("synthetic", event.delta)
        connection.send_event(type: "session.input_audio_buffer.append", audio: "AA==", extra: {label: "keep"})
        connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
        :result
      end

      assert_equal(:result, result)
      assert_equal("/v1/realtime/translations", transport.open_args.fetch(:url).path)
      assert_equal([["model", "synthetic"]], URI.decode_www_form(transport.open_args.fetch(:url).query))
      assert_equal(
        [
          {"type" => "session.input_audio_buffer.append", "audio" => "AA==", "extra" => {"label" => "keep"}},
          {"type" => "session.close"}
        ],
        socket.writes.map { JSON.parse(_1) }
      )
      assert_predicate(socket, :closed?)
    end
  end

  def test_unknown_event_result_and_helper_visibility_remain_entrypoint_specific
    MODES.each do |mode|
      payload = {type: "future.translation", extra: {values: ["synthetic"]}}
      socket = FakeSocket.new(JSON.generate(payload))
      connect(mode, FakeTransport.new(socket)) do |connection|
        event = connection.receive
        if mode == :specialized
          assert_instance_of(OpenAI::Realtime::UnknownTranslationServerEvent, event)
          assert_equal(payload, event.to_h)
          assert_predicate(event.data.fetch(:extra).fetch(:values), :frozen?)
          assert_respond_to(connection, :finish)
          refute_respond_to(connection, :parse_event)
        else
          assert_instance_of(Hash, event)
          assert_equal(payload, event)
          refute_predicate(event.fetch(:extra).fetch(:values), :frozen?)
          refute_respond_to(connection, :finish)
          assert_respond_to(connection, :parse_event)
        end
      end
    end
  end

  def test_invalid_frames_and_commands_keep_error_classes_messages_and_connection_reuse
    MODES.each do |mode|
      socket = FakeSocket.new(
        "{",
        JSON.generate(type: "session.output_transcript.delta", event_id: "e"),
        JSON.generate(type: "session.closed", event_id: "closed")
      )
      connect(mode, FakeTransport.new(socket)) do |connection|
        2.times do
          error = assert_raises(protocol_error_class(mode)) { connection.receive }
          assert_equal(protocol_error_class(mode), error.class)
          assert_equal(
            mode == :specialized ? "Invalid Realtime Translation WebSocket event." : "Invalid WebSocket server event.",
            error.message
          )
          assert_nil(error.cause)
          refute_predicate(connection, :closed?)
        end

        error = assert_raises(ArgumentError) { connection.send_event(type: "response.create") }
        assert_equal(
          mode == :specialized ? "Invalid Realtime Translation client event." : "Invalid WebSocket client event.",
          error.message
        )
        assert_nil(error.cause)
        assert_empty(socket.writes)
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent, connection.receive)
        connection.send_event(type: "session.close")
        assert_nil(connection.receive)
        assert_predicate(connection, :closed?)
      end
    end
  end

  private def protocol_error_class(mode)
    mode == :specialized ? OpenAI::Errors::TranslationProtocolError : OpenAI::Errors::WebSocketProtocolError
  end

  private def connect(mode, transport, &block)
    if mode == :specialized
      client.realtime.connect_translation(model: "synthetic", transport: transport, &block)
    else
      client.realtime.translations.connect(query: {model: "synthetic"}, transport: transport, &block)
    end
  end
end

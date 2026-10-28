# frozen_string_literal: true

require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::LiveSharedCodecCompatibilityTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  MODES = [:primary, :sideband, :fork].freeze

  def test_all_established_sideband_commands_keep_their_wire_shapes
    commands = [
      {type: "session.update", session: {}},
      {type: "session.input_audio.mute"},
      {type: "session.input_audio.unmute"},
      {type: "session.output_audio.fixture.play", audio: "AA=="},
      {type: "session.instructions.append", content: "synthetic", delegation_id: nil},
      {type: "session.thinking.append", content: "synthetic", delegation_id: nil},
      {type: "session.commentary.append", content: "synthetic", delegation_id: nil},
      {type: "decision.create", event_id: "synthetic-event"},
      {type: "decision.item.create", item: {role: "user", content: "synthetic"}},
      {type: "decision.item.delete", item_id: "synthetic-item"},
      {
        type: "response.item.create",
        item: {type: "function_call", call_id: "synthetic", name: "lookup", arguments: "{}"}
      },
      {type: "response.create"},
      {type: "session.close"}
    ]
    socket = FakeSocket.new
    connect(:sideband, socket) do |connection|
      assert_empty(socket.writes)
      commands.each { connection.send_event(_1) }
      connection.send_event(OpenAI::Live::SessionCloseEvent.new)
    end

    assert_equal(
      commands.map { JSON.parse(JSON.generate(_1)) } + [{"type" => "session.close"}],
      socket.writes.map { JSON.parse(_1) }
    )
  end

  def test_reflected_audio_and_unknown_events_preserve_existing_public_classes
    MODES.each do |mode|
      socket = FakeSocket.new(
        JSON.generate(type: "session.input_audio.append", audio: "AA=="),
        JSON.generate(type: "future.live.event", extra: {values: ["synthetic"]})
      )
      connect(mode, socket) do |connection|
        expected = mode == :fork ? OpenAI::Live::ForkServerEvent::SessionInputAudioAppend : OpenAI::Live::ServerEvent::SessionInputAudioAppend
        assert_instance_of(expected, connection.receive)
        unknown = connection.receive
        assert_instance_of(OpenAI::Live::UnknownServerEvent, unknown)
        assert_equal({values: ["synthetic"]}, unknown.data.fetch(:extra))
        assert_predicate(unknown.data.fetch(:extra).fetch(:values), :frozen?)
        refute_respond_to(connection, :parse_event)
        assert_nil(connection.receive)
        assert_predicate(connection, :closed?)
      end
    end
  end

  def test_invalid_data_keeps_live_errors_and_allows_subsequent_valid_io
    MODES.each do |mode|
      socket = FakeSocket.new("{", JSON.generate(type: "session.input_audio.append", audio: "AA=="))
      connect(mode, socket) do |connection|
        error = assert_raises(OpenAI::Errors::LiveProtocolError) { connection.receive }
        assert_equal("Invalid Live WebSocket event.", error.message)
        assert_nil(error.cause)
        refute_predicate(connection, :closed?)

        error = assert_raises(ArgumentError) { connection.send_event(type: "synthetic.invalid", extra: "synthetic") }
        assert_equal("Invalid Live client event.", error.message)
        assert_nil(error.cause)
        assert_empty(socket.writes)
        assert_equal("AA==", connection.receive.audio)
        connection.send_event(type: "session.close")
      end

      assert_equal([{"type" => "session.close"}], socket.writes.map { JSON.parse(_1) })
    end
  end

  private def connect(mode, socket, &block)
    transport = FakeTransport.new(socket)
    case mode
    when :primary
      client.live.connect(transport: transport, &block)
    when :sideband
      client.live.sideband.connect("synthetic-session", transport: transport, &block)
    when :fork
      client.live.forks.connect("synthetic-session", transport: transport, &block)
    end
  end
end

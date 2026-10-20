# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::RealtimeClientEventValidationTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  MODES = [:standard, :transcription, :sideband].freeze

  def test_mutated_typed_events_are_rejected_before_conversion
    MODES.each do |mode|
      socket = FakeSocket.new
      connect(mode, socket) do |connection|
        changed = OpenAI::Realtime::ResponseCancelEvent.new
        changed.to_h[:type] = :"response.create"
        invalid = [
          OpenAI::Realtime::ResponseCancelEvent.new(type: :"response.create", response: {}),
          changed,
          {type: :"response.cancel", extra: [changed]}
        ]
        invalid.each do |event|
          error = assert_raises(ArgumentError, mode.to_s) { connection.send_event(event) }
          assert_equal("Invalid Realtime client event.", error.message)
          assert_instance_of(ArgumentError, error.cause)
          assert_empty(socket.writes)
          refute_predicate(connection, :closed?)
        end

        connection.send_event(OpenAI::Realtime::ResponseCancelEvent.new(type: "response.cancel"))
      end

      assert_equal([{"type" => "response.cancel"}], socket.writes.map { JSON.parse(_1) })
    end
  end

  def test_typed_wire_alias_collisions_are_rejected_without_losing_valid_renamed_fields
    MODES.each do |mode|
      socket = FakeSocket.new
      connect(mode, socket) do |connection|
        [:format, "format"].each do |wire_key|
          config = OpenAI::Realtime::RealtimeAudioConfigInput.new(
            {:format_ => {type: "audio/pcm", rate: 24_000}, wire_key => {type: "audio/pcmu"}}
          )
          assert_raises(ArgumentError, mode.to_s) do
            connection.send_event(type: :"response.cancel", config: config)
          end

          assert_empty(socket.writes)
          refute_predicate(connection, :closed?)
        end

        config = OpenAI::Realtime::RealtimeAudioConfigInput.new(format_: {type: "audio/pcm", rate: 24_000})
        connection.send_event(type: :"response.cancel", config: config)
      end

      assert_equal(
        {"type" => "audio/pcm", "rate" => 24_000},
        JSON.parse(socket.writes.fetch(0)).dig("config", "format")
      )
    end
  end

  def test_raw_extensions_and_shared_values_keep_their_existing_serialization
    MODES.each do |mode|
      socket = FakeSocket.new
      shared = {:format => "wire", :format_ => "extension", 1 => "numeric-key"}
      connect(mode, socket) do |connection|
        connection.send_event(type: :"response.cancel", first: shared, second: shared)
      end

      payload = JSON.parse(socket.writes.fetch(0))
      expected = {"format" => "wire", "format_" => "extension", "1" => "numeric-key"}
      assert_equal(expected, payload.fetch("first"))
      assert_equal(expected, payload.fetch("second"))
      refute_predicate(shared, :frozen?)
    end
  end

  private def connect(mode, socket, &block)
    transport = FakeTransport.new(socket)
    case mode
    when :standard
      client.realtime.connect(model: "synthetic", transport: transport, &block)
    when :transcription
      client.realtime.connect_transcription(transport: transport, &block)
    when :sideband
      client.realtime.connect_to_call(call_id: "synthetic-call", transport: transport, &block)
    end
  end
end

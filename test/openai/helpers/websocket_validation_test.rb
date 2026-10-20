# frozen_string_literal: true

require_relative "../responses_websocket/connection_test_support"
require "timeout"

class OpenAI::Test::WebSocketValidationTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  MODES = [:live, :sideband, :fork, :translation, :generic_translation, :beta_responses].freeze

  def test_typed_model_wire_name_collisions_are_rejected_before_writing
    MODES.each do |mode|
      socket = FakeSocket.new
      connect(mode, socket) do |connection|
        [:format, "format"].each do |wire_key|
          config = OpenAI::Realtime::RealtimeAudioConfigInput.new(
            {:format_ => {type: "audio/pcm", rate: 24_000}, wire_key => {type: "audio/pcmu"}}
          )
          error = assert_raises(ArgumentError, mode.to_s) { send_command(connection, mode, config: config) }
          assert_nil(error.cause)
          assert_empty(socket.writes)
          refute_predicate(connection, :closed?)
        end

        config = OpenAI::Realtime::RealtimeAudioConfigInput.new(format_: {type: "audio/pcm", rate: 24_000})
        send_command(connection, mode, config: config)
      end

      assert_equal(
        {"type" => "audio/pcm", "rate" => 24_000},
        JSON.parse(socket.writes.fetch(0)).dig("config", "format")
      )
    end
  end

  def test_opaque_wire_names_and_shared_values_remain_valid
    MODES.each do |mode|
      socket = FakeSocket.new
      shared = {"format" => "wire-value", "format_" => "future-value", "tags" => ["synthetic"]}
      connect(mode, socket) do |connection|
        send_command(connection, mode, first: shared, second: shared)
      end

      payload = JSON.parse(socket.writes.fetch(0))
      assert_equal(shared, payload.fetch("first"))
      assert_equal(shared, payload.fetch("second"))
      refute_predicate(shared, :frozen?)
    end
  end

  def test_cycles_constants_and_mixed_keys_are_rejected_without_poisoning
    MODES.each do |mode|
      socket = FakeSocket.new
      hash_cycle = {}
      hash_cycle[:next] = hash_cycle
      array_cycle = []
      array_cycle << array_cycle
      model_cycle = OpenAI::Live::SessionCloseEvent.new
      model_cycle.to_h[:extra] = model_cycle
      wrong_constant = OpenAI::Live::SessionCloseEvent.new(type: :"session.start")
      invalid_values = [hash_cycle, array_cycle, model_cycle, wrong_constant, {"label" => 1, :label => 2}]
      connect(mode, socket) do |connection|
        invalid_values.each do |invalid|
          error = assert_raises(ArgumentError, mode.to_s) do
            # Interrupt cannot be swallowed by the codec's StandardError rescue.
            Timeout.timeout(1, Interrupt) { send_command(connection, mode, extra: invalid) }
          end

          assert_nil(error.cause)
          assert_empty(socket.writes)
          refute_predicate(connection, :closed?)
        end

        send_command(connection, mode, extra: {value: "keep"})
      end

      assert_equal({"value" => "keep"}, JSON.parse(socket.writes.fetch(0)).fetch("extra"))
    end
  end

  private def send_command(connection, mode, **fields)
    if mode == :beta_responses
      connection.send_event(type: "response.inject", response_id: "synthetic-response", input: [], **fields)
    else
      connection.send_event(type: "session.close", **fields)
    end
  end

  private def connect(mode, socket, &block)
    transport = FakeTransport.new(socket)
    case mode
    when :live
      client.live.connect(transport: transport, &block)
    when :sideband
      client.live.sideband.connect("synthetic-session", transport: transport, &block)
    when :fork
      client.live.forks.connect("synthetic-session", transport: transport, &block)
    when :translation
      client.realtime.connect_translation(model: "synthetic", transport: transport, &block)
    when :generic_translation
      client.realtime.translations.connect(transport: transport, &block)
    when :beta_responses
      client.beta.responses.connect(transport: transport, &block)
    end
  end
end

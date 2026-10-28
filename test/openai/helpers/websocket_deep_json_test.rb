# frozen_string_literal: true

require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::WebSocketDeepJSONTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  # Match the existing Live deep-schema regression. This is a probe, not a limit.
  DEPTH = 4000
  MODES = [:realtime, :transcription, :sideband, :responses].freeze

  def test_deep_tool_schemas_are_sent_through_public_response_helpers
    schema = deep_schema
    MODES.each do |mode|
      socket = FakeSocket.new
      connect(mode, socket) { |connection| create_response(connection, mode, schema) }
      written = JSON.parse(socket.writes.fetch(0), symbolize_names: true, max_nesting: false)
      tools = mode == :responses ? written.fetch(:tools) : written.fetch(:response).fetch(:tools)
      assert_schema(tools.first.fetch(:parameters))
      assert_equal("response.create", written.fetch(:type))
      assert_predicate(socket, :closed?)
    end
  end

  def test_known_and_unknown_inbound_events_preserve_deep_schemas
    schema = deep_schema
    MODES.each do |mode|
      known = if mode == :responses
        {
          type: "response.output_item.added",
          sequence_number: 1,
          output_index: 0,
          item: {type: "function_call", id: "fc_1", call_id: "call_1", name: "f", arguments: "{}", schema: schema}
        }
      else
        {
          type: "session.created",
          event_id: "e1",
          session: {type: "realtime", id: "s1", model: "gpt-realtime", audio: {}, tools: [tool(schema)]}
        }
      end

      future = {type: "future.event", schema: schema}
      socket = FakeSocket.new(*[known, future].map { JSON.generate(_1, max_nesting: false) })
      connect(mode, socket) do |connection|
        event = connection.receive
        if mode == :responses
          assert_instance_of(OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded, event)
          assert_schema(event.item.to_h.fetch(:schema))
        else
          assert_instance_of(OpenAI::Realtime::SessionCreatedEvent, event)
          assert_schema(event.session.tools.first.parameters)
        end

        unknown = connection.receive
        expected = mode == :responses ? OpenAI::Responses::UnknownServerEvent : OpenAI::Realtime::UnknownServerEvent
        assert_instance_of(expected, unknown)
        assert_same(unknown.data, unknown.to_h)
        assert_predicate(unknown.data, :frozen?)
        assert_schema(unknown.data.fetch(:schema), frozen: true)
      end
    end
  end

  def test_generator_stack_failures_are_wrapped_before_writing_and_connection_remains_usable
    MODES.each do |mode|
      socket = FakeSocket.new
      connect(mode, socket) do |connection|
        JSON.stub(:generate, -> (*) { raise SystemStackError, "synthetic-stack-marker" }) do
          error_class = mode == :responses ? OpenAI::Errors::ResponsesClientEventError : ArgumentError
          error = assert_raises(error_class) { create_response(connection, mode, {type: "string"}) }
          assert_safe_error(error)
          assert_empty(socket.writes)
          refute_predicate(connection, :closed?)
        end

        create_response(connection, mode, {type: "string"})
        assert_equal(1, socket.writes.length)
      end
    end
  end

  def test_parser_stack_failures_are_wrapped_and_the_next_frame_remains_readable
    MODES.each do |mode|
      frame = JSON.generate(type: "future.event")
      socket = FakeSocket.new(frame, frame)
      connect(mode, socket) do |connection|
        JSON.stub(:parse, -> (*) { raise SystemStackError, "synthetic-stack-marker" }) do
          error_class = mode == :responses ? OpenAI::Errors::ResponsesProtocolError : OpenAI::Errors::RealtimeProtocolError
          error = assert_raises(error_class) { connection.receive }
          assert_safe_error(error)
          refute_predicate(connection, :closed?)
        end

        assert_equal(:"future.event", connection.receive.type)
      end
    end
  end

  private def connect(mode, socket, &block)
    transport = FakeTransport.new(socket)
    case mode
    when :realtime
      client.realtime.connect(model: "gpt-realtime", transport: transport, &block)
    when :transcription
      client.realtime.connect_transcription(transport: transport, &block)
    when :sideband
      client.realtime.connect_to_call(call_id: "synthetic-call", transport: transport, &block)
    when :responses
      client.responses.connect(transport: transport, &block)
    end
  end

  private def tool(schema) = {type: "function", name: "f", parameters: schema}

  private def create_response(connection, mode, schema)
    if mode == :responses
      connection.response.create(model: "synthetic", tools: [tool(schema)])
    else
      connection.response.create(tools: [tool(schema)])
    end
  end

  private def deep_schema
    DEPTH.times.reduce({type: "string", enum: ["synthetic-leaf"]}) { |value, _| {properties: {nested: value}} }
  end

  private def assert_schema(schema, frozen: false)
    DEPTH.times do
      assert_predicate(schema, :frozen?) if frozen
      properties = schema.fetch(:properties)
      assert_predicate(properties, :frozen?) if frozen
      schema = properties.fetch(:nested)
    end

    assert_equal("string", schema.fetch(:type))
    assert_equal(["synthetic-leaf"], schema.fetch(:enum))
    return unless frozen

    [schema, schema.fetch(:type), schema.fetch(:enum), schema.fetch(:enum).first].each do |value|
      assert_predicate(value, :frozen?)
    end
  end

  private def assert_safe_error(error)
    assert_nil(error.cause)
    refute_includes(error.full_message, "synthetic-stack-marker")
    refute_includes(error.inspect, "synthetic-stack-marker")
  end
end

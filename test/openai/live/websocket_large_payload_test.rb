# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::LiveWebSocketLargePayloadTest < Minitest::Test
  # Keep large synthetic payloads serial as in the HTTP/SSE compatibility suite.
  extend Minitest::Serial
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_deep_schemas_survive_known_events_and_unknown_events_are_deeply_frozen
    schema = {type: "string"}
    4000.times { schema = {properties: {nested: schema}} }
    delegation = {
      type: "responses",
      responses: {
        model: "gpt-live-1",
        tools: [
          {type: "function", name: "demo", parameters: schema}
        ]
      }
    }
    session = {id: "sess_1", model: "gpt-live-1", expires_at: 2000000000, status: "active", delegation: delegation}
    socket = FakeSocket.new(
      JSON.generate({type: "session.started", event_id: "evt_1", session: session}, max_nesting: false),
      JSON.generate({type: "session.future", schema: schema}, max_nesting: false)
    )
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.send_event(type: "session.start", session: {model: "gpt-live-1", delegation: delegation})
      written = JSON.parse(socket.writes.fetch(0), symbolize_names: true, max_nesting: false)
      schema_written = written.dig(:session, :delegation, :responses, :tools).first.fetch(:parameters)
      started = connection.receive
      assert_instance_of(OpenAI::Live::SessionStartedEvent, started)
      schema_started = started.session.delegation.responses.tools.first.parameters
      future = connection.receive
      assert_instance_of(OpenAI::Live::UnknownServerEvent, future)
      schema_future = future.data.fetch(:schema)
      4000.times do
        schema_written = schema_written.fetch(:properties).fetch(:nested)
        schema_started = schema_started.fetch(:properties).fetch(:nested)
        assert(schema_future.frozen?)
        schema_future = schema_future.fetch(:properties).fetch(:nested)
      end

      assert_equal("string", schema_written.fetch(:type))
      assert_equal("string", schema_started.fetch(:type))
      assert_equal("string", schema_future.fetch(:type))
      assert(schema_future.frozen?)
    end
  end

  def test_native_parser_resource_exhaustion_cannot_escape_as_system_stack_error
    levels = 100_000
    json = "{\"type\":\"session.future\",\"data\":" +
      ("{\"nested\":" * levels) +
      "\"private-payload\"" +
      ("}" * levels) +
      "}"
    socket = FakeSocket.new(json)
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      # The native parser's supported depth varies by Ruby and JSON version.
      begin
        event = connection.receive
        assert_instance_of(OpenAI::Live::UnknownServerEvent, event)
        data = event.data.fetch(:data)
        levels.times { data = data.fetch(:nested) }
        assert_equal("private-payload", data)
      rescue OpenAI::Errors::LiveProtocolError => error
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-payload")
      end
    end
  end

end

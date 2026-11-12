# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::LiveDelegationToolChoiceTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_mcp_name_on_start_update_and_returned_events
    [{}, {name: nil}, {name: "search"}].each do |name|
      wire = {type: "mcp", server_label: "search_server", **name}
      session = {
        id: "sess_1",
        model: "gpt-live-1",
        expires_at: 2000000000,
        status: "active",
        delegation: {type: "responses", responses: {model: "gpt-5", tool_choice: wire}}
      }
      socket = FakeSocket.new(
        JSON.generate(type: "session.started", event_id: "evt_start", session: session),
        JSON.generate(type: "session.updated", event_id: "evt_update", session: session)
      )
      client.live.connect(transport: FakeTransport.new(socket)) do |connection|
        creation = OpenAI::Live::ResponsesDelegationConfig::ToolChoice::Mcp.new(server_label: "search_server", **name)
        update = OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice::Mcp.new(
          server_label: "search_server",
          **name
        )
        connection.send_event(
          OpenAI::Live::SessionStartEvent.new(
            session: {
              model: "gpt-live-1",
              delegation: {type: :responses, responses: {model: "gpt-5", tool_choice: creation}}
            }
          )
        )
        connection.send_event(
          OpenAI::Live::SessionUpdateEvent.new(
            session: {
              delegation: {type: :responses, responses: {tool_choice: update}}
            }
          )
        )

        expected = wire.transform_keys(&:to_s)
        assert_equal(2, socket.writes.length)
        socket.writes.each do |frame|
          assert_equal(expected, JSON.parse(frame).dig("session", "delegation", "responses", "tool_choice"))
        end

        2.times do
          choice = connection.receive.session.delegation.responses.tool_choice
          assert_instance_of(OpenAI::Live::ResponsesDelegationConfig::ToolChoice::Mcp, choice)
          if name[:name]
            assert_equal(name[:name], choice.name)
          else
            assert_nil(choice.name)
          end

          assert_equal(expected, JSON.parse(choice.to_json))
        end
      end
    end
  end

  def test_returned_allowed_tools_preserve_mcp_names
    tools = [
      {type: "mcp", server_label: "catalog", name: "lookup_inventory"},
      {type: "mcp", server_label: "archive", name: nil},
      {type: "mcp", server_label: "search"}
    ]
    choice = {type: "allowed_tools", mode: "auto", tools: tools}
    session = {
      id: "sess_1",
      model: "gpt-live-1",
      expires_at: 2000000000,
      status: "active",
      delegation: {type: "responses", responses: {model: "gpt-5", tool_choice: choice}}
    }
    socket = FakeSocket.new(
      JSON.generate(type: "session.started", event_id: "evt_start", session: session),
      JSON.generate(type: "session.updated", event_id: "evt_update", session: session)
    )
    transport = FakeTransport.new(socket)

    client.live.connect(transport: transport) do |connection|
      2.times do
        returned = connection.receive.session.delegation.responses.tool_choice
        named, explicit_null, omitted = returned.tools
        assert_equal("lookup_inventory", named.name)
        assert_nil(explicit_null.name)
        assert_nil(omitted.name)
        assert_equal(tools, JSON.parse(returned.to_json, symbolize_names: true).fetch(:tools))
      end
    end

    refute_nil(transport.open_args)
  end

  def test_send_rejects_missing_function_names_and_missing_mcp_server_labels
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      [{type: :function}, {type: :function, name: nil}, {type: :mcp, name: "lookup"}].each do |choice|
        assert_raises(ArgumentError) do
          connection.send_event(
            type: :"session.update",
            session: {
              delegation: {type: :responses, responses: {tool_choice: choice}}
            }
          )
        end
      end
    end

    assert_empty(socket.writes)
  end

  def test_function_named_and_allowed_choices
    [OpenAI::Live::ResponsesDelegationConfig, OpenAI::Live::ResponsesDelegationUpdateConfig].each do |model|
      choices = model::ToolChoice
      function = choices::Function.new(name: "lookup")
      assert_equal(
        {"type" => "function", "name" => "lookup"},
        JSON.parse(model.new(model: "gpt-5", tool_choice: function).to_json)["tool_choice"]
      )
      allowed = choices::LiveAllowedToolsChoiceParam.new(
        mode: :auto,
        tools: [
          {type: :function, name: "lookup"},
          choices::LiveAllowedToolsChoiceParam::Tool::Mcp.new(server_label: "server", name: nil),
          {type: :file_search}
        ]
      )
      decoded = model.new(model: "gpt-5", tool_choice: allowed).tool_choice
      assert_instance_of(choices::LiveAllowedToolsChoiceParam, decoded)
      assert_instance_of(choices::LiveAllowedToolsChoiceParam::Tool::Mcp, decoded.tools.fetch(1))
      assert_equal(
        {"type" => "mcp", "server_label" => "server", "name" => nil},
        JSON.parse(decoded.to_json).fetch("tools").fetch(1)
      )
      named = model.new(model: "gpt-5", tool_choice: choices::FileSearch.new)
      assert_equal({"type" => "file_search"}, JSON.parse(named.to_json).fetch("tool_choice"))
    end
  end
end

# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::LiveMCPTransportTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_nullable_settings_survive_session_event_transport
    tools = JSON.parse(
      "[{\"type\":\"mcp\",\"server_label\":\"fixture\",\"server_url\":\"https://example.test/mcp\",\"server_description\":\"MCP response fixture\",\"connector_id\":\"connector_dropbox\",\"tunnel_id\":\"tunnel_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\",\"allowed_callers\":[\"direct\"],\"defer_loading\":false,\"allowed_tools\":{\"tool_names\":[\"lookup\"],\"read_only\":true},\"require_approval\":{\"always\":{\"tool_names\":[\"write\"],\"read_only\":false},\"never\":{\"tool_names\":[\"lookup\"],\"read_only\":true}}},{\"type\":\"mcp\",\"server_url\":null,\"server_description\":null,\"connector_id\":null,\"tunnel_id\":null,\"allowed_callers\":null,\"defer_loading\":null,\"allowed_tools\":null,\"require_approval\":null},{\"type\":\"mcp\"},{\"type\":\"mcp\",\"allowed_tools\":{\"tool_names\":null,\"read_only\":null},\"require_approval\":{\"always\":null,\"never\":null}},{\"type\":\"mcp\",\"allowed_tools\":{},\"require_approval\":{}}]"
    )
    frames = ["session.started", "session.updated"].map do |kind|
      JSON.generate(
        type: kind,
        event_id: "event_fixture",
        session: {
          id: "live_fixture",
          model: "gpt-live-1",
          status: "active",
          expires_at: 123,
          delegation: {type: "responses", responses: {model: "model_fixture", tools: tools}}
        }
      )
    end

    socket = FakeSocket.new(*frames)
    transport = FakeTransport.new(socket)
    client.live.connect(transport: transport) do |connection|
      2.times do
        event = connection.receive
        observed = event.session.delegation.responses.tools
        tool = observed.fetch(0)
        assert_instance_of(OpenAI::Live::McpTool, tool)
        assert_equal("MCP response fixture", tool.server_description)
        assert_equal("fixture", tool.server_label)
        assert_equal("https://example.test/mcp", tool.server_url)
        assert_equal("connector_dropbox", tool.connector_id)
        assert_equal("tunnel_" + ("a" * 32), tool.tunnel_id)
        assert_equal([:direct], tool.allowed_callers)
        assert_equal(false, tool.defer_loading)
        assert_equal(["lookup"], tool.allowed_tools.tool_names)
        assert_equal(true, tool.allowed_tools.read_only)
        assert_equal(["write"], tool.require_approval.always.tool_names)
        assert_equal(false, tool.require_approval.always.read_only)
        assert_equal(["lookup"], tool.require_approval.never.tool_names)
        assert_equal(true, tool.require_approval.never.read_only)
        observed[1..2].each do |absent|
          assert_nil(absent.server_description)
          assert_nil(absent.server_url)
          assert_nil(absent.connector_id)
          assert_nil(absent.tunnel_id)
          assert_nil(absent.allowed_callers)
          assert_nil(absent.defer_loading)
          assert_nil(absent.allowed_tools)
          assert_nil(absent.require_approval)
        end

        observed[3..].each do |nested|
          assert_nil(nested.allowed_tools.tool_names)
          assert_nil(nested.allowed_tools.read_only)
          assert_nil(nested.require_approval.always)
          assert_nil(nested.require_approval.never)
        end
      end
    end

    assert_equal("wss://example.com/v1/live/sessions", transport.open_args.fetch(:url).to_s)
    assert_nil(socket.read)
  end
end

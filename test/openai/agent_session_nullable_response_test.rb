# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AgentSessionNullableResponseTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def setup
    super
    WebMock.enable!
    WebMock.disable_net_connect!
    @client = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.test/v1", max_retries: 0)
  end

  def teardown
    WebMock.reset!
    WebMock.disable!
    super
  end

  def test_session_prompt_cache_options
    [{prompt_cache_options: {ttl: "12h"}}, {prompt_cache_options: nil}, {}].each do |payload|
      request = stub_request(:get, "https://example.test/v1/agents/sessions/session_synthetic")
        .to_return_json(body: payload)
      options = @client.beta.agents.sessions.retrieve("session_synthetic").prompt_cache_options
      if payload[:prompt_cache_options]
        assert_equal(:"12h", options&.ttl)
      else
        assert_nil(options)
      end

      assert_requested(request, times: 1)
      WebMock.reset!
    end
  end

  def test_turn_prompt_cache_options
    [{prompt_cache_options: {ttl: "30m"}}, {prompt_cache_options: nil}, {}].each do |payload|
      request = stub_request(:get, "https://example.test/v1/agents/sessions/session_synthetic/turns/turn_synthetic")
        .to_return_json(body: payload)
      options = @client
        .beta
        .agents
        .sessions
        .turns
        .retrieve(
          "turn_synthetic",
          session_id: "session_synthetic"
        )
        .prompt_cache_options
      if payload[:prompt_cache_options]
        assert_equal(:"30m", options&.ttl)
      else
        assert_nil(options)
      end

      assert_requested(request, times: 1)
      WebMock.reset!
    end
  end

  def test_mcp_approval_request_nullable_fields
    [{name: "lookup_inventory", arguments: {"item" => "synthetic-widget"}}, {name: nil, arguments: nil}].each do |
        fields
      |
      payload = {
        required_actions: [
          {
            type: "mcp_approval_request",
            request_id: "approval_synthetic",
            turn_id: "turn_synthetic",
            request: {type: "mcp_tool_call", message: "Approve lookup", server_label: "synthetic"}.merge(fields)
          }
        ]
      }
      request = stub_request(:get, "https://example.test/v1/agents/sessions/session_synthetic")
        .to_return_json(body: payload)
      approval = @client.beta.agents.sessions.retrieve("session_synthetic").required_actions.fetch(0).request
      if fields[:name]
        assert_equal("lookup_inventory", approval.name)
        assert_equal({item: "synthetic-widget"}, approval.arguments)
      else
        assert_nil(approval.name)
        assert_nil(approval.arguments)
      end

      assert_requested(request, times: 1)
      WebMock.reset!
    end
  end
end

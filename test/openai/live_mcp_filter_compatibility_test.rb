# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::LiveMCPFilterCompatibilityTest < Minitest::Test
  def test_approval_filters_preserve_explicit_null
    policy = OpenAI::Models::Live::McpRequireApprovalFilter
    assert_empty(policy.new.to_h)
    explicit = policy.new(always: nil, never: nil)
    assert_nil(explicit.always)
    assert_nil(explicit.never)
    assert_equal({always: nil, never: nil}, explicit.to_h)
  end

  def test_shared_filters_in_create_and_update
    live = OpenAI::Models::Live
    filter = live::McpToolFilter.new(tool_names: ["lookup"])
    policy = live::McpRequireApprovalFilter.new(always: filter, never: filter)

    [live::ResponsesDelegationConfig::Tool::Mcp, live::ResponsesDelegationUpdateConfig::Tool::Mcp].each do |tool|
      assert_same(live::McpTool, tool)
      assert_equal(:mcp, tool.new.type)
      assert_equal(:mcp, tool.new(type: :mcp).type)
      mcp = tool.new(allowed_tools: filter, require_approval: policy)
      assert_equal(filter, mcp.allowed_tools)
      assert_equal(filter, mcp.require_approval.always)
      assert_equal(filter, mcp.require_approval.never)
    end
  end
end

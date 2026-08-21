# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/mcp_approval"
require_relative "example_test_support"

class OpenAI::Test::RealtimeMCPApprovalExampleTest < Minitest::Test
  include OpenAI::Test::RealtimeExampleTestSupport

  APPROVE_POLICY = -> (**_request) { true }

  def test_defaults_to_deny_without_an_application_approval_policy
    client, connection, = recording_client(
      [tool_list_completed, item_done(tool_list_item), item_done(approval_request)]
    )

    error = assert_raises(RuntimeError) { run_example(client, approval_policy: nil) }

    assert_equal("Realtime MCP tool call was not approved by the application.", error.message)
    approval = connection.conversation.items.calls.fetch(1)
    assert_equal(false, approval.fetch(:approve))
    assert_equal(
      "Denied because no caller-provided application policy approved this request.",
      approval.fetch(:reason)
    )
  end

  def test_exact_match_policy_approves_only_the_caller_allowed_tool_and_arguments
    policy = OpenAI::Examples::Realtime::MCPApproval.exact_match_policy(
      allowed_tool_name: "lookup",
      allowed_arguments: "{}"
    )

    assert(
      policy.call(
        server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
        tool_name: "lookup",
        arguments: "{}"
      )
    )
    refute(
      policy.call(
        server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
        tool_name: "delete_everything",
        arguments: "{}"
      )
    )
    refute(
      policy.call(
        server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
        tool_name: "lookup",
        arguments: "{\"scope\":\"broader\"}"
      )
    )
  end

  def test_correlates_discovery_approves_one_tool_and_returns_final_text
    prompt = "private MCP request"
    client, connection, realtime = recording_client(
      [
        tool_list_completed,
        item_done(tool_list_item),
        item_done(approval_request),
        mcp_arguments_done,
        item_done(mcp_tool_call),
        mcp_call_completed,
        response_done(id: "response_tool"),
        response_done(id: "response_final", text: "The tool completed successfully.")
      ]
    )
    diagnostics = StringIO.new

    text = OpenAI::Examples::Realtime::MCPApproval.run(
      client: client,
      model: "gpt-realtime-2.1",
      server_url: "https://mcp.example.test/server",
      prompt: prompt,
      approval_policy: APPROVE_POLICY,
      output: diagnostics
    )

    assert_equal("The tool completed successfully.", text)
    assert_equal(["gpt-realtime-2.1"], realtime.models)
    session = connection.session.calls.fetch(0)
    assert_equal(false, session.fetch(:parallel_tool_calls))
    assert_equal(:always, session.dig(:tools, 0, :require_approval))
    assert_equal("https://mcp.example.test/server", session.dig(:tools, 0, :server_url))

    prompt_item, approval_item = connection.conversation.items.calls
    assert_equal(prompt, prompt_item.dig(:content, 0, :text))
    assert_equal(:mcp_approval_response, approval_item.fetch(:type))
    assert_equal("approval_response_1", approval_item.fetch(:id))
    assert_equal("approval_1", approval_item.fetch(:approval_request_id))
    assert_equal(true, approval_item.fetch(:approve))
    assert_equal(
      "Approved by the caller-provided application policy.",
      approval_item.fetch(:reason)
    )
    assert_equal(
      [
        {
          tool_choice: {
            type: :mcp,
            server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
            name: "lookup"
          }
        },
        {tool_choice: :none}
      ],
      connection.response.calls
    )
    assert_includes(diagnostics.string, "response.done status=completed")
    refute_includes(diagnostics.string, prompt)
    refute_includes(diagnostics.string, "mcp.example.test")
    refute_includes(diagnostics.string, text)
  end

  def test_accepts_reverse_discovery_order_and_tool_completion_after_first_response
    events = [
      item_done(tool_list_item),
      tool_list_completed,
      mcp_arguments_done,
      response_done(id: "response_tool"),
      item_done(approval_request),
      mcp_call_completed,
      item_done(mcp_tool_call),
      response_done(id: "response_final", text: "Done.")
    ]
    client, connection, = recording_client(events)

    text = run_example(client)

    assert_equal("Done.", text)
    assert_equal(2, connection.response.calls.length)
  end

  def test_does_not_select_a_tool_until_matching_discovery_events_arrive
    events = [
      OpenAI::Realtime::McpListToolsCompleted.new(
        event_id: "event_other",
        item_id: "list_other"
      ),
      item_done(tool_list_item)
    ]
    client, connection, = recording_client(events)

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime connection closed before the MCP workflow completed.", error.message)
    assert_empty(connection.response.calls)
    assert_empty(connection.conversation.items.calls)
  end

  def test_rejects_empty_tool_lists
    item = OpenAI::Realtime::RealtimeMcpListTools.new(
      id: "list_1",
      server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
      tools: []
    )
    client, = recording_client([tool_list_completed, item_done(item)])

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP server returned no tools.", error.message)
  end

  def test_rejects_unexpected_approval_requests
    unexpected = OpenAI::Realtime::RealtimeMcpApprovalRequest.new(
      id: "approval_1",
      arguments: "{}",
      name: "private_unexpected_tool",
      server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL
    )
    client, = recording_client(
      [tool_list_completed, item_done(tool_list_item), item_done(unexpected)]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime returned an unexpected MCP approval request.", error.message)
    refute_includes(error.message, "private_unexpected_tool")
  end

  def test_rejects_discovery_tool_and_api_failures_without_sensitive_details
    failures = [
      [mcp_list_failed, "Realtime MCP tool discovery failed."],
      [mcp_call_failed, "Realtime MCP tool call failed."],
      [api_error("private MCP response"), "Realtime API error."]
    ]

    failures.each do |event, expected_message|
      client, = recording_client([event])
      error = assert_raises(RuntimeError) { run_example(client) }

      assert_equal(expected_message, error.message)
      refute_includes(error.message, "private")
    end
  end

  def test_requires_completed_initial_and_final_responses
    initial_events = workflow_events(
      response_done(id: "response_tool", status: :failed),
      response_done(id: "response_final", text: "unused")
    )
    initial_client, = recording_client(initial_events)
    initial_error = assert_raises(RuntimeError) { run_example(initial_client) }
    assert_equal("Realtime response did not complete.", initial_error.message)

    final_events = workflow_events(
      response_done(id: "response_tool"),
      response_done(id: "response_final", status: :incomplete, text: "partial")
    )
    final_client, = recording_client(final_events)
    final_error = assert_raises(RuntimeError) { run_example(final_client) }
    assert_equal("Realtime response did not complete.", final_error.message)
  end

  def test_rejects_response_done_before_tool_call_arguments
    client, = recording_client(
      [tool_list_completed, item_done(tool_list_item), response_done(id: "response_tool")]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime response completed before the MCP tool call.", error.message)
  end

  def test_rejects_mismatched_tool_completion
    mismatched = OpenAI::Realtime::ResponseMcpCallCompleted.new(
      event_id: "event_complete",
      item_id: "other_call",
      output_index: 0
    )
    client, = recording_client(
      [
        tool_list_completed,
        item_done(tool_list_item),
        mcp_arguments_done,
        item_done(approval_request),
        mismatched
      ]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP completion did not match the requested tool call.", error.message)
  end

  def test_rejects_tool_call_for_a_different_approval_request
    mismatched_call = mcp_tool_call(approval_request_id: "other_approval")
    client, = recording_client(
      [
        tool_list_completed,
        item_done(tool_list_item),
        mcp_arguments_done,
        item_done(mismatched_call),
        item_done(approval_request),
        mcp_call_completed,
        response_done(id: "response_tool"),
        response_done(id: "response_final", text: "Wrong call completed.")
      ]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP tool call did not match the approved request.", error.message)
  end

  def test_denies_approval_when_arguments_done_do_not_match_the_approved_request
    mismatched_arguments = OpenAI::Realtime::ResponseMcpCallArgumentsDone.new(
      arguments: "{\"scope\":\"broader\"}",
      event_id: "event_arguments",
      item_id: "call_1",
      output_index: 0,
      response_id: "response_tool"
    )
    client, connection, = recording_client(
      [tool_list_completed, item_done(tool_list_item), item_done(approval_request), mismatched_arguments]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP tool call arguments did not match the approved request.", error.message)
    approval = connection.conversation.items.calls.fetch(1)
    assert_equal(false, approval.fetch(:approve))
  end

  def test_rejects_a_finalized_tool_call_with_different_arguments
    mismatched_call = mcp_tool_call(arguments: "{\"scope\":\"broader\"}")
    client, = recording_client(
      [
        tool_list_completed,
        item_done(tool_list_item),
        mcp_arguments_done,
        item_done(approval_request),
        item_done(mismatched_call)
      ]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP tool call arguments did not match the approved request.", error.message)
  end

  def test_rejects_mismatched_first_response
    client, = recording_client(
      [
        tool_list_completed,
        item_done(tool_list_item),
        mcp_arguments_done,
        item_done(approval_request),
        response_done(id: "other_response")
      ]
    )

    error = assert_raises(RuntimeError) { run_example(client) }

    assert_equal("Realtime MCP tool call did not match response.done.", error.message)
  end

  def test_rejects_premature_eof_and_empty_final_output
    client, = recording_client(
      [tool_list_completed, item_done(tool_list_item), mcp_arguments_done, item_done(approval_request)]
    )
    eof_error = assert_raises(RuntimeError) { run_example(client) }
    assert_equal("Realtime connection closed before the MCP workflow completed.", eof_error.message)

    empty_client, = recording_client(
      workflow_events(response_done(id: "response_tool"), response_done(id: "response_final", text: " "))
    )
    empty_error = assert_raises(RuntimeError) { run_example(empty_client) }
    assert_equal("Realtime final MCP response completed without text output.", empty_error.message)
  end

  private def run_example(client, approval_policy: APPROVE_POLICY)
    OpenAI::Examples::Realtime::MCPApproval.run(
      client: client,
      model: "gpt-realtime-2.1",
      server_url: "https://mcp.example.test/server",
      prompt: "private prompt",
      approval_policy: approval_policy,
      output: StringIO.new
    )
  end

  private def workflow_events(initial_done, final_done)
    [
      tool_list_completed,
      item_done(tool_list_item),
      mcp_arguments_done,
      item_done(approval_request),
      item_done(mcp_tool_call),
      mcp_call_completed,
      initial_done,
      final_done
    ]
  end

  private def tool_list_completed
    OpenAI::Realtime::McpListToolsCompleted.new(event_id: "event_list", item_id: "list_1")
  end

  private def tool_list_item
    OpenAI::Realtime::RealtimeMcpListTools.new(
      id: "list_1",
      server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL,
      tools: [
        OpenAI::Realtime::RealtimeMcpListTools::Tool.new(
          name: "lookup",
          input_schema: {type: "object"}
        )
      ]
    )
  end

  private def approval_request
    OpenAI::Realtime::RealtimeMcpApprovalRequest.new(
      id: "approval_1",
      arguments: "{}",
      name: "lookup",
      server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL
    )
  end

  private def item_done(item)
    OpenAI::Realtime::ConversationItemDone.new(event_id: "event_item", item: item)
  end

  private def mcp_arguments_done
    OpenAI::Realtime::ResponseMcpCallArgumentsDone.new(
      arguments: "{}",
      event_id: "event_arguments",
      item_id: "call_1",
      output_index: 0,
      response_id: "response_tool"
    )
  end

  private def mcp_call_completed
    OpenAI::Realtime::ResponseMcpCallCompleted.new(
      event_id: "event_complete",
      item_id: "call_1",
      output_index: 0
    )
  end

  private def mcp_tool_call(approval_request_id: "approval_1", arguments: "{}")
    OpenAI::Realtime::RealtimeMcpToolCall.new(
      id: "call_1",
      approval_request_id: approval_request_id,
      arguments: arguments,
      name: "lookup",
      server_label: OpenAI::Examples::Realtime::MCPApproval::SERVER_LABEL
    )
  end

  private def mcp_list_failed
    OpenAI::Realtime::McpListToolsFailed.new(event_id: "event_failed", item_id: "list_1")
  end

  private def mcp_call_failed
    OpenAI::Realtime::ResponseMcpCallFailed.new(
      event_id: "event_failed",
      item_id: "call_1",
      output_index: 0
    )
  end
end

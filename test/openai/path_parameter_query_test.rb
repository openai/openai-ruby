# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::PathParameterQueryTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "test-api-key",
      admin_api_key: "test-admin-api-key"
    )
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_conversation_item_retrieve_excludes_conversation_id
    request = stub_get(
      "/conversations/conv_123/items/msg_123",
      query: {"include" => ["file_search_call.results"]},
      body: {id: "msg_123", type: "message", role: "user", content: [], status: "completed"}
    )

    response = @client.conversations.items.retrieve(
      "msg_123",
      conversation_id: "conv_123",
      include: [:"file_search_call.results"]
    )

    assert_instance_of(OpenAI::Conversations::Message, response)
    assert_requested(request)
  end

  def test_response_retrieve_streaming_enables_stream_query_parameter
    request = stub_response_stream(query: {"stream" => "true"}, include_keepalive: true)

    events = @client.responses.retrieve_streaming("resp_audit").to_a

    assert_equal(1, events.length)
    assert_instance_of(OpenAI::Responses::ResponseTextDeltaEvent, events.first)
    assert_equal("streamed text", events.first.delta)
    assert_requested(request)
  end

  def test_response_retrieve_streaming_preserves_query_parameters
    request = stub_response_stream(
      query: {
        "include" => ["file_search_call.results"],
        "include_obfuscation" => "false",
        "starting_after" => "7",
        "stream" => "true"
      }
    )

    events = @client.responses.retrieve_streaming(
      "resp_audit",
      include: [:"file_search_call.results"],
      include_obfuscation: false,
      starting_after: 7
    ).to_a

    assert_equal("streamed text", events.first.delta)
    assert_requested(request)
  end

  def test_beta_response_retrieve_streaming_enables_stream_query_parameter
    request = stub_response_stream(
      query: {"beta" => "true", "stream" => "true"},
      include_keepalive: true
    )

    events = @client.beta.responses.retrieve_streaming("resp_audit").to_a

    assert_equal(1, events.length)
    assert_instance_of(OpenAI::Beta::BetaResponseTextDeltaEvent, events.first)
    assert_equal("streamed text", events.first.delta)
    assert_requested(request)
  end

  def test_beta_response_retrieve_streaming_preserves_query_parameters_and_beta_header
    request = stub_response_stream(
      query: {
        "beta" => "true",
        "include" => ["file_search_call.results"],
        "include_obfuscation" => "false",
        "starting_after" => "7",
        "stream" => "true"
      },
      headers: {"OpenAI-Beta" => "responses_multi_agent=v1"}
    )

    events = @client.beta.responses.retrieve_streaming(
      "resp_audit",
      include: [:"file_search_call.results"],
      include_obfuscation: false,
      starting_after: 7,
      betas: [:"responses_multi_agent=v1"]
    ).to_a

    assert_equal("streamed text", events.first.delta)
    assert_requested(request)
  end

  def test_eval_output_items_list_excludes_eval_id
    request = stub_get(
      "/evals/eval_123/runs/run_123/output_items",
      query: {"after" => "item_123", "limit" => "25", "status" => "pass"}
    )

    response = @client.evals.runs.output_items.list(
      "run_123",
      eval_id: "eval_123",
      after: "item_123",
      limit: 25,
      status: :pass
    )

    assert_instance_of(OpenAI::Internal::CursorPage, response)
    assert_requested(request)
  end

  def test_vector_store_batch_files_list_excludes_vector_store_id
    request = stub_get(
      "/vector_stores/vs_123/file_batches/batch_123/files",
      query: {"after" => "file_123", "filter" => "completed", "limit" => "10"}
    )

    response = @client.vector_stores.file_batches.list_files(
      "batch_123",
      vector_store_id: "vs_123",
      after: "file_123",
      filter: :completed,
      limit: 10
    )

    assert_instance_of(OpenAI::Internal::CursorPage, response)
    assert_requested(request)
  end

  def test_run_step_retrieve_excludes_all_path_parameters
    include_value = "step_details.tool_calls[*].file_search.results[*].content"
    request = stub_get(
      "/threads/thread_123/runs/run_123/steps/step_123",
      query: {"include" => [include_value]}
    )

    response = @client.beta.threads.runs.steps.retrieve(
      "step_123",
      thread_id: "thread_123",
      run_id: "run_123",
      include: [include_value.to_sym]
    )

    assert_instance_of(OpenAI::Beta::Threads::Runs::RunStep, response)
    assert_requested(request)
  end

  def test_run_steps_list_excludes_thread_id
    request = stub_get(
      "/threads/thread_123/runs/run_123/steps",
      query: {"after" => "step_123", "limit" => "5", "order" => "asc"}
    )

    response = @client.beta.threads.runs.steps.list(
      "run_123",
      thread_id: "thread_123",
      after: "step_123",
      limit: 5,
      order: :asc
    )

    assert_instance_of(OpenAI::Internal::CursorPage, response)
    assert_requested(request)
  end

  def test_project_group_retrieve_excludes_project_id
    request = stub_get(
      "/organization/projects/proj_123/groups/group_123",
      query: {"group_type" => "tenant_group"}
    )

    response = @client.admin.organization.projects.groups.retrieve(
      "group_123",
      project_id: "proj_123",
      group_type: :tenant_group
    )

    assert_instance_of(OpenAI::Admin::Organization::Projects::ProjectGroup, response)
    assert_requested(request)
  end

  def test_project_group_roles_list_excludes_project_id
    request = stub_get(
      "/projects/proj_123/groups/group_123/roles",
      query: {"after" => "role_123", "limit" => "10"}
    )

    response = @client.admin.organization.projects.groups.roles.list(
      "group_123",
      project_id: "proj_123",
      after: "role_123",
      limit: 10
    )

    assert_instance_of(OpenAI::Internal::NextCursorPage, response)
    assert_requested(request)
  end

  def test_project_user_roles_list_preserves_pagination_and_extra_query
    request = stub_get(
      "/projects/proj_123/users/user_123/roles",
      query: {"after" => "role_123", "limit" => "20", "order" => "desc", "trace" => "enabled"}
    )

    response = @client.admin.organization.projects.users.roles.list(
      "user_123",
      project_id: "proj_123",
      after: "role_123",
      limit: 20,
      order: :desc,
      request_options: {extra_query: {"trace" => "enabled"}}
    )

    assert_instance_of(OpenAI::Internal::NextCursorPage, response)
    assert_requested(request)
  end

  def test_project_user_roles_list_omits_query_when_only_path_parameters_are_given
    request = stub_get("/projects/proj_123/users/user_123/roles", query: {})

    response = @client.admin.organization.projects.users.roles.list("user_123", project_id: "proj_123")

    assert_instance_of(OpenAI::Internal::NextCursorPage, response)
    assert_requested(request)
  end

  def test_project_user_roles_pagination_keeps_path_parameters_out_of_follow_up_requests
    path = "/projects/proj_123/users/user_123/roles"
    first_request = stub_get(
      path,
      query: {"limit" => "1"},
      body: {data: [], has_more: true, next: "role_123"}
    )
    next_request = stub_get(path, query: {"after" => "role_123", "limit" => "1"})

    page = @client.admin.organization.projects.users.roles.list("user_123", project_id: "proj_123", limit: 1)

    assert_instance_of(OpenAI::Internal::NextCursorPage, page.next_page)
    assert_requested(first_request)
    assert_requested(next_request)
  end

  private

  def stub_response_stream(query:, headers: {}, include_keepalive: false)
    event = {
      type: "response.output_text.delta",
      content_index: 0,
      delta: "streamed text",
      item_id: "item_123",
      logprobs: [],
      output_index: 0,
      sequence_number: 8
    }
    body = +""
    body << "event: keepalive\ndata: {\"type\":\"keepalive\",\"sequence_number\":7}\n\n" if include_keepalive
    body << "event: response.output_text.delta\ndata: #{JSON.generate(event)}\n\n"

    stub_request(:get, "http://localhost/responses/resp_audit")
      .with(
        query: query,
        headers: {"Accept" => "text/event-stream", "Accept-Encoding" => "identity", **headers}
      )
      .to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: body
      )
  end

  def stub_get(path, query:, body: {data: [], has_more: false})
    stub_request(:get, "http://localhost#{path}")
      .with(query: query)
      .to_return_json(status: 200, body: body)
  end
end

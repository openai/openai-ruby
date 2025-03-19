# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Threads::RunsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.threads.runs.create("thread_id", assistant_id: "assistant_id", stream: true)

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.beta.threads.runs.retrieve("run_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end

  def test_update_required_params
    response = @openai.beta.threads.runs.update("run_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end

  def test_list
    response = @openai.beta.threads.runs.list("thread_id")

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    assert_pattern do
      row => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      row => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end

  def test_cancel_required_params
    response = @openai.beta.threads.runs.cancel("run_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end

  def test_submit_tool_outputs_required_params
    response =
      @openai.beta.threads.runs.submit_tool_outputs(
        "run_id",
        thread_id: "thread_id",
        stream: true,
        tool_outputs: [{}]
      )

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Run
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expires_at: Integer | nil,
        failed_at: Integer | nil,
        incomplete_details: OpenAI::Models::Beta::Threads::Run::IncompleteDetails | nil,
        instructions: String,
        last_error: OpenAI::Models::Beta::Threads::Run::LastError | nil,
        max_completion_tokens: Integer | nil,
        max_prompt_tokens: Integer | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        model: String,
        object: Symbol,
        parallel_tool_calls: OpenAI::BooleanModel,
        required_action: OpenAI::Models::Beta::Threads::Run::RequiredAction | nil,
        response_format: OpenAI::Models::Beta::AssistantResponseFormatOption | nil,
        started_at: Integer | nil,
        status: OpenAI::Models::Beta::Threads::RunStatus,
        thread_id: String,
        tool_choice: OpenAI::Models::Beta::AssistantToolChoiceOption | nil,
        tools: ^(OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool]),
        truncation_strategy: OpenAI::Models::Beta::Threads::Run::TruncationStrategy | nil,
        usage: OpenAI::Models::Beta::Threads::Run::Usage | nil,
        temperature: Float | nil,
        top_p: Float | nil
      }
    end
  end
end

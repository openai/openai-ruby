# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::ThreadsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.threads.create

    assert_pattern do
      response => OpenAI::Models::Beta::Thread
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        tool_resources: OpenAI::Models::Beta::Thread::ToolResources | nil
      }
    end
  end

  def test_retrieve
    response = @openai.beta.threads.retrieve("thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Thread
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        tool_resources: OpenAI::Models::Beta::Thread::ToolResources | nil
      }
    end
  end

  def test_update
    response = @openai.beta.threads.update("thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Thread
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        tool_resources: OpenAI::Models::Beta::Thread::ToolResources | nil
      }
    end
  end

  def test_delete
    response = @openai.beta.threads.delete("thread_id")

    assert_pattern do
      response => OpenAI::Models::Beta::ThreadDeleted
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::BooleanModel,
        object: Symbol
      }
    end
  end

  def test_create_and_run_required_params
    response = @openai.beta.threads.create_and_run(assistant_id: "assistant_id")

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

# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Threads::Runs::StepsTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response = @openai.beta.threads.runs.steps.retrieve("step_id", thread_id: "thread_id", run_id: "run_id")

    assert_pattern do
      response => OpenAI::Models::Beta::Threads::Runs::RunStep
    end

    assert_pattern do
      response => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expired_at: Integer | nil,
        failed_at: Integer | nil,
        last_error: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        run_id: String,
        status: OpenAI::Models::Beta::Threads::Runs::RunStep::Status,
        step_details: OpenAI::Models::Beta::Threads::Runs::RunStep::StepDetails,
        thread_id: String,
        type: OpenAI::Models::Beta::Threads::Runs::RunStep::Type,
        usage: OpenAI::Models::Beta::Threads::Runs::RunStep::Usage | nil
      }
    end
  end

  def test_list_required_params
    response = @openai.beta.threads.runs.steps.list("run_id", thread_id: "thread_id")

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Beta::Threads::Runs::RunStep
    end

    assert_pattern do
      row => {
        id: String,
        assistant_id: String,
        cancelled_at: Integer | nil,
        completed_at: Integer | nil,
        created_at: Integer,
        expired_at: Integer | nil,
        failed_at: Integer | nil,
        last_error: OpenAI::Models::Beta::Threads::Runs::RunStep::LastError | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        object: Symbol,
        run_id: String,
        status: OpenAI::Models::Beta::Threads::Runs::RunStep::Status,
        step_details: OpenAI::Models::Beta::Threads::Runs::RunStep::StepDetails,
        thread_id: String,
        type: OpenAI::Models::Beta::Threads::Runs::RunStep::Type,
        usage: OpenAI::Models::Beta::Threads::Runs::RunStep::Usage | nil
      }
    end
  end
end

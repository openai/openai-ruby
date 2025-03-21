# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::FineTuning::JobsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.fine_tuning.jobs.create(model: :"babbage-002", training_file: "file-abc123")

    assert_pattern do
      response => OpenAI::Models::FineTuning::FineTuningJob
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        error: OpenAI::Models::FineTuning::FineTuningJob::Error | nil,
        fine_tuned_model: String | nil,
        finished_at: Integer | nil,
        hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
        model: String,
        object: Symbol,
        organization_id: String,
        result_files: ^(OpenAI::ArrayOf[String]),
        seed: Integer,
        status: OpenAI::Models::FineTuning::FineTuningJob::Status,
        trained_tokens: Integer | nil,
        training_file: String,
        validation_file: String | nil,
        estimated_finish: Integer | nil,
        integrations: ^(OpenAI::ArrayOf[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]) | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        method_: OpenAI::Models::FineTuning::FineTuningJob::Method | nil
      }
    end
  end

  def test_retrieve
    response = @openai.fine_tuning.jobs.retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

    assert_pattern do
      response => OpenAI::Models::FineTuning::FineTuningJob
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        error: OpenAI::Models::FineTuning::FineTuningJob::Error | nil,
        fine_tuned_model: String | nil,
        finished_at: Integer | nil,
        hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
        model: String,
        object: Symbol,
        organization_id: String,
        result_files: ^(OpenAI::ArrayOf[String]),
        seed: Integer,
        status: OpenAI::Models::FineTuning::FineTuningJob::Status,
        trained_tokens: Integer | nil,
        training_file: String,
        validation_file: String | nil,
        estimated_finish: Integer | nil,
        integrations: ^(OpenAI::ArrayOf[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]) | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        method_: OpenAI::Models::FineTuning::FineTuningJob::Method | nil
      }
    end
  end

  def test_list
    response = @openai.fine_tuning.jobs.list

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::FineTuning::FineTuningJob
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        error: OpenAI::Models::FineTuning::FineTuningJob::Error | nil,
        fine_tuned_model: String | nil,
        finished_at: Integer | nil,
        hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
        model: String,
        object: Symbol,
        organization_id: String,
        result_files: ^(OpenAI::ArrayOf[String]),
        seed: Integer,
        status: OpenAI::Models::FineTuning::FineTuningJob::Status,
        trained_tokens: Integer | nil,
        training_file: String,
        validation_file: String | nil,
        estimated_finish: Integer | nil,
        integrations: ^(OpenAI::ArrayOf[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]) | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        method_: OpenAI::Models::FineTuning::FineTuningJob::Method | nil
      }
    end
  end

  def test_cancel
    response = @openai.fine_tuning.jobs.cancel("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

    assert_pattern do
      response => OpenAI::Models::FineTuning::FineTuningJob
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        error: OpenAI::Models::FineTuning::FineTuningJob::Error | nil,
        fine_tuned_model: String | nil,
        finished_at: Integer | nil,
        hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
        model: String,
        object: Symbol,
        organization_id: String,
        result_files: ^(OpenAI::ArrayOf[String]),
        seed: Integer,
        status: OpenAI::Models::FineTuning::FineTuningJob::Status,
        trained_tokens: Integer | nil,
        training_file: String,
        validation_file: String | nil,
        estimated_finish: Integer | nil,
        integrations: ^(OpenAI::ArrayOf[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]) | nil,
        metadata: ^(OpenAI::HashOf[String]) | nil,
        method_: OpenAI::Models::FineTuning::FineTuningJob::Method | nil
      }
    end
  end

  def test_list_events
    response = @openai.fine_tuning.jobs.list_events("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

    assert_pattern do
      response => OpenAI::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::FineTuning::FineTuningJobEvent
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        level: OpenAI::Models::FineTuning::FineTuningJobEvent::Level,
        message: String,
        object: Symbol,
        data: OpenAI::Unknown | nil,
        type: OpenAI::Models::FineTuning::FineTuningJobEvent::Type | nil
      }
    end
  end
end

# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Evals::RunsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.evals.runs.create(
        "eval_id",
        data_source: {source: {content: [{item: {foo: "bar"}}], type: :file_content}, type: :jsonl}
      )

    assert_pattern do
      response => OpenAI::Models::Evals::RunCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source: OpenAI::Models::Evals::RunCreateResponse::DataSource,
        error: OpenAI::Models::Evals::EvalAPIError,
        eval_id: String,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String,
        object: Symbol,
        per_model_usage: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCreateResponse::PerModelUsage]),
        per_testing_criteria_results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCreateResponse::PerTestingCriteriaResult]),
        report_url: String,
        result_counts: OpenAI::Models::Evals::RunCreateResponse::ResultCounts,
        status: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.evals.runs.retrieve("run_id", eval_id: "eval_id")

    assert_pattern do
      response => OpenAI::Models::Evals::RunRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source: OpenAI::Models::Evals::RunRetrieveResponse::DataSource,
        error: OpenAI::Models::Evals::EvalAPIError,
        eval_id: String,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String,
        object: Symbol,
        per_model_usage: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunRetrieveResponse::PerModelUsage]),
        per_testing_criteria_results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunRetrieveResponse::PerTestingCriteriaResult]),
        report_url: String,
        result_counts: OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts,
        status: String
      }
    end
  end

  def test_list
    response = @openai.evals.runs.list("eval_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Evals::RunListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        data_source: OpenAI::Models::Evals::RunListResponse::DataSource,
        error: OpenAI::Models::Evals::EvalAPIError,
        eval_id: String,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String,
        object: Symbol,
        per_model_usage: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunListResponse::PerModelUsage]),
        per_testing_criteria_results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult]),
        report_url: String,
        result_counts: OpenAI::Models::Evals::RunListResponse::ResultCounts,
        status: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.evals.runs.delete("run_id", eval_id: "eval_id")

    assert_pattern do
      response => OpenAI::Models::Evals::RunDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean | nil,
        object: String | nil,
        run_id: String | nil
      }
    end
  end

  def test_cancel_required_params
    response = @openai.evals.runs.cancel("run_id", eval_id: "eval_id")

    assert_pattern do
      response => OpenAI::Models::Evals::RunCancelResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source: OpenAI::Models::Evals::RunCancelResponse::DataSource,
        error: OpenAI::Models::Evals::EvalAPIError,
        eval_id: String,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        model: String,
        name: String,
        object: Symbol,
        per_model_usage: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCancelResponse::PerModelUsage]),
        per_testing_criteria_results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult]),
        report_url: String,
        result_counts: OpenAI::Models::Evals::RunCancelResponse::ResultCounts,
        status: String
      }
    end
  end
end

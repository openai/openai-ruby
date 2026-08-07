# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::EvalsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.evals.create(
        data_source_config: {item_schema: {foo: "bar"}, type: :custom},
        testing_criteria: [
          {
            input: [{content: "content", role: "role"}],
            labels: ["string"],
            model: "model",
            name: "name",
            passing_labels: ["string"],
            type: :label_model
          }
        ]
      )

    assert_pattern do
      response => OpenAI::Models::EvalCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalCreateResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalCreateResponse::TestingCriterion])
      }
    end
  end

  def test_retrieve
    response = @openai.evals.retrieve("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalRetrieveResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalRetrieveResponse::TestingCriterion])
      }
    end
  end

  def test_update
    response = @openai.evals.update("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalUpdateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalUpdateResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalUpdateResponse::TestingCriterion])
      }
    end
  end

  def test_list
    response = @openai.evals.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::EvalListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        data_source_config: OpenAI::Models::EvalListResponse::DataSourceConfig,
        metadata: ^(OpenAI::Internal::Type::HashOf[String]) | nil,
        name: String,
        object: Symbol,
        testing_criteria: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalListResponse::TestingCriterion])
      }
    end
  end

  def test_delete
    response = @openai.evals.delete("eval_id")

    assert_pattern do
      response => OpenAI::Models::EvalDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        eval_id: String,
        object: String
      }
    end
  end
end

# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Evals::Runs::OutputItemsTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response =
      @openai.evals.runs.output_items.retrieve("output_item_id", eval_id: "eval_id", run_id: "run_id")

    assert_pattern do
      response => OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        datasource_item: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]),
        datasource_item_id: Integer,
        eval_id: String,
        object: Symbol,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]]),
        run_id: String,
        sample: OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample,
        status: String
      }
    end
  end

  def test_list_required_params
    response = @openai.evals.runs.output_items.list("run_id", eval_id: "eval_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Evals::Runs::OutputItemListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        datasource_item: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]),
        datasource_item_id: Integer,
        eval_id: String,
        object: Symbol,
        results: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]]),
        run_id: String,
        sample: OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample,
        status: String
      }
    end
  end
end

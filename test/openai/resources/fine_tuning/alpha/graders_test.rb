# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::FineTuning::Alpha::GradersTest < OpenAI::Test::ResourceTest
  def test_run_required_params
    response =
      @openai.fine_tuning.alpha.graders.run(
        grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check},
        model_sample: "model_sample",
        reference_answer: "string"
      )

    assert_pattern do
      response => OpenAI::Models::FineTuning::Alpha::GraderRunResponse
    end

    assert_pattern do
      response => {
        metadata: OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata,
        model_grader_token_usage_per_model: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]),
        reward: Float,
        sub_rewards: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown])
      }
    end
  end

  def test_validate_required_params
    response =
      @openai.fine_tuning.alpha.graders.validate(
        grader: {input: "input", name: "name", operation: :eq, reference: "reference", type: :string_check}
      )

    assert_pattern do
      response => OpenAI::Models::FineTuning::Alpha::GraderValidateResponse
    end

    assert_pattern do
      response => {
        grader: OpenAI::Models::FineTuning::Alpha::GraderValidateResponse::Grader | nil
      }
    end
  end
end

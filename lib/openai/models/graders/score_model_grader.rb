# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class ScoreModelGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #   The input text. This may include template strings.
        #
        #   @return [Array<OpenAI::EvalItem>]
        required :input, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::EvalItem] }

        # @!attribute model
        #   The model to use for the evaluation.
        #
        #   @return [String]
        required :model, String

        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The object type, which is always `score_model`.
        #
        #   @return [Symbol, :score_model]
        required :type, const: :score_model

        # @!attribute range
        #   The range of the score. Defaults to `[0, 1]`.
        #
        #   @return [Array<Float>, nil]
        optional :range, OpenAI::Internal::Type::ArrayOf[Float]

        # @!attribute sampling_params
        #   The sampling parameters for the model.
        #
        #   @return [Object, nil]
        optional :sampling_params, OpenAI::Internal::Type::Unknown

        # @!method initialize(input:, model:, name:, range: nil, sampling_params: nil, type: :score_model)
        #   A ScoreModelGrader object that uses a model to assign a score to the input.
        #
        #   @param input [Array<OpenAI::EvalItem>] The input text. This may include template strings.
        #
        #   @param model [String] The model to use for the evaluation.
        #
        #   @param name [String] The name of the grader.
        #
        #   @param range [Array<Float>] The range of the score. Defaults to `[0, 1]`.
        #
        #   @param sampling_params [Object] The sampling parameters for the model.
        #
        #   @param type [Symbol, :score_model] The object type, which is always `score_model`.
      end
    end

    ScoreModelGrader = Graders::ScoreModelGrader
  end
end

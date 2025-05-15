# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class LabelModelGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #
        #   @return [Array<OpenAI::EvalItem>]
        required :input, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::EvalItem] }

        # @!attribute labels
        #   The labels to assign to each item in the evaluation.
        #
        #   @return [Array<String>]
        required :labels, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute model
        #   The model to use for the evaluation. Must support structured outputs.
        #
        #   @return [String]
        required :model, String

        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

        # @!attribute passing_labels
        #   The labels that indicate a passing result. Must be a subset of labels.
        #
        #   @return [Array<String>]
        required :passing_labels, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute type
        #   The object type, which is always `label_model`.
        #
        #   @return [Symbol, :label_model]
        required :type, const: :label_model

        # @!method initialize(input:, labels:, model:, name:, passing_labels:, type: :label_model)
        #   A LabelModelGrader object which uses a model to assign labels to each item in
        #   the evaluation.
        #
        #   @param input [Array<OpenAI::EvalItem>]
        #
        #   @param labels [Array<String>] The labels to assign to each item in the evaluation.
        #
        #   @param model [String] The model to use for the evaluation. Must support structured outputs.
        #
        #   @param name [String] The name of the grader.
        #
        #   @param passing_labels [Array<String>] The labels that indicate a passing result. Must be a subset of labels.
        #
        #   @param type [Symbol, :label_model] The object type, which is always `label_model`.
      end
    end

    LabelModelGrader = Graders::LabelModelGrader
  end
end

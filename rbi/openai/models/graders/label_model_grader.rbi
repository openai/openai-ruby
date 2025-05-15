# typed: strong

module OpenAI
  module Models
    LabelModelGrader = Graders::LabelModelGrader

    module Graders
      class LabelModelGrader < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Graders::LabelModelGrader, OpenAI::Internal::AnyHash)
          end

        sig { returns(T::Array[OpenAI::EvalItem]) }
        attr_accessor :input

        # The labels to assign to each item in the evaluation.
        sig { returns(T::Array[String]) }
        attr_accessor :labels

        # The model to use for the evaluation. Must support structured outputs.
        sig { returns(String) }
        attr_accessor :model

        # The name of the grader.
        sig { returns(String) }
        attr_accessor :name

        # The labels that indicate a passing result. Must be a subset of labels.
        sig { returns(T::Array[String]) }
        attr_accessor :passing_labels

        # The object type, which is always `label_model`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A LabelModelGrader object which uses a model to assign labels to each item in
        # the evaluation.
        sig do
          params(
            input: T::Array[OpenAI::EvalItem::OrHash],
            labels: T::Array[String],
            model: String,
            name: String,
            passing_labels: T::Array[String],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          input:,
          # The labels to assign to each item in the evaluation.
          labels:,
          # The model to use for the evaluation. Must support structured outputs.
          model:,
          # The name of the grader.
          name:,
          # The labels that indicate a passing result. Must be a subset of labels.
          passing_labels:,
          # The object type, which is always `label_model`.
          type: :label_model
        )
        end

        sig do
          override.returns(
            {
              input: T::Array[OpenAI::EvalItem],
              labels: T::Array[String],
              model: String,
              name: String,
              passing_labels: T::Array[String],
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end

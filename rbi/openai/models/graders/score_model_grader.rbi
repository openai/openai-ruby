# typed: strong

module OpenAI
  module Models
    ScoreModelGrader = Graders::ScoreModelGrader

    module Graders
      class ScoreModelGrader < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Graders::ScoreModelGrader, OpenAI::Internal::AnyHash)
          end

        # The input text. This may include template strings.
        sig { returns(T::Array[OpenAI::EvalItem]) }
        attr_accessor :input

        # The model to use for the evaluation.
        sig { returns(String) }
        attr_accessor :model

        # The name of the grader.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is always `score_model`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The range of the score. Defaults to `[0, 1]`.
        sig { returns(T.nilable(T::Array[Float])) }
        attr_reader :range

        sig { params(range: T::Array[Float]).void }
        attr_writer :range

        # The sampling parameters for the model.
        sig { returns(T.nilable(T.anything)) }
        attr_reader :sampling_params

        sig { params(sampling_params: T.anything).void }
        attr_writer :sampling_params

        # A ScoreModelGrader object that uses a model to assign a score to the input.
        sig do
          params(
            input: T::Array[OpenAI::EvalItem::OrHash],
            model: String,
            name: String,
            range: T::Array[Float],
            sampling_params: T.anything,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The input text. This may include template strings.
          input:,
          # The model to use for the evaluation.
          model:,
          # The name of the grader.
          name:,
          # The range of the score. Defaults to `[0, 1]`.
          range: nil,
          # The sampling parameters for the model.
          sampling_params: nil,
          # The object type, which is always `score_model`.
          type: :score_model
        )
        end

        sig do
          override.returns(
            {
              input: T::Array[OpenAI::EvalItem],
              model: String,
              name: String,
              type: Symbol,
              range: T::Array[Float],
              sampling_params: T.anything
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end

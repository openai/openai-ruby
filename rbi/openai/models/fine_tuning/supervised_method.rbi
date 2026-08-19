# typed: strong

module OpenAI
  module Models

    module FineTuning

      class SupervisedMethod < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::FineTuning::SupervisedMethod,
            OpenAI::Internal::AnyHash
          )
        end

        # The hyperparameters used for the fine-tuning job.
        sig { returns(T.nilable(OpenAI::FineTuning::SupervisedHyperparameters)) }
        attr_reader :hyperparameters

        sig { params(hyperparameters: OpenAI::FineTuning::SupervisedHyperparameters::OrHash).void }
        attr_writer :hyperparameters

        # Configuration for the supervised fine-tuning method.
        sig do
          params(

            hyperparameters: OpenAI::FineTuning::SupervisedHyperparameters::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The hyperparameters used for the fine-tuning job.

          hyperparameters: nil
        )
        end

        sig do
          override.returns(
            {hyperparameters: OpenAI::FineTuning::SupervisedHyperparameters}
          )
        end
        def to_hash
        end

      end

    end

  end
end

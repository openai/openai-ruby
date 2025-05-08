# typed: strong

module OpenAI
  module Models
    module FineTuning
      class DpoMethod < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The hyperparameters used for the DPO fine-tuning job.
        sig { returns(T.nilable(OpenAI::FineTuning::DpoHyperparameters)) }
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters: OpenAI::FineTuning::DpoHyperparameters::OrHash
          ).void
        end
        attr_writer :hyperparameters

        # Configuration for the DPO fine-tuning method.
        sig do
          params(
            hyperparameters: OpenAI::FineTuning::DpoHyperparameters::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The hyperparameters used for the DPO fine-tuning job.
          hyperparameters: nil
        )
        end

        sig do
          override.returns(
            { hyperparameters: OpenAI::FineTuning::DpoHyperparameters }
          )
        end
        def to_hash
        end
      end
    end
  end
end

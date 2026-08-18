# typed: strong

module OpenAI
  module Models
    FineTuningJobWandbIntegrationObject =
      FineTuning::FineTuningJobWandbIntegrationObject

    module FineTuning
      class FineTuningJobWandbIntegrationObject < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::FineTuningJobWandbIntegrationObject,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the integration being enabled for the fine-tuning job
        sig { returns(Symbol) }
        attr_accessor :type

        # The settings for your integration with Weights and Biases. This payload
        # specifies the project that metrics will be sent to. Optionally, you can set an
        # explicit display name for your run, add tags to your run, and set a default
        # entity (team, username, etc) to be associated with your run.
        sig { returns(OpenAI::FineTuning::FineTuningJobWandbIntegration) }
        attr_reader :wandb

        sig do
          params(
            wandb: OpenAI::FineTuning::FineTuningJobWandbIntegration::OrHash
          ).void
        end
        attr_writer :wandb

        sig do
          params(
            wandb: OpenAI::FineTuning::FineTuningJobWandbIntegration::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The settings for your integration with Weights and Biases. This payload
          # specifies the project that metrics will be sent to. Optionally, you can set an
          # explicit display name for your run, add tags to your run, and set a default
          # entity (team, username, etc) to be associated with your run.
          wandb:,
          # The type of the integration being enabled for the fine-tuning job
          type: :wandb
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              wandb: OpenAI::FineTuning::FineTuningJobWandbIntegration
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end

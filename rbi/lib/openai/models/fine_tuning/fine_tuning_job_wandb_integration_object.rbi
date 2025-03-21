# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobWandbIntegrationObject < OpenAI::BaseModel
        # The type of the integration being enabled for the fine-tuning job
        sig { returns(Symbol) }
        attr_accessor :type

        # The settings for your integration with Weights and Biases. This payload
        #   specifies the project that metrics will be sent to. Optionally, you can set an
        #   explicit display name for your run, add tags to your run, and set a default
        #   entity (team, username, etc) to be associated with your run.
        sig { returns(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration) }
        attr_reader :wandb

        sig { params(wandb: T.any(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration, OpenAI::Util::AnyHash)).void }
        attr_writer :wandb

        sig do
          params(
            wandb: T.any(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration, OpenAI::Util::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(wandb:, type: :wandb)
        end

        sig { override.returns({type: Symbol, wandb: OpenAI::Models::FineTuning::FineTuningJobWandbIntegration}) }
        def to_hash
        end
      end
    end

    FineTuningJobWandbIntegrationObject = FineTuning::FineTuningJobWandbIntegrationObject
  end
end

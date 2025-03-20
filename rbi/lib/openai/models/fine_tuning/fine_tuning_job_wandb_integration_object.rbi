# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobWandbIntegrationObject < OpenAI::BaseModel
        # The type of the integration being enabled for the fine-tuning job
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The settings for your integration with Weights and Biases. This payload
        #   specifies the project that metrics will be sent to. Optionally, you can set an
        #   explicit display name for your run, add tags to your run, and set a default
        #   entity (team, username, etc) to be associated with your run.
        sig { returns(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration) }
        def wandb
        end

        sig do
          params(_: T.any(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration, OpenAI::Util::AnyHash))
        end
        def wandb=(_)
        end

        sig do
          params(wandb: OpenAI::Models::FineTuning::FineTuningJobWandbIntegration, type: Symbol)
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

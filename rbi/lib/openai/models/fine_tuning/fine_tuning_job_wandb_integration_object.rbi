# typed: strong

module OpenAI
  module Models
    FineTuningJobWandbIntegrationObject = T.type_alias { FineTuning::FineTuningJobWandbIntegrationObject }

    module FineTuning
      class FineTuningJobWandbIntegrationObject < OpenAI::BaseModel
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration) }
        def wandb
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJobWandbIntegration)
            .returns(OpenAI::Models::FineTuning::FineTuningJobWandbIntegration)
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
  end
end

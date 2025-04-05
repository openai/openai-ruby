# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobWandbIntegrationObject < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the integration being enabled for the fine-tuning job
        #
        #   @return [Symbol, :wandb]
        required :type, const: :wandb

        # @!attribute wandb
        #   The settings for your integration with Weights and Biases. This payload
        #   specifies the project that metrics will be sent to. Optionally, you can set an
        #   explicit display name for your run, add tags to your run, and set a default
        #   entity (team, username, etc) to be associated with your run.
        #
        #   @return [OpenAI::Models::FineTuning::FineTuningJobWandbIntegration]
        required :wandb, -> { OpenAI::Models::FineTuning::FineTuningJobWandbIntegration }

        # @!parse
        #   # @param wandb [OpenAI::Models::FineTuning::FineTuningJobWandbIntegration]
        #   # @param type [Symbol, :wandb]
        #   #
        #   def initialize(wandb:, type: :wandb, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    FineTuningJobWandbIntegrationObject = FineTuning::FineTuningJobWandbIntegrationObject
  end
end

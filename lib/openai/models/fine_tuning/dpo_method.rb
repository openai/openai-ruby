# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module FineTuning
      class DpoMethod < OpenAI::Internal::Type::BaseModel
        # @!attribute hyperparameters
        #   The hyperparameters used for the DPO fine-tuning job.
        #
        #   @return [OpenAI::Models::FineTuning::DpoHyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::FineTuning::DpoHyperparameters }

        # @!method initialize(hyperparameters: nil)
        #   Configuration for the DPO fine-tuning method.
        #
        #   @param hyperparameters [OpenAI::Models::FineTuning::DpoHyperparameters] The hyperparameters used for the DPO fine-tuning job.
      end
    end
  end
end

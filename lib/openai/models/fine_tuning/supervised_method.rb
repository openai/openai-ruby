# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module FineTuning
      class SupervisedMethod < OpenAI::Internal::Type::BaseModel
        # @!attribute hyperparameters
        #   The hyperparameters used for the fine-tuning job.
        #
        #   @return [OpenAI::Models::FineTuning::SupervisedHyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::FineTuning::SupervisedHyperparameters }

        # @!method initialize(hyperparameters: nil)
        #   Configuration for the supervised fine-tuning method.
        #
        #   @param hyperparameters [OpenAI::Models::FineTuning::SupervisedHyperparameters] The hyperparameters used for the fine-tuning job.
      end
    end
  end
end

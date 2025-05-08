# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class SupervisedMethod < OpenAI::Internal::Type::BaseModel
        # @!attribute hyperparameters
        #   The hyperparameters used for the fine-tuning job.
        #
        #   @return [OpenAI::FineTuning::SupervisedHyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::FineTuning::SupervisedHyperparameters }

        # @!method initialize(hyperparameters: nil)
        #   Configuration for the supervised fine-tuning method.
        #
        #   @param hyperparameters [OpenAI::FineTuning::SupervisedHyperparameters] The hyperparameters used for the fine-tuning job.
      end
    end
  end
end

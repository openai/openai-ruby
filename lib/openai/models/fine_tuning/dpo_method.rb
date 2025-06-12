# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class DpoMethod < OpenAI::Internal::Type::BaseModel
        # @!attribute hyperparameters
        #   The hyperparameters used for the fine-tuning job.
        #
        #   @return [OpenAI::Models::FineTuning::DpoMethod::Hyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::FineTuning::DpoMethod::Hyperparameters }

        # @!method initialize(hyperparameters: nil)
        #   Configuration for the DPO fine-tuning method.
        #
        #   @param hyperparameters [OpenAI::Models::FineTuning::DpoMethod::Hyperparameters] The hyperparameters used for the fine-tuning job.

        # @see OpenAI::Models::FineTuning::DpoMethod#hyperparameters
        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          # @!attribute batch_size
          #   Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :batch_size, union: -> { OpenAI::FineTuning::DpoMethod::Hyperparameters::BatchSize }

          # @!attribute beta
          #   The beta value for the DPO method. A higher beta value will increase the weight
          #   of the penalty between the policy and reference model.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :beta, union: -> { OpenAI::FineTuning::DpoMethod::Hyperparameters::Beta }

          # @!attribute learning_rate_multiplier
          #   Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :learning_rate_multiplier,
                   union: -> { OpenAI::FineTuning::DpoMethod::Hyperparameters::LearningRateMultiplier }

          # @!attribute n_epochs
          #   The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :n_epochs, union: -> { OpenAI::FineTuning::DpoMethod::Hyperparameters::NEpochs }

          # @!method initialize(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::FineTuning::DpoMethod::Hyperparameters} for more details.
          #
          #   The hyperparameters used for the fine-tuning job.
          #
          #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
          #
          #   @param beta [Symbol, :auto, Float] The beta value for the DPO method. A higher beta value will increase the weight
          #
          #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
          #
          #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle t

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          #
          # @see OpenAI::Models::FineTuning::DpoMethod::Hyperparameters#batch_size
          module BatchSize
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Integer)]
          end

          # The beta value for the DPO method. A higher beta value will increase the weight
          # of the penalty between the policy and reference model.
          #
          # @see OpenAI::Models::FineTuning::DpoMethod::Hyperparameters#beta
          module Beta
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Float

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Float)]
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          #
          # @see OpenAI::Models::FineTuning::DpoMethod::Hyperparameters#learning_rate_multiplier
          module LearningRateMultiplier
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Float

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Float)]
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          #
          # @see OpenAI::Models::FineTuning::DpoMethod::Hyperparameters#n_epochs
          module NEpochs
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Integer)]
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class SupervisedHyperparameters < OpenAI::Internal::Type::BaseModel
        # @!attribute batch_size
        #   Number of examples in each batch. A larger batch size means that model
        #   parameters are updated less frequently, but with lower variance.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :batch_size, union: -> { OpenAI::FineTuning::SupervisedHyperparameters::BatchSize }

        # @!attribute learning_rate_multiplier
        #   Scaling factor for the learning rate. A smaller learning rate may be useful to
        #   avoid overfitting.
        #
        #   @return [Symbol, :auto, Float, nil]
        optional :learning_rate_multiplier,
                 union: -> { OpenAI::FineTuning::SupervisedHyperparameters::LearningRateMultiplier }

        # @!attribute n_epochs
        #   The number of epochs to train the model for. An epoch refers to one full cycle
        #   through the training dataset.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :n_epochs, union: -> { OpenAI::FineTuning::SupervisedHyperparameters::NEpochs }

        # @!method initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::FineTuning::SupervisedHyperparameters} for more details.
        #
        #   The hyperparameters used for the fine-tuning job.
        #
        #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
        #
        #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
        #
        #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle t

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        #
        # @see OpenAI::FineTuning::SupervisedHyperparameters#batch_size
        module BatchSize
          extend OpenAI::Internal::Type::Union

          variant const: :auto

          variant Integer

          # @!method self.variants
          #   @return [Array(Symbol, :auto, Integer)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(Symbol, Integer) }
          end
        end

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        #
        # @see OpenAI::FineTuning::SupervisedHyperparameters#learning_rate_multiplier
        module LearningRateMultiplier
          extend OpenAI::Internal::Type::Union

          variant const: :auto

          variant Float

          # @!method self.variants
          #   @return [Array(Symbol, :auto, Float)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(Symbol, Float) }
          end
        end

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        #
        # @see OpenAI::FineTuning::SupervisedHyperparameters#n_epochs
        module NEpochs
          extend OpenAI::Internal::Type::Union

          variant const: :auto

          variant Integer

          # @!method self.variants
          #   @return [Array(Symbol, :auto, Integer)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(Symbol, Integer) }
          end
        end
      end
    end
  end
end

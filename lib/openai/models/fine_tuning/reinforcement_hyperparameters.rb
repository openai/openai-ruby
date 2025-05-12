# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class ReinforcementHyperparameters < OpenAI::Internal::Type::BaseModel
        # @!attribute batch_size
        #   Number of examples in each batch. A larger batch size means that model
        #   parameters are updated less frequently, but with lower variance.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :batch_size, union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize }

        # @!attribute compute_multiplier
        #   Multiplier on amount of compute used for exploring search space during training.
        #
        #   @return [Symbol, :auto, Float, nil]
        optional :compute_multiplier,
                 union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier }

        # @!attribute eval_interval
        #   The number of training steps between evaluation runs.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :eval_interval, union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval }

        # @!attribute eval_samples
        #   Number of evaluation samples to generate per training step.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :eval_samples, union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples }

        # @!attribute learning_rate_multiplier
        #   Scaling factor for the learning rate. A smaller learning rate may be useful to
        #   avoid overfitting.
        #
        #   @return [Symbol, :auto, Float, nil]
        optional :learning_rate_multiplier,
                 union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier }

        # @!attribute n_epochs
        #   The number of epochs to train the model for. An epoch refers to one full cycle
        #   through the training dataset.
        #
        #   @return [Symbol, :auto, Integer, nil]
        optional :n_epochs, union: -> { OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs }

        # @!attribute reasoning_effort
        #   Level of reasoning effort.
        #
        #   @return [Symbol, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort, nil]
        optional :reasoning_effort,
                 enum: -> {
                   OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort
                 }

        # @!method initialize(batch_size: nil, compute_multiplier: nil, eval_interval: nil, eval_samples: nil, learning_rate_multiplier: nil, n_epochs: nil, reasoning_effort: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::FineTuning::ReinforcementHyperparameters} for more details.
        #
        #   The hyperparameters used for the reinforcement fine-tuning job.
        #
        #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
        #
        #   @param compute_multiplier [Symbol, :auto, Float] Multiplier on amount of compute used for exploring search space during training.
        #
        #   @param eval_interval [Symbol, :auto, Integer] The number of training steps between evaluation runs.
        #
        #   @param eval_samples [Symbol, :auto, Integer] Number of evaluation samples to generate per training step.
        #
        #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
        #
        #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle t
        #
        #   @param reasoning_effort [Symbol, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort] Level of reasoning effort.

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        #
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#batch_size
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

        # Multiplier on amount of compute used for exploring search space during training.
        #
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#compute_multiplier
        module ComputeMultiplier
          extend OpenAI::Internal::Type::Union

          variant const: :auto

          variant Float

          # @!method self.variants
          #   @return [Array(Symbol, :auto, Float)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(Symbol, Float) }
          end
        end

        # The number of training steps between evaluation runs.
        #
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#eval_interval
        module EvalInterval
          extend OpenAI::Internal::Type::Union

          variant const: :auto

          variant Integer

          # @!method self.variants
          #   @return [Array(Symbol, :auto, Integer)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(Symbol, Integer) }
          end
        end

        # Number of evaluation samples to generate per training step.
        #
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#eval_samples
        module EvalSamples
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
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#learning_rate_multiplier
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
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#n_epochs
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

        # Level of reasoning effort.
        #
        # @see OpenAI::FineTuning::ReinforcementHyperparameters#reasoning_effort
        module ReasoningEffort
          extend OpenAI::Internal::Type::Enum

          DEFAULT = :default
          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

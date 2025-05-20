# typed: strong

module OpenAI
  module Models
    module FineTuning
      class ReinforcementHyperparameters < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::ReinforcementHyperparameters,
              OpenAI::Internal::AnyHash
            )
          end

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants
            )
          )
        end
        attr_reader :batch_size

        sig do
          params(
            batch_size:
              OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants
          ).void
        end
        attr_writer :batch_size

        # Multiplier on amount of compute used for exploring search space during training.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants
            )
          )
        end
        attr_reader :compute_multiplier

        sig do
          params(
            compute_multiplier:
              OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants
          ).void
        end
        attr_writer :compute_multiplier

        # The number of training steps between evaluation runs.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants
            )
          )
        end
        attr_reader :eval_interval

        sig do
          params(
            eval_interval:
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants
          ).void
        end
        attr_writer :eval_interval

        # Number of evaluation samples to generate per training step.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants
            )
          )
        end
        attr_reader :eval_samples

        sig do
          params(
            eval_samples:
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants
          ).void
        end
        attr_writer :eval_samples

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants
            )
          )
        end
        attr_reader :learning_rate_multiplier

        sig do
          params(
            learning_rate_multiplier:
              OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants
          ).void
        end
        attr_writer :learning_rate_multiplier

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants
            )
          )
        end
        attr_reader :n_epochs

        sig do
          params(
            n_epochs:
              OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants
          ).void
        end
        attr_writer :n_epochs

        # Level of reasoning effort.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
            )
          )
        end
        attr_reader :reasoning_effort

        sig do
          params(
            reasoning_effort:
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
          ).void
        end
        attr_writer :reasoning_effort

        # The hyperparameters used for the reinforcement fine-tuning job.
        sig do
          params(
            batch_size:
              OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants,
            compute_multiplier:
              OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants,
            eval_interval:
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants,
            eval_samples:
              OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants,
            learning_rate_multiplier:
              OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants,
            n_epochs:
              OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants,
            reasoning_effort:
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          batch_size: nil,
          # Multiplier on amount of compute used for exploring search space during training.
          compute_multiplier: nil,
          # The number of training steps between evaluation runs.
          eval_interval: nil,
          # Number of evaluation samples to generate per training step.
          eval_samples: nil,
          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          learning_rate_multiplier: nil,
          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          n_epochs: nil,
          # Level of reasoning effort.
          reasoning_effort: nil
        )
        end

        sig do
          override.returns(
            {
              batch_size:
                OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants,
              compute_multiplier:
                OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants,
              eval_interval:
                OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants,
              eval_samples:
                OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants,
              learning_rate_multiplier:
                OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants,
              n_epochs:
                OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants,
              reasoning_effort:
                OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
            }
          )
        end
        def to_hash
        end

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        module BatchSize
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Multiplier on amount of compute used for exploring search space during training.
        module ComputeMultiplier
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Float) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The number of training steps between evaluation runs.
        module EvalInterval
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Number of evaluation samples to generate per training step.
        module EvalSamples
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        module LearningRateMultiplier
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Float) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        module NEpochs
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Level of reasoning effort.
        module ReasoningEffort
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DEFAULT =
            T.let(
              :default,
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol
            )
          LOW =
            T.let(
              :low,
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end

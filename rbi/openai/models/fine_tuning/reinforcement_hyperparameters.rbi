# typed: strong

module OpenAI
  module Models

    module FineTuning

      class ReinforcementHyperparameters < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::FineTuning::ReinforcementHyperparameters,
            OpenAI::Internal::AnyHash
          )
        end

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        sig { returns(T.nilable(T.any(Symbol, Integer))) }
        attr_reader :batch_size

        sig { params(batch_size: T.any(Symbol, Integer)).void }
        attr_writer :batch_size

        # Multiplier on amount of compute used for exploring search space during training.
        sig { returns(T.nilable(T.any(Symbol, Float))) }
        attr_reader :compute_multiplier

        sig { params(compute_multiplier: T.any(Symbol, Float)).void }
        attr_writer :compute_multiplier

        # The number of training steps between evaluation runs.
        sig { returns(T.nilable(T.any(Symbol, Integer))) }
        attr_reader :eval_interval

        sig { params(eval_interval: T.any(Symbol, Integer)).void }
        attr_writer :eval_interval

        # Number of evaluation samples to generate per training step.
        sig { returns(T.nilable(T.any(Symbol, Integer))) }
        attr_reader :eval_samples

        sig { params(eval_samples: T.any(Symbol, Integer)).void }
        attr_writer :eval_samples

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        sig { returns(T.nilable(T.any(Symbol, Float))) }
        attr_reader :learning_rate_multiplier

        sig { params(learning_rate_multiplier: T.any(Symbol, Float)).void }
        attr_writer :learning_rate_multiplier

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        sig { returns(T.nilable(T.any(Symbol, Integer))) }
        attr_reader :n_epochs

        sig { params(n_epochs: T.any(Symbol, Integer)).void }
        attr_writer :n_epochs

        # Level of reasoning effort.
        sig { returns(T.nilable(OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol)) }
        attr_reader :reasoning_effort

        sig {
          params(reasoning_effort: OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol).void
        }
        attr_writer :reasoning_effort

        # The hyperparameters used for the reinforcement fine-tuning job.
        sig do
          params(

            batch_size: T.any(Symbol, Integer),

            compute_multiplier: T.any(Symbol, Float),

            eval_interval: T.any(Symbol, Integer),

            eval_samples: T.any(Symbol, Integer),

            learning_rate_multiplier: T.any(Symbol, Float),

            n_epochs: T.any(Symbol, Integer),

            reasoning_effort: OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
          )
            .returns(T.attached_class)
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
              batch_size: T.any(Symbol, Integer),
              compute_multiplier: T.any(Symbol, Float),
              eval_interval: T.any(Symbol, Integer),
              eval_samples: T.any(Symbol, Integer),
              learning_rate_multiplier: T.any(Symbol, Float),
              n_epochs: T.any(Symbol, Integer),
              reasoning_effort: OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::OrSymbol
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

          sig { override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::BatchSize::Variants]) }
          def self.variants
          end

        end

        # Multiplier on amount of compute used for exploring search space during training.
        module ComputeMultiplier
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Float) }

          sig {
            override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::ComputeMultiplier::Variants])
          }
          def self.variants
          end

        end

        # The number of training steps between evaluation runs.
        module EvalInterval
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig { override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::EvalInterval::Variants]) }
          def self.variants
          end

        end

        # Number of evaluation samples to generate per training step.
        module EvalSamples
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig { override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::EvalSamples::Variants]) }
          def self.variants
          end

        end

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        module LearningRateMultiplier
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Float) }

          sig {
            override.returns(
              T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::LearningRateMultiplier::Variants]
            )
          }
          def self.variants
          end

        end

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        module NEpochs
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Integer) }

          sig { override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::NEpochs::Variants]) }
          def self.variants
          end

        end

        # Level of reasoning effort.
        module ReasoningEffort
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias {
            T.all(Symbol, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort)
          }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DEFAULT = T.let(:default, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol)
          LOW = T.let(:low, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol)
          MEDIUM = T.let(:medium, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol)

          sig {
            override.returns(T::Array[OpenAI::FineTuning::ReinforcementHyperparameters::ReasoningEffort::TaggedSymbol])
          }
          def self.values
          end
        end

      end

    end

  end
end

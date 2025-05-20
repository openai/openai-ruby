# typed: strong

module OpenAI
  module Models
    module FineTuning
      class DpoHyperparameters < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::DpoHyperparameters,
              OpenAI::Internal::AnyHash
            )
          end

        # Number of examples in each batch. A larger batch size means that model
        # parameters are updated less frequently, but with lower variance.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::DpoHyperparameters::BatchSize::Variants
            )
          )
        end
        attr_reader :batch_size

        sig do
          params(
            batch_size:
              OpenAI::FineTuning::DpoHyperparameters::BatchSize::Variants
          ).void
        end
        attr_writer :batch_size

        # The beta value for the DPO method. A higher beta value will increase the weight
        # of the penalty between the policy and reference model.
        sig do
          returns(
            T.nilable(OpenAI::FineTuning::DpoHyperparameters::Beta::Variants)
          )
        end
        attr_reader :beta

        sig do
          params(
            beta: OpenAI::FineTuning::DpoHyperparameters::Beta::Variants
          ).void
        end
        attr_writer :beta

        # Scaling factor for the learning rate. A smaller learning rate may be useful to
        # avoid overfitting.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::DpoHyperparameters::LearningRateMultiplier::Variants
            )
          )
        end
        attr_reader :learning_rate_multiplier

        sig do
          params(
            learning_rate_multiplier:
              OpenAI::FineTuning::DpoHyperparameters::LearningRateMultiplier::Variants
          ).void
        end
        attr_writer :learning_rate_multiplier

        # The number of epochs to train the model for. An epoch refers to one full cycle
        # through the training dataset.
        sig do
          returns(
            T.nilable(OpenAI::FineTuning::DpoHyperparameters::NEpochs::Variants)
          )
        end
        attr_reader :n_epochs

        sig do
          params(
            n_epochs: OpenAI::FineTuning::DpoHyperparameters::NEpochs::Variants
          ).void
        end
        attr_writer :n_epochs

        # The hyperparameters used for the DPO fine-tuning job.
        sig do
          params(
            batch_size:
              OpenAI::FineTuning::DpoHyperparameters::BatchSize::Variants,
            beta: OpenAI::FineTuning::DpoHyperparameters::Beta::Variants,
            learning_rate_multiplier:
              OpenAI::FineTuning::DpoHyperparameters::LearningRateMultiplier::Variants,
            n_epochs: OpenAI::FineTuning::DpoHyperparameters::NEpochs::Variants
          ).returns(T.attached_class)
        end
        def self.new(
          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          batch_size: nil,
          # The beta value for the DPO method. A higher beta value will increase the weight
          # of the penalty between the policy and reference model.
          beta: nil,
          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          learning_rate_multiplier: nil,
          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          n_epochs: nil
        )
        end

        sig do
          override.returns(
            {
              batch_size:
                OpenAI::FineTuning::DpoHyperparameters::BatchSize::Variants,
              beta: OpenAI::FineTuning::DpoHyperparameters::Beta::Variants,
              learning_rate_multiplier:
                OpenAI::FineTuning::DpoHyperparameters::LearningRateMultiplier::Variants,
              n_epochs:
                OpenAI::FineTuning::DpoHyperparameters::NEpochs::Variants
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
                OpenAI::FineTuning::DpoHyperparameters::BatchSize::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The beta value for the DPO method. A higher beta value will increase the weight
        # of the penalty between the policy and reference model.
        module Beta
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Symbol, Float) }

          sig do
            override.returns(
              T::Array[OpenAI::FineTuning::DpoHyperparameters::Beta::Variants]
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
                OpenAI::FineTuning::DpoHyperparameters::LearningRateMultiplier::Variants
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
                OpenAI::FineTuning::DpoHyperparameters::NEpochs::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end

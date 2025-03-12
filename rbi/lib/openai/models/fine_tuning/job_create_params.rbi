# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(String) }
        def training_file
        end

        sig { params(_: String).returns(String) }
        def training_file=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)) }
        def hyperparameters
        end

        sig do
          params(_: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)
            .returns(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)
        end
        def hyperparameters=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration])) }
        def integrations
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]))
            .returns(T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]))
        end
        def integrations=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method)) }
        def method_
        end

        sig do
          params(_: OpenAI::Models::FineTuning::JobCreateParams::Method)
            .returns(OpenAI::Models::FineTuning::JobCreateParams::Method)
        end
        def method_=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def seed
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def seed=(_)
        end

        sig { returns(T.nilable(String)) }
        def suffix
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def suffix=(_)
        end

        sig { returns(T.nilable(String)) }
        def validation_file
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def validation_file=(_)
        end

        sig do
          params(
            model: T.any(String, Symbol),
            training_file: String,
            hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters,
            integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]),
            metadata: T.nilable(OpenAI::Models::Metadata),
            method_: OpenAI::Models::FineTuning::JobCreateParams::Method,
            seed: T.nilable(Integer),
            suffix: T.nilable(String),
            validation_file: T.nilable(String),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          model:,
          training_file:,
          hyperparameters: nil,
          integrations: nil,
          metadata: nil,
          method_: nil,
          seed: nil,
          suffix: nil,
          validation_file: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                model: T.any(String, Symbol),
                training_file: String,
                hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters,
                integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]),
                metadata: T.nilable(OpenAI::Models::Metadata),
                method_: OpenAI::Models::FineTuning::JobCreateParams::Method,
                seed: T.nilable(Integer),
                suffix: T.nilable(String),
                validation_file: T.nilable(String),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Model < OpenAI::Union
          abstract!

          class Preset < OpenAI::Enum
            abstract!

            BABBAGE_002 = :"babbage-002"
            DAVINCI_002 = :"davinci-002"
            GPT_3_5_TURBO = :"gpt-3.5-turbo"
            GPT_4O_MINI = :"gpt-4o-mini"

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class Hyperparameters < OpenAI::BaseModel
          sig { returns(T.nilable(T.any(Symbol, Integer))) }
          def batch_size
          end

          sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
          def batch_size=(_)
          end

          sig { returns(T.nilable(T.any(Symbol, Float))) }
          def learning_rate_multiplier
          end

          sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
          def learning_rate_multiplier=(_)
          end

          sig { returns(T.nilable(T.any(Symbol, Integer))) }
          def n_epochs
          end

          sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
          def n_epochs=(_)
          end

          sig do
            params(
              batch_size: T.any(Symbol, Integer),
              learning_rate_multiplier: T.any(Symbol, Float),
              n_epochs: T.any(Symbol, Integer)
            )
              .returns(T.attached_class)
          end
          def self.new(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
          end

          sig do
            override
              .returns(
                {
                  batch_size: T.any(Symbol, Integer),
                  learning_rate_multiplier: T.any(Symbol, Float),
                  n_epochs: T.any(Symbol, Integer)
                }
              )
          end
          def to_hash
          end

          class BatchSize < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
              private def variants
              end
            end
          end

          class LearningRateMultiplier < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([[NilClass, Symbol], [NilClass, Float]]) }
              private def variants
              end
            end
          end

          class NEpochs < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
              private def variants
              end
            end
          end
        end

        class Integration < OpenAI::BaseModel
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb) }
          def wandb
          end

          sig do
            params(_: OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb)
              .returns(OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb)
          end
          def wandb=(_)
          end

          sig do
            params(wandb: OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb, type: Symbol)
              .returns(T.attached_class)
          end
          def self.new(wandb:, type: :wandb)
          end

          sig { override.returns({type: Symbol, wandb: OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb}) }
          def to_hash
          end

          class Wandb < OpenAI::BaseModel
            sig { returns(String) }
            def project
            end

            sig { params(_: String).returns(String) }
            def project=(_)
            end

            sig { returns(T.nilable(String)) }
            def entity
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def entity=(_)
            end

            sig { returns(T.nilable(String)) }
            def name
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def name=(_)
            end

            sig { returns(T.nilable(T::Array[String])) }
            def tags
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def tags=(_)
            end

            sig do
              params(
                project: String,
                entity: T.nilable(String),
                name: T.nilable(String),
                tags: T::Array[String]
              )
                .returns(T.attached_class)
            end
            def self.new(project:, entity: nil, name: nil, tags: nil)
            end

            sig do
              override
                .returns({
                           project: String,
                           entity: T.nilable(String),
                           name: T.nilable(String),
                           tags: T::Array[String]
                         })
            end
            def to_hash
            end
          end
        end

        class Method < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)) }
          def dpo
          end

          sig do
            params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)
              .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)
          end
          def dpo=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)) }
          def supervised
          end

          sig do
            params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)
              .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)
          end
          def supervised=(_)
          end

          sig { returns(T.nilable(Symbol)) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig do
            params(
              dpo: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo,
              supervised: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(dpo: nil, supervised: nil, type: nil)
          end

          sig do
            override
              .returns(
                {
                  dpo: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo,
                  supervised: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised,
                  type: Symbol
                }
              )
          end
          def to_hash
          end

          class Dpo < OpenAI::BaseModel
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            sig do
              params(hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil)
            end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters})
            end
            def to_hash
            end

            class Hyperparameters < OpenAI::BaseModel
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def batch_size
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def batch_size=(_)
              end

              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def beta
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def beta=(_)
              end

              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def learning_rate_multiplier
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def learning_rate_multiplier=(_)
              end

              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def n_epochs
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def n_epochs=(_)
              end

              sig do
                params(
                  batch_size: T.any(Symbol, Integer),
                  beta: T.any(Symbol, Float),
                  learning_rate_multiplier: T.any(Symbol, Float),
                  n_epochs: T.any(Symbol, Integer)
                )
                  .returns(T.attached_class)
              end
              def self.new(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil)
              end

              sig do
                override
                  .returns(
                    {
                      batch_size: T.any(Symbol, Integer),
                      beta: T.any(Symbol, Float),
                      learning_rate_multiplier: T.any(Symbol, Float),
                      n_epochs: T.any(Symbol, Integer)
                    }
                  )
              end
              def to_hash
              end

              class BatchSize < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
                  private def variants
                  end
                end
              end

              class Beta < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Float]]) }
                  private def variants
                  end
                end
              end

              class LearningRateMultiplier < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Float]]) }
                  private def variants
                  end
                end
              end

              class NEpochs < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
                  private def variants
                  end
                end
              end
            end
          end

          class Supervised < OpenAI::BaseModel
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            sig do
              params(hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil)
            end

            sig do
              override
                .returns(
                  {hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters}
                )
            end
            def to_hash
            end

            class Hyperparameters < OpenAI::BaseModel
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def batch_size
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def batch_size=(_)
              end

              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def learning_rate_multiplier
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def learning_rate_multiplier=(_)
              end

              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def n_epochs
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def n_epochs=(_)
              end

              sig do
                params(
                  batch_size: T.any(Symbol, Integer),
                  learning_rate_multiplier: T.any(Symbol, Float),
                  n_epochs: T.any(Symbol, Integer)
                )
                  .returns(T.attached_class)
              end
              def self.new(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
              end

              sig do
                override
                  .returns(
                    {
                      batch_size: T.any(Symbol, Integer),
                      learning_rate_multiplier: T.any(Symbol, Float),
                      n_epochs: T.any(Symbol, Integer)
                    }
                  )
              end
              def to_hash
              end

              class BatchSize < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
                  private def variants
                  end
                end
              end

              class LearningRateMultiplier < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Float]]) }
                  private def variants
                  end
                end
              end

              class NEpochs < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([[NilClass, Symbol], [NilClass, Integer]]) }
                  private def variants
                  end
                end
              end
            end
          end

          class Type < OpenAI::Enum
            abstract!

            SUPERVISED = :supervised
            DPO = :dpo

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    FineTuningJob = T.type_alias { FineTuning::FineTuningJob }

    module FineTuning
      class FineTuningJob < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error)) }
        def error
        end

        sig do
          params(_: T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error))
            .returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error))
        end
        def error=(_)
        end

        sig { returns(T.nilable(String)) }
        def fine_tuned_model
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def fine_tuned_model=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def finished_at
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def finished_at=(_)
        end

        sig { returns(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters) }
        def hyperparameters
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters)
            .returns(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters)
        end
        def hyperparameters=(_)
        end

        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(String) }
        def organization_id
        end

        sig { params(_: String).returns(String) }
        def organization_id=(_)
        end

        sig { returns(T::Array[String]) }
        def result_files
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def result_files=(_)
        end

        sig { returns(Integer) }
        def seed
        end

        sig { params(_: Integer).returns(Integer) }
        def seed=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def trained_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def trained_tokens=(_)
        end

        sig { returns(String) }
        def training_file
        end

        sig { params(_: String).returns(String) }
        def training_file=(_)
        end

        sig { returns(T.nilable(String)) }
        def validation_file
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def validation_file=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def estimated_finish
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def estimated_finish=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject])) }
        def integrations
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]))
            .returns(T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]))
        end
        def integrations=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method)) }
        def method_
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJob::Method)
            .returns(OpenAI::Models::FineTuning::FineTuningJob::Method)
        end
        def method_=(_)
        end

        sig do
          params(
            id: String,
            created_at: Integer,
            error: T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error),
            fine_tuned_model: T.nilable(String),
            finished_at: T.nilable(Integer),
            hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
            model: String,
            organization_id: String,
            result_files: T::Array[String],
            seed: Integer,
            status: Symbol,
            trained_tokens: T.nilable(Integer),
            training_file: String,
            validation_file: T.nilable(String),
            estimated_finish: T.nilable(Integer),
            integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]),
            metadata: T.nilable(OpenAI::Models::Metadata),
            method_: OpenAI::Models::FineTuning::FineTuningJob::Method,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          error:,
          fine_tuned_model:,
          finished_at:,
          hyperparameters:,
          model:,
          organization_id:,
          result_files:,
          seed:,
          status:,
          trained_tokens:,
          training_file:,
          validation_file:,
          estimated_finish: nil,
          integrations: nil,
          metadata: nil,
          method_: nil,
          object: :"fine_tuning.job"
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                error: T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error),
                fine_tuned_model: T.nilable(String),
                finished_at: T.nilable(Integer),
                hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters,
                model: String,
                object: Symbol,
                organization_id: String,
                result_files: T::Array[String],
                seed: Integer,
                status: Symbol,
                trained_tokens: T.nilable(Integer),
                training_file: String,
                validation_file: T.nilable(String),
                estimated_finish: T.nilable(Integer),
                integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]),
                metadata: T.nilable(OpenAI::Models::Metadata),
                method_: OpenAI::Models::FineTuning::FineTuningJob::Method
              }
            )
        end
        def to_hash
        end

        class Error < OpenAI::BaseModel
          sig { returns(String) }
          def code
          end

          sig { params(_: String).returns(String) }
          def code=(_)
          end

          sig { returns(String) }
          def message
          end

          sig { params(_: String).returns(String) }
          def message=(_)
          end

          sig { returns(T.nilable(String)) }
          def param
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def param=(_)
          end

          sig { params(code: String, message: String, param: T.nilable(String)).returns(T.attached_class) }
          def self.new(code:, message:, param:)
          end

          sig { override.returns({code: String, message: String, param: T.nilable(String)}) }
          def to_hash
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

        class Status < OpenAI::Enum
          abstract!

          VALIDATING_FILES = :validating_files
          QUEUED = :queued
          RUNNING = :running
          SUCCEEDED = :succeeded
          FAILED = :failed
          CANCELLED = :cancelled

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Method < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)) }
          def dpo
          end

          sig do
            params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)
              .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)
          end
          def dpo=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)) }
          def supervised
          end

          sig do
            params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)
              .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)
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
              dpo: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo,
              supervised: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised,
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
                  dpo: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo,
                  supervised: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised,
                  type: Symbol
                }
              )
          end
          def to_hash
          end

          class Dpo < OpenAI::BaseModel
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            sig do
              params(hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil)
            end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters})
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
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            sig do
              params(hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil)
            end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters})
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

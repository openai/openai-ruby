# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJob < OpenAI::BaseModel
        # The object identifier, which can be referenced in the API endpoints.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        # For fine-tuning jobs that have `failed`, this will contain more information on
        #   the cause of the failure.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error)) }
        def error
        end

        sig do
          params(_: T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error))
            .returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error))
        end
        def error=(_)
        end

        # The name of the fine-tuned model that is being created. The value will be null
        #   if the fine-tuning job is still running.
        sig { returns(T.nilable(String)) }
        def fine_tuned_model
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def fine_tuned_model=(_)
        end

        # The Unix timestamp (in seconds) for when the fine-tuning job was finished. The
        #   value will be null if the fine-tuning job is still running.
        sig { returns(T.nilable(Integer)) }
        def finished_at
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def finished_at=(_)
        end

        # The hyperparameters used for the fine-tuning job. This value will only be
        #   returned when running `supervised` jobs.
        sig { returns(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters) }
        def hyperparameters
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters)
            .returns(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters)
        end
        def hyperparameters=(_)
        end

        # The base model that is being fine-tuned.
        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        # The object type, which is always "fine_tuning.job".
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The organization that owns the fine-tuning job.
        sig { returns(String) }
        def organization_id
        end

        sig { params(_: String).returns(String) }
        def organization_id=(_)
        end

        # The compiled results file ID(s) for the fine-tuning job. You can retrieve the
        #   results with the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(T::Array[String]) }
        def result_files
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def result_files=(_)
        end

        # The seed used for the fine-tuning job.
        sig { returns(Integer) }
        def seed
        end

        sig { params(_: Integer).returns(Integer) }
        def seed=(_)
        end

        # The current status of the fine-tuning job, which can be either
        #   `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The total number of billable tokens processed by this fine-tuning job. The value
        #   will be null if the fine-tuning job is still running.
        sig { returns(T.nilable(Integer)) }
        def trained_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def trained_tokens=(_)
        end

        # The file ID used for training. You can retrieve the training data with the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(String) }
        def training_file
        end

        sig { params(_: String).returns(String) }
        def training_file=(_)
        end

        # The file ID used for validation. You can retrieve the validation results with
        #   the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(T.nilable(String)) }
        def validation_file
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def validation_file=(_)
        end

        # The Unix timestamp (in seconds) for when the fine-tuning job is estimated to
        #   finish. The value will be null if the fine-tuning job is not running.
        sig { returns(T.nilable(Integer)) }
        def estimated_finish
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def estimated_finish=(_)
        end

        # A list of integrations to enable for this fine-tuning job.
        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject])) }
        def integrations
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]))
            .returns(T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject]))
        end
        def integrations=(_)
        end

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata
        end

        sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata=(_)
        end

        # The method used for fine-tuning.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method)) }
        def method_
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJob::Method)
            .returns(OpenAI::Models::FineTuning::FineTuningJob::Method)
        end
        def method_=(_)
        end

        # The `fine_tuning.job` object represents a fine-tuning job that has been created
        #   through the API.
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
            metadata: T.nilable(T::Hash[Symbol, String]),
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
                metadata: T.nilable(T::Hash[Symbol, String]),
                method_: OpenAI::Models::FineTuning::FineTuningJob::Method
              }
            )
        end
        def to_hash
        end

        class Error < OpenAI::BaseModel
          # A machine-readable error code.
          sig { returns(String) }
          def code
          end

          sig { params(_: String).returns(String) }
          def code=(_)
          end

          # A human-readable error message.
          sig { returns(String) }
          def message
          end

          sig { params(_: String).returns(String) }
          def message=(_)
          end

          # The parameter that was invalid, usually `training_file` or `validation_file`.
          #   This field will be null if the failure was not parameter-specific.
          sig { returns(T.nilable(String)) }
          def param
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def param=(_)
          end

          # For fine-tuning jobs that have `failed`, this will contain more information on
          #   the cause of the failure.
          sig { params(code: String, message: String, param: T.nilable(String)).returns(T.attached_class) }
          def self.new(code:, message:, param:)
          end

          sig { override.returns({code: String, message: String, param: T.nilable(String)}) }
          def to_hash
          end
        end

        class Hyperparameters < OpenAI::BaseModel
          # Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          sig { returns(T.nilable(T.any(Symbol, Integer))) }
          def batch_size
          end

          sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
          def batch_size=(_)
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          sig { returns(T.nilable(T.any(Symbol, Float))) }
          def learning_rate_multiplier
          end

          sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
          def learning_rate_multiplier=(_)
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          sig { returns(T.nilable(T.any(Symbol, Integer))) }
          def n_epochs
          end

          sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
          def n_epochs=(_)
          end

          # The hyperparameters used for the fine-tuning job. This value will only be
          #   returned when running `supervised` jobs.
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

          # Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          class BatchSize < OpenAI::Union
            abstract!

            Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          class LearningRateMultiplier < OpenAI::Union
            abstract!

            Variants = type_template(:out) { {fixed: T.any(Symbol, Float)} }
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          class NEpochs < OpenAI::Union
            abstract!

            Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
          end
        end

        # The current status of the fine-tuning job, which can be either
        #   `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        class Status < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          VALIDATING_FILES = :validating_files
          QUEUED = :queued
          RUNNING = :running
          SUCCEEDED = :succeeded
          FAILED = :failed
          CANCELLED = :cancelled
        end

        class Method < OpenAI::BaseModel
          # Configuration for the DPO fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)) }
          def dpo
          end

          sig do
            params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)
              .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)
          end
          def dpo=(_)
          end

          # Configuration for the supervised fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)) }
          def supervised
          end

          sig do
            params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)
              .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)
          end
          def supervised=(_)
          end

          # The type of method. Is either `supervised` or `dpo`.
          sig { returns(T.nilable(Symbol)) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # The method used for fine-tuning.
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
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            # Configuration for the DPO fine-tuning method.
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
              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def batch_size
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def batch_size=(_)
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def beta
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def beta=(_)
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def learning_rate_multiplier
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def learning_rate_multiplier=(_)
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def n_epochs
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def n_epochs=(_)
              end

              # The hyperparameters used for the fine-tuning job.
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

              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              class BatchSize < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              class Beta < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Float)} }
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Float)} }
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
              end
            end
          end

          class Supervised < OpenAI::BaseModel
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            # Configuration for the supervised fine-tuning method.
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
              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def batch_size
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def batch_size=(_)
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              sig { returns(T.nilable(T.any(Symbol, Float))) }
              def learning_rate_multiplier
              end

              sig { params(_: T.any(Symbol, Float)).returns(T.any(Symbol, Float)) }
              def learning_rate_multiplier=(_)
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              def n_epochs
              end

              sig { params(_: T.any(Symbol, Integer)).returns(T.any(Symbol, Integer)) }
              def n_epochs=(_)
              end

              # The hyperparameters used for the fine-tuning job.
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

              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              class BatchSize < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Float)} }
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                abstract!

                Variants = type_template(:out) { {fixed: T.any(Symbol, Integer)} }
              end
            end
          end

          # The type of method. Is either `supervised` or `dpo`.
          class Type < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            SUPERVISED = :supervised
            DPO = :dpo
          end
        end
      end
    end

    FineTuningJob = FineTuning::FineTuningJob
  end
end

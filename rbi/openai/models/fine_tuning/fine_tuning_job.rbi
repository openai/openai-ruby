# typed: strong

module OpenAI
  module Models
    FineTuningJob = FineTuning::FineTuningJob

    module FineTuning
      class FineTuningJob < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::FineTuning::FineTuningJob, OpenAI::Internal::AnyHash)
          end

        # The object identifier, which can be referenced in the API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # For fine-tuning jobs that have `failed`, this will contain more information on
        # the cause of the failure.
        sig { returns(T.nilable(OpenAI::FineTuning::FineTuningJob::Error)) }
        attr_reader :error

        sig do
          params(
            error: T.nilable(OpenAI::FineTuning::FineTuningJob::Error::OrHash)
          ).void
        end
        attr_writer :error

        # The name of the fine-tuned model that is being created. The value will be null
        # if the fine-tuning job is still running.
        sig { returns(T.nilable(String)) }
        attr_accessor :fine_tuned_model

        # The Unix timestamp (in seconds) for when the fine-tuning job was finished. The
        # value will be null if the fine-tuning job is still running.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :finished_at

        # The hyperparameters used for the fine-tuning job. This value will only be
        # returned when running `supervised` jobs.
        sig { returns(OpenAI::FineTuning::FineTuningJob::Hyperparameters) }
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters:
              OpenAI::FineTuning::FineTuningJob::Hyperparameters::OrHash
          ).void
        end
        attr_writer :hyperparameters

        # The base model that is being fine-tuned.
        sig { returns(String) }
        attr_accessor :model

        # The object type, which is always "fine_tuning.job".
        sig { returns(Symbol) }
        attr_accessor :object

        # The organization that owns the fine-tuning job.
        sig { returns(String) }
        attr_accessor :organization_id

        # The compiled results file ID(s) for the fine-tuning job. You can retrieve the
        # results with the
        # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(T::Array[String]) }
        attr_accessor :result_files

        # The seed used for the fine-tuning job.
        sig { returns(Integer) }
        attr_accessor :seed

        # The current status of the fine-tuning job, which can be either
        # `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        sig { returns(OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol) }
        attr_accessor :status

        # The total number of billable tokens processed by this fine-tuning job. The value
        # will be null if the fine-tuning job is still running.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :trained_tokens

        # The file ID used for training. You can retrieve the training data with the
        # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(String) }
        attr_accessor :training_file

        # The file ID used for validation. You can retrieve the validation results with
        # the
        # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        sig { returns(T.nilable(String)) }
        attr_accessor :validation_file

        # The Unix timestamp (in seconds) for when the fine-tuning job is estimated to
        # finish. The value will be null if the fine-tuning job is not running.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :estimated_finish

        # A list of integrations to enable for this fine-tuning job.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::FineTuning::FineTuningJobWandbIntegrationObject]
            )
          )
        end
        attr_accessor :integrations

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The method used for fine-tuning.
        sig { returns(T.nilable(OpenAI::FineTuning::FineTuningJob::Method)) }
        attr_reader :method_

        sig do
          params(
            method_: OpenAI::FineTuning::FineTuningJob::Method::OrHash
          ).void
        end
        attr_writer :method_

        # The `fine_tuning.job` object represents a fine-tuning job that has been created
        # through the API.
        sig do
          params(
            id: String,
            created_at: Integer,
            error: T.nilable(OpenAI::FineTuning::FineTuningJob::Error::OrHash),
            fine_tuned_model: T.nilable(String),
            finished_at: T.nilable(Integer),
            hyperparameters:
              OpenAI::FineTuning::FineTuningJob::Hyperparameters::OrHash,
            model: String,
            organization_id: String,
            result_files: T::Array[String],
            seed: Integer,
            status: OpenAI::FineTuning::FineTuningJob::Status::OrSymbol,
            trained_tokens: T.nilable(Integer),
            training_file: String,
            validation_file: T.nilable(String),
            estimated_finish: T.nilable(Integer),
            integrations:
              T.nilable(
                T::Array[
                  OpenAI::FineTuning::FineTuningJobWandbIntegrationObject::OrHash
                ]
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            method_: OpenAI::FineTuning::FineTuningJob::Method::OrHash,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The object identifier, which can be referenced in the API endpoints.
          id:,
          # The Unix timestamp (in seconds) for when the fine-tuning job was created.
          created_at:,
          # For fine-tuning jobs that have `failed`, this will contain more information on
          # the cause of the failure.
          error:,
          # The name of the fine-tuned model that is being created. The value will be null
          # if the fine-tuning job is still running.
          fine_tuned_model:,
          # The Unix timestamp (in seconds) for when the fine-tuning job was finished. The
          # value will be null if the fine-tuning job is still running.
          finished_at:,
          # The hyperparameters used for the fine-tuning job. This value will only be
          # returned when running `supervised` jobs.
          hyperparameters:,
          # The base model that is being fine-tuned.
          model:,
          # The organization that owns the fine-tuning job.
          organization_id:,
          # The compiled results file ID(s) for the fine-tuning job. You can retrieve the
          # results with the
          # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
          result_files:,
          # The seed used for the fine-tuning job.
          seed:,
          # The current status of the fine-tuning job, which can be either
          # `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
          status:,
          # The total number of billable tokens processed by this fine-tuning job. The value
          # will be null if the fine-tuning job is still running.
          trained_tokens:,
          # The file ID used for training. You can retrieve the training data with the
          # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
          training_file:,
          # The file ID used for validation. You can retrieve the validation results with
          # the
          # [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
          validation_file:,
          # The Unix timestamp (in seconds) for when the fine-tuning job is estimated to
          # finish. The value will be null if the fine-tuning job is not running.
          estimated_finish: nil,
          # A list of integrations to enable for this fine-tuning job.
          integrations: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The method used for fine-tuning.
          method_: nil,
          # The object type, which is always "fine_tuning.job".
          object: :"fine_tuning.job"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              error: T.nilable(OpenAI::FineTuning::FineTuningJob::Error),
              fine_tuned_model: T.nilable(String),
              finished_at: T.nilable(Integer),
              hyperparameters:
                OpenAI::FineTuning::FineTuningJob::Hyperparameters,
              model: String,
              object: Symbol,
              organization_id: String,
              result_files: T::Array[String],
              seed: Integer,
              status: OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol,
              trained_tokens: T.nilable(Integer),
              training_file: String,
              validation_file: T.nilable(String),
              estimated_finish: T.nilable(Integer),
              integrations:
                T.nilable(
                  T::Array[
                    OpenAI::FineTuning::FineTuningJobWandbIntegrationObject
                  ]
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              method_: OpenAI::FineTuning::FineTuningJob::Method
            }
          )
        end
        def to_hash
        end

        class Error < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::FineTuningJob::Error,
                OpenAI::Internal::AnyHash
              )
            end

          # A machine-readable error code.
          sig { returns(String) }
          attr_accessor :code

          # A human-readable error message.
          sig { returns(String) }
          attr_accessor :message

          # The parameter that was invalid, usually `training_file` or `validation_file`.
          # This field will be null if the failure was not parameter-specific.
          sig { returns(T.nilable(String)) }
          attr_accessor :param

          # For fine-tuning jobs that have `failed`, this will contain more information on
          # the cause of the failure.
          sig do
            params(
              code: String,
              message: String,
              param: T.nilable(String)
            ).returns(T.attached_class)
          end
          def self.new(
            # A machine-readable error code.
            code:,
            # A human-readable error message.
            message:,
            # The parameter that was invalid, usually `training_file` or `validation_file`.
            # This field will be null if the failure was not parameter-specific.
            param:
          )
          end

          sig do
            override.returns(
              { code: String, message: String, param: T.nilable(String) }
            )
          end
          def to_hash
          end
        end

        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::FineTuningJob::Hyperparameters,
                OpenAI::Internal::AnyHash
              )
            end

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          sig do
            returns(
              T.nilable(
                OpenAI::FineTuning::FineTuningJob::Hyperparameters::BatchSize::Variants
              )
            )
          end
          attr_accessor :batch_size

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          sig do
            returns(
              T.nilable(
                OpenAI::FineTuning::FineTuningJob::Hyperparameters::LearningRateMultiplier::Variants
              )
            )
          end
          attr_reader :learning_rate_multiplier

          sig { params(learning_rate_multiplier: T.any(Symbol, Float)).void }
          attr_writer :learning_rate_multiplier

          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          sig do
            returns(
              T.nilable(
                OpenAI::FineTuning::FineTuningJob::Hyperparameters::NEpochs::Variants
              )
            )
          end
          attr_reader :n_epochs

          sig { params(n_epochs: T.any(Symbol, Integer)).void }
          attr_writer :n_epochs

          # The hyperparameters used for the fine-tuning job. This value will only be
          # returned when running `supervised` jobs.
          sig do
            params(
              batch_size: T.nilable(T.any(T.anything, Symbol, Integer)),
              learning_rate_multiplier: T.any(Symbol, Float),
              n_epochs: T.any(Symbol, Integer)
            ).returns(T.attached_class)
          end
          def self.new(
            # Number of examples in each batch. A larger batch size means that model
            # parameters are updated less frequently, but with lower variance.
            batch_size: nil,
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
                  T.nilable(
                    OpenAI::FineTuning::FineTuningJob::Hyperparameters::BatchSize::Variants
                  ),
                learning_rate_multiplier:
                  OpenAI::FineTuning::FineTuningJob::Hyperparameters::LearningRateMultiplier::Variants,
                n_epochs:
                  OpenAI::FineTuning::FineTuningJob::Hyperparameters::NEpochs::Variants
              }
            )
          end
          def to_hash
          end

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          module BatchSize
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias { T.nilable(T.any(T.anything, Symbol, Integer)) }

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::FineTuningJob::Hyperparameters::BatchSize::Variants
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
                  OpenAI::FineTuning::FineTuningJob::Hyperparameters::LearningRateMultiplier::Variants
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
                  OpenAI::FineTuning::FineTuningJob::Hyperparameters::NEpochs::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        # The current status of the fine-tuning job, which can be either
        # `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::FineTuning::FineTuningJob::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          VALIDATING_FILES =
            T.let(
              :validating_files,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )
          QUEUED =
            T.let(
              :queued,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )
          RUNNING =
            T.let(
              :running,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )
          SUCCEEDED =
            T.let(
              :succeeded,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )
          CANCELLED =
            T.let(
              :cancelled,
              OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::FineTuning::FineTuningJob::Status::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        class Method < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::FineTuningJob::Method,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of method. Is either `supervised`, `dpo`, or `reinforcement`.
          sig do
            returns(
              OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
            )
          end
          attr_accessor :type

          # Configuration for the DPO fine-tuning method.
          sig { returns(T.nilable(OpenAI::FineTuning::DpoMethod)) }
          attr_reader :dpo

          sig { params(dpo: OpenAI::FineTuning::DpoMethod::OrHash).void }
          attr_writer :dpo

          # Configuration for the reinforcement fine-tuning method.
          sig { returns(T.nilable(OpenAI::FineTuning::ReinforcementMethod)) }
          attr_reader :reinforcement

          sig do
            params(
              reinforcement: OpenAI::FineTuning::ReinforcementMethod::OrHash
            ).void
          end
          attr_writer :reinforcement

          # Configuration for the supervised fine-tuning method.
          sig { returns(T.nilable(OpenAI::FineTuning::SupervisedMethod)) }
          attr_reader :supervised

          sig do
            params(
              supervised: OpenAI::FineTuning::SupervisedMethod::OrHash
            ).void
          end
          attr_writer :supervised

          # The method used for fine-tuning.
          sig do
            params(
              type: OpenAI::FineTuning::FineTuningJob::Method::Type::OrSymbol,
              dpo: OpenAI::FineTuning::DpoMethod::OrHash,
              reinforcement: OpenAI::FineTuning::ReinforcementMethod::OrHash,
              supervised: OpenAI::FineTuning::SupervisedMethod::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The type of method. Is either `supervised`, `dpo`, or `reinforcement`.
            type:,
            # Configuration for the DPO fine-tuning method.
            dpo: nil,
            # Configuration for the reinforcement fine-tuning method.
            reinforcement: nil,
            # Configuration for the supervised fine-tuning method.
            supervised: nil
          )
          end

          sig do
            override.returns(
              {
                type:
                  OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol,
                dpo: OpenAI::FineTuning::DpoMethod,
                reinforcement: OpenAI::FineTuning::ReinforcementMethod,
                supervised: OpenAI::FineTuning::SupervisedMethod
              }
            )
          end
          def to_hash
          end

          # The type of method. Is either `supervised`, `dpo`, or `reinforcement`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::FineTuning::FineTuningJob::Method::Type)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SUPERVISED =
              T.let(
                :supervised,
                OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
              )
            DPO =
              T.let(
                :dpo,
                OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
              )
            REINFORCEMENT =
              T.let(
                :reinforcement,
                OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
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
end

# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJob < OpenAI::Internal::Type::BaseModel
        # The object identifier, which can be referenced in the API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # For fine-tuning jobs that have `failed`, this will contain more information on
        # the cause of the failure.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Error)) }
        attr_reader :error

        sig do
          params(
            error: T.nilable(T.any(OpenAI::Models::FineTuning::FineTuningJob::Error, OpenAI::Internal::AnyHash))
          )
            .void
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
        sig { returns(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters) }
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters: T.any(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters, OpenAI::Internal::AnyHash)
          )
            .void
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
        sig { returns(OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol) }
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
        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject])) }
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
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method)) }
        attr_reader :method_

        sig { params(method_: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method, OpenAI::Internal::AnyHash)).void }
        attr_writer :method_

        # The `fine_tuning.job` object represents a fine-tuning job that has been created
        # through the API.
        sig do
          params(
            id: String,
            created_at: Integer,
            error: T.nilable(T.any(OpenAI::Models::FineTuning::FineTuningJob::Error, OpenAI::Internal::AnyHash)),
            fine_tuned_model: T.nilable(String),
            finished_at: T.nilable(Integer),
            hyperparameters: T.any(OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters, OpenAI::Internal::AnyHash),
            model: String,
            organization_id: String,
            result_files: T::Array[String],
            seed: Integer,
            status: OpenAI::Models::FineTuning::FineTuningJob::Status::OrSymbol,
            trained_tokens: T.nilable(Integer),
            training_file: String,
            validation_file: T.nilable(String),
            estimated_finish: T.nilable(Integer),
            integrations: T.nilable(
              T::Array[T.any(OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject, OpenAI::Internal::AnyHash)]
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            method_: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method, OpenAI::Internal::AnyHash),
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
        ); end
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
                status: OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol,
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
        def to_hash; end

        class Error < OpenAI::Internal::Type::BaseModel
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
          sig { params(code: String, message: String, param: T.nilable(String)).returns(T.attached_class) }
          def self.new(code:, message:, param:); end

          sig { override.returns({code: String, message: String, param: T.nilable(String)}) }
          def to_hash; end
        end

        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          sig { returns(T.nilable(T.any(Symbol, Integer))) }
          attr_reader :batch_size

          sig { params(batch_size: T.any(Symbol, Integer)).void }
          attr_writer :batch_size

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

          # The hyperparameters used for the fine-tuning job. This value will only be
          # returned when running `supervised` jobs.
          sig do
            params(
              batch_size: T.any(Symbol, Integer),
              learning_rate_multiplier: T.any(Symbol, Float),
              n_epochs: T.any(Symbol, Integer)
            )
              .returns(T.attached_class)
          end
          def self.new(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil); end

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
          def to_hash; end

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          module BatchSize
            extend OpenAI::Internal::Type::Union

            sig { override.returns([Symbol, Integer]) }
            def self.variants; end
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          module LearningRateMultiplier
            extend OpenAI::Internal::Type::Union

            sig { override.returns([Symbol, Float]) }
            def self.variants; end
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          module NEpochs
            extend OpenAI::Internal::Type::Union

            sig { override.returns([Symbol, Integer]) }
            def self.variants; end
          end
        end

        # The current status of the fine-tuning job, which can be either
        # `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::FineTuningJob::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          VALIDATING_FILES =
            T.let(:validating_files, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)
          QUEUED = T.let(:queued, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)
          RUNNING = T.let(:running, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)
          SUCCEEDED = T.let(:succeeded, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::FineTuning::FineTuningJob::Status::TaggedSymbol]) }
          def self.values; end
        end

        class Method < OpenAI::Internal::Type::BaseModel
          # Configuration for the DPO fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo)) }
          attr_reader :dpo

          sig { params(dpo: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo, OpenAI::Internal::AnyHash)).void }
          attr_writer :dpo

          # Configuration for the supervised fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised)) }
          attr_reader :supervised

          sig do
            params(
              supervised: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :supervised

          # The type of method. Is either `supervised` or `dpo`.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Type::TaggedSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Models::FineTuning::FineTuningJob::Method::Type::OrSymbol).void }
          attr_writer :type

          # The method used for fine-tuning.
          sig do
            params(
              dpo: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo, OpenAI::Internal::AnyHash),
              supervised: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised, OpenAI::Internal::AnyHash),
              type: OpenAI::Models::FineTuning::FineTuningJob::Method::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(dpo: nil, supervised: nil, type: nil); end

          sig do
            override
              .returns(
                {
                  dpo: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo,
                  supervised: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised,
                  type: OpenAI::Models::FineTuning::FineTuningJob::Method::Type::TaggedSymbol
                }
              )
          end
          def to_hash; end

          class Dpo < OpenAI::Internal::Type::BaseModel
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters)) }
            attr_reader :hyperparameters

            sig do
              params(
                hyperparameters: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters, OpenAI::Internal::AnyHash)
              )
                .void
            end
            attr_writer :hyperparameters

            # Configuration for the DPO fine-tuning method.
            sig do
              params(
                hyperparameters: T.any(OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters, OpenAI::Internal::AnyHash)
              )
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil); end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters})
            end
            def to_hash; end

            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              attr_reader :batch_size

              sig { params(batch_size: T.any(Symbol, Integer)).void }
              attr_writer :batch_size

              # The beta value for the DPO method. A higher beta value will increase the weight
              # of the penalty between the policy and reference model.
              sig { returns(T.nilable(T.any(Symbol, Float))) }
              attr_reader :beta

              sig { params(beta: T.any(Symbol, Float)).void }
              attr_writer :beta

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
              def self.new(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil); end

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
              def to_hash; end

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              module BatchSize
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Integer]) }
                def self.variants; end
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              # of the penalty between the policy and reference model.
              module Beta
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Float]) }
                def self.variants; end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              # avoid overfitting.
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Float]) }
                def self.variants; end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              # through the training dataset.
              module NEpochs
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Integer]) }
                def self.variants; end
              end
            end
          end

          class Supervised < OpenAI::Internal::Type::BaseModel
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters)) }
            attr_reader :hyperparameters

            sig do
              params(
                hyperparameters: T.any(
                  OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters,
                  OpenAI::Internal::AnyHash
                )
              )
                .void
            end
            attr_writer :hyperparameters

            # Configuration for the supervised fine-tuning method.
            sig do
              params(
                hyperparameters: T.any(
                  OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters,
                  OpenAI::Internal::AnyHash
                )
              )
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil); end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters})
            end
            def to_hash; end

            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              sig { returns(T.nilable(T.any(Symbol, Integer))) }
              attr_reader :batch_size

              sig { params(batch_size: T.any(Symbol, Integer)).void }
              attr_writer :batch_size

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

              # The hyperparameters used for the fine-tuning job.
              sig do
                params(
                  batch_size: T.any(Symbol, Integer),
                  learning_rate_multiplier: T.any(Symbol, Float),
                  n_epochs: T.any(Symbol, Integer)
                )
                  .returns(T.attached_class)
              end
              def self.new(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil); end

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
              def to_hash; end

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              module BatchSize
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Integer]) }
                def self.variants; end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              # avoid overfitting.
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Float]) }
                def self.variants; end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              # through the training dataset.
              module NEpochs
                extend OpenAI::Internal::Type::Union

                sig { override.returns([Symbol, Integer]) }
                def self.variants; end
              end
            end
          end

          # The type of method. Is either `supervised` or `dpo`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::FineTuningJob::Method::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SUPERVISED = T.let(:supervised, OpenAI::Models::FineTuning::FineTuningJob::Method::Type::TaggedSymbol)
            DPO = T.let(:dpo, OpenAI::Models::FineTuning::FineTuningJob::Method::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::FineTuning::FineTuningJob::Method::Type::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end

    FineTuningJob = FineTuning::FineTuningJob
  end
end

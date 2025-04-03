# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#create
      class FineTuningJob < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The object identifier, which can be referenced in the API endpoints.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the fine-tuning job was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute error
        #   For fine-tuning jobs that have `failed`, this will contain more information on
        #     the cause of the failure.
        #
        #   @return [OpenAI::Models::FineTuning::FineTuningJob::Error, nil]
        required :error, -> { OpenAI::Models::FineTuning::FineTuningJob::Error }, nil?: true

        # @!attribute fine_tuned_model
        #   The name of the fine-tuned model that is being created. The value will be null
        #     if the fine-tuning job is still running.
        #
        #   @return [String, nil]
        required :fine_tuned_model, String, nil?: true

        # @!attribute finished_at
        #   The Unix timestamp (in seconds) for when the fine-tuning job was finished. The
        #     value will be null if the fine-tuning job is still running.
        #
        #   @return [Integer, nil]
        required :finished_at, Integer, nil?: true

        # @!attribute hyperparameters
        #   The hyperparameters used for the fine-tuning job. This value will only be
        #     returned when running `supervised` jobs.
        #
        #   @return [OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters]
        required :hyperparameters, -> { OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters }

        # @!attribute model
        #   The base model that is being fine-tuned.
        #
        #   @return [String]
        required :model, String

        # @!attribute object
        #   The object type, which is always "fine_tuning.job".
        #
        #   @return [Symbol, :"fine_tuning.job"]
        required :object, const: :"fine_tuning.job"

        # @!attribute organization_id
        #   The organization that owns the fine-tuning job.
        #
        #   @return [String]
        required :organization_id, String

        # @!attribute result_files
        #   The compiled results file ID(s) for the fine-tuning job. You can retrieve the
        #     results with the
        #     [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        #
        #   @return [Array<String>]
        required :result_files, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute seed
        #   The seed used for the fine-tuning job.
        #
        #   @return [Integer]
        required :seed, Integer

        # @!attribute status
        #   The current status of the fine-tuning job, which can be either
        #     `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        #
        #   @return [Symbol, OpenAI::Models::FineTuning::FineTuningJob::Status]
        required :status, enum: -> { OpenAI::Models::FineTuning::FineTuningJob::Status }

        # @!attribute trained_tokens
        #   The total number of billable tokens processed by this fine-tuning job. The value
        #     will be null if the fine-tuning job is still running.
        #
        #   @return [Integer, nil]
        required :trained_tokens, Integer, nil?: true

        # @!attribute training_file
        #   The file ID used for training. You can retrieve the training data with the
        #     [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        #
        #   @return [String]
        required :training_file, String

        # @!attribute validation_file
        #   The file ID used for validation. You can retrieve the validation results with
        #     the
        #     [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        #
        #   @return [String, nil]
        required :validation_file, String, nil?: true

        # @!attribute estimated_finish
        #   The Unix timestamp (in seconds) for when the fine-tuning job is estimated to
        #     finish. The value will be null if the fine-tuning job is not running.
        #
        #   @return [Integer, nil]
        optional :estimated_finish, Integer, nil?: true

        # @!attribute integrations
        #   A list of integrations to enable for this fine-tuning job.
        #
        #   @return [Array<OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject>, nil]
        optional :integrations,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject] },
                 nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute [r] method_
        #   The method used for fine-tuning.
        #
        #   @return [OpenAI::Models::FineTuning::FineTuningJob::Method, nil]
        optional :method_, -> { OpenAI::Models::FineTuning::FineTuningJob::Method }, api_name: :method

        # @!parse
        #   # @return [OpenAI::Models::FineTuning::FineTuningJob::Method]
        #   attr_writer :method_

        # @!parse
        #   # The `fine_tuning.job` object represents a fine-tuning job that has been created
        #   #   through the API.
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param error [OpenAI::Models::FineTuning::FineTuningJob::Error, nil]
        #   # @param fine_tuned_model [String, nil]
        #   # @param finished_at [Integer, nil]
        #   # @param hyperparameters [OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters]
        #   # @param model [String]
        #   # @param organization_id [String]
        #   # @param result_files [Array<String>]
        #   # @param seed [Integer]
        #   # @param status [Symbol, OpenAI::Models::FineTuning::FineTuningJob::Status]
        #   # @param trained_tokens [Integer, nil]
        #   # @param training_file [String]
        #   # @param validation_file [String, nil]
        #   # @param estimated_finish [Integer, nil]
        #   # @param integrations [Array<OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject>, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param method_ [OpenAI::Models::FineTuning::FineTuningJob::Method]
        #   # @param object [Symbol, :"fine_tuning.job"]
        #   #
        #   def initialize(
        #     id:,
        #     created_at:,
        #     error:,
        #     fine_tuned_model:,
        #     finished_at:,
        #     hyperparameters:,
        #     model:,
        #     organization_id:,
        #     result_files:,
        #     seed:,
        #     status:,
        #     trained_tokens:,
        #     training_file:,
        #     validation_file:,
        #     estimated_finish: nil,
        #     integrations: nil,
        #     metadata: nil,
        #     method_: nil,
        #     object: :"fine_tuning.job",
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # @see OpenAI::Models::FineTuning::FineTuningJob#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   A machine-readable error code.
          #
          #   @return [String]
          required :code, String

          # @!attribute message
          #   A human-readable error message.
          #
          #   @return [String]
          required :message, String

          # @!attribute param
          #   The parameter that was invalid, usually `training_file` or `validation_file`.
          #     This field will be null if the failure was not parameter-specific.
          #
          #   @return [String, nil]
          required :param, String, nil?: true

          # @!parse
          #   # For fine-tuning jobs that have `failed`, this will contain more information on
          #   #   the cause of the failure.
          #   #
          #   # @param code [String]
          #   # @param message [String]
          #   # @param param [String, nil]
          #   #
          #   def initialize(code:, message:, param:, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end

        # @see OpenAI::Models::FineTuning::FineTuningJob#hyperparameters
        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] batch_size
          #   Number of examples in each batch. A larger batch size means that model
          #     parameters are updated less frequently, but with lower variance.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :batch_size, union: -> { OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters::BatchSize }

          # @!parse
          #   # @return [Symbol, :auto, Integer]
          #   attr_writer :batch_size

          # @!attribute [r] learning_rate_multiplier
          #   Scaling factor for the learning rate. A smaller learning rate may be useful to
          #     avoid overfitting.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :learning_rate_multiplier,
                   union: -> { OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters::LearningRateMultiplier }

          # @!parse
          #   # @return [Symbol, :auto, Float]
          #   attr_writer :learning_rate_multiplier

          # @!attribute [r] n_epochs
          #   The number of epochs to train the model for. An epoch refers to one full cycle
          #     through the training dataset.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :n_epochs, union: -> { OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters::NEpochs }

          # @!parse
          #   # @return [Symbol, :auto, Integer]
          #   attr_writer :n_epochs

          # @!parse
          #   # The hyperparameters used for the fine-tuning job. This value will only be
          #   #   returned when running `supervised` jobs.
          #   #
          #   # @param batch_size [Symbol, :auto, Integer]
          #   # @param learning_rate_multiplier [Symbol, :auto, Float]
          #   # @param n_epochs [Symbol, :auto, Integer]
          #   #
          #   def initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          #
          # @see OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters#batch_size
          module BatchSize
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!parse
            #   # @return [Array(Symbol, :auto, Integer)]
            #   def self.variants; end
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          #
          # @see OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters#learning_rate_multiplier
          module LearningRateMultiplier
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Float

            # @!parse
            #   # @return [Array(Symbol, :auto, Float)]
            #   def self.variants; end
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          #
          # @see OpenAI::Models::FineTuning::FineTuningJob::Hyperparameters#n_epochs
          module NEpochs
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!parse
            #   # @return [Array(Symbol, :auto, Integer)]
            #   def self.variants; end
          end
        end

        # The current status of the fine-tuning job, which can be either
        #   `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        #
        # @see OpenAI::Models::FineTuning::FineTuningJob#status
        module Status
          extend OpenAI::Internal::Type::Enum

          VALIDATING_FILES = :validating_files
          QUEUED = :queued
          RUNNING = :running
          SUCCEEDED = :succeeded
          FAILED = :failed
          CANCELLED = :cancelled

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end

        # @see OpenAI::Models::FineTuning::FineTuningJob#method_
        class Method < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] dpo
          #   Configuration for the DPO fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo, nil]
          optional :dpo, -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo }

          # @!parse
          #   # @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo]
          #   attr_writer :dpo

          # @!attribute [r] supervised
          #   Configuration for the supervised fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised, nil]
          optional :supervised, -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised }

          # @!parse
          #   # @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised]
          #   attr_writer :supervised

          # @!attribute [r] type
          #   The type of method. Is either `supervised` or `dpo`.
          #
          #   @return [Symbol, OpenAI::Models::FineTuning::FineTuningJob::Method::Type, nil]
          optional :type, enum: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Type }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::FineTuning::FineTuningJob::Method::Type]
          #   attr_writer :type

          # @!parse
          #   # The method used for fine-tuning.
          #   #
          #   # @param dpo [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo]
          #   # @param supervised [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised]
          #   # @param type [Symbol, OpenAI::Models::FineTuning::FineTuningJob::Method::Type]
          #   #
          #   def initialize(dpo: nil, supervised: nil, type: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::FineTuning::FineTuningJob::Method#dpo
          class Dpo < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters, nil]
            optional :hyperparameters, -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters }

            # @!parse
            #   # @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters]
            #   attr_writer :hyperparameters

            # @!parse
            #   # Configuration for the DPO fine-tuning method.
            #   #
            #   # @param hyperparameters [OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters]
            #   #
            #   def initialize(hyperparameters: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #     parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::BatchSize }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :batch_size

              # @!attribute [r] beta
              #   The beta value for the DPO method. A higher beta value will increase the weight
              #     of the penalty between the policy and reference model.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :beta,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::Beta }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :beta

              # @!attribute [r] learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #     avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::LearningRateMultiplier }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :learning_rate_multiplier

              # @!attribute [r] n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #     through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::NEpochs }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :n_epochs

              # @!parse
              #   # The hyperparameters used for the fine-tuning job.
              #   #
              #   # @param batch_size [Symbol, :auto, Integer]
              #   # @param beta [Symbol, :auto, Float]
              #   # @param learning_rate_multiplier [Symbol, :auto, Float]
              #   # @param n_epochs [Symbol, :auto, Integer]
              #   #
              #   def initialize(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#batch_size
              module BatchSize
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!parse
                #   # @return [Array(Symbol, :auto, Integer)]
                #   def self.variants; end
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#beta
              module Beta
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!parse
                #   # @return [Array(Symbol, :auto, Float)]
                #   def self.variants; end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#learning_rate_multiplier
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!parse
                #   # @return [Array(Symbol, :auto, Float)]
                #   def self.variants; end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#n_epochs
              module NEpochs
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!parse
                #   # @return [Array(Symbol, :auto, Integer)]
                #   def self.variants; end
              end
            end
          end

          # @see OpenAI::Models::FineTuning::FineTuningJob::Method#supervised
          class Supervised < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters, nil]
            optional :hyperparameters,
                     -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters }

            # @!parse
            #   # @return [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters]
            #   attr_writer :hyperparameters

            # @!parse
            #   # Configuration for the supervised fine-tuning method.
            #   #
            #   # @param hyperparameters [OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters]
            #   #
            #   def initialize(hyperparameters: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #     parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::BatchSize }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :batch_size

              # @!attribute [r] learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #     avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::LearningRateMultiplier }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :learning_rate_multiplier

              # @!attribute [r] n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #     through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::NEpochs }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :n_epochs

              # @!parse
              #   # The hyperparameters used for the fine-tuning job.
              #   #
              #   # @param batch_size [Symbol, :auto, Integer]
              #   # @param learning_rate_multiplier [Symbol, :auto, Float]
              #   # @param n_epochs [Symbol, :auto, Integer]
              #   #
              #   def initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#batch_size
              module BatchSize
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!parse
                #   # @return [Array(Symbol, :auto, Integer)]
                #   def self.variants; end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#learning_rate_multiplier
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!parse
                #   # @return [Array(Symbol, :auto, Float)]
                #   def self.variants; end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              # @see OpenAI::Models::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#n_epochs
              module NEpochs
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!parse
                #   # @return [Array(Symbol, :auto, Integer)]
                #   def self.variants; end
              end
            end
          end

          # The type of method. Is either `supervised` or `dpo`.
          #
          # @see OpenAI::Models::FineTuning::FineTuningJob::Method#type
          module Type
            extend OpenAI::Internal::Type::Enum

            SUPERVISED = :supervised
            DPO = :dpo

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end

    FineTuningJob = FineTuning::FineTuningJob
  end
end

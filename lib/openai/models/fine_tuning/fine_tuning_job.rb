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
        #   the cause of the failure.
        #
        #   @return [OpenAI::FineTuning::FineTuningJob::Error, nil]
        required :error, -> { OpenAI::FineTuning::FineTuningJob::Error }, nil?: true

        # @!attribute fine_tuned_model
        #   The name of the fine-tuned model that is being created. The value will be null
        #   if the fine-tuning job is still running.
        #
        #   @return [String, nil]
        required :fine_tuned_model, String, nil?: true

        # @!attribute finished_at
        #   The Unix timestamp (in seconds) for when the fine-tuning job was finished. The
        #   value will be null if the fine-tuning job is still running.
        #
        #   @return [Integer, nil]
        required :finished_at, Integer, nil?: true

        # @!attribute hyperparameters
        #   The hyperparameters used for the fine-tuning job. This value will only be
        #   returned when running `supervised` jobs.
        #
        #   @return [OpenAI::FineTuning::FineTuningJob::Hyperparameters]
        required :hyperparameters, -> { OpenAI::FineTuning::FineTuningJob::Hyperparameters }

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
        #   results with the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
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
        #   `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        #
        #   @return [Symbol, OpenAI::FineTuning::FineTuningJob::Status]
        required :status, enum: -> { OpenAI::FineTuning::FineTuningJob::Status }

        # @!attribute trained_tokens
        #   The total number of billable tokens processed by this fine-tuning job. The value
        #   will be null if the fine-tuning job is still running.
        #
        #   @return [Integer, nil]
        required :trained_tokens, Integer, nil?: true

        # @!attribute training_file
        #   The file ID used for training. You can retrieve the training data with the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        #
        #   @return [String]
        required :training_file, String

        # @!attribute validation_file
        #   The file ID used for validation. You can retrieve the validation results with
        #   the
        #   [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents).
        #
        #   @return [String, nil]
        required :validation_file, String, nil?: true

        # @!attribute estimated_finish
        #   The Unix timestamp (in seconds) for when the fine-tuning job is estimated to
        #   finish. The value will be null if the fine-tuning job is not running.
        #
        #   @return [Integer, nil]
        optional :estimated_finish, Integer, nil?: true

        # @!attribute integrations
        #   A list of integrations to enable for this fine-tuning job.
        #
        #   @return [Array<OpenAI::FineTuning::FineTuningJobWandbIntegrationObject>, nil]
        optional :integrations,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[OpenAI::FineTuning::FineTuningJobWandbIntegrationObject]
                 },
                 nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute method_
        #   The method used for fine-tuning.
        #
        #   @return [OpenAI::FineTuning::FineTuningJob::Method, nil]
        optional :method_, -> { OpenAI::FineTuning::FineTuningJob::Method }, api_name: :method

        # @!method initialize(id:, created_at:, error:, fine_tuned_model:, finished_at:, hyperparameters:, model:, organization_id:, result_files:, seed:, status:, trained_tokens:, training_file:, validation_file:, estimated_finish: nil, integrations: nil, metadata: nil, method_: nil, object: :"fine_tuning.job")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::FineTuning::FineTuningJob} for more details.
        #
        #   The `fine_tuning.job` object represents a fine-tuning job that has been created
        #   through the API.
        #
        #   @param id [String] The object identifier, which can be referenced in the API endpoints.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) for when the fine-tuning job was created.
        #
        #   @param error [OpenAI::FineTuning::FineTuningJob::Error, nil] For fine-tuning jobs that have `failed`, this will contain more information on t
        #
        #   @param fine_tuned_model [String, nil] The name of the fine-tuned model that is being created. The value will be null i
        #
        #   @param finished_at [Integer, nil] The Unix timestamp (in seconds) for when the fine-tuning job was finished. The v
        #
        #   @param hyperparameters [OpenAI::FineTuning::FineTuningJob::Hyperparameters] The hyperparameters used for the fine-tuning job. This value will only be return
        #
        #   @param model [String] The base model that is being fine-tuned.
        #
        #   @param organization_id [String] The organization that owns the fine-tuning job.
        #
        #   @param result_files [Array<String>] The compiled results file ID(s) for the fine-tuning job. You can retrieve the re
        #
        #   @param seed [Integer] The seed used for the fine-tuning job.
        #
        #   @param status [Symbol, OpenAI::FineTuning::FineTuningJob::Status] The current status of the fine-tuning job, which can be either `validating_files
        #
        #   @param trained_tokens [Integer, nil] The total number of billable tokens processed by this fine-tuning job. The value
        #
        #   @param training_file [String] The file ID used for training. You can retrieve the training data with the [File
        #
        #   @param validation_file [String, nil] The file ID used for validation. You can retrieve the validation results with th
        #
        #   @param estimated_finish [Integer, nil] The Unix timestamp (in seconds) for when the fine-tuning job is estimated to fin
        #
        #   @param integrations [Array<OpenAI::FineTuning::FineTuningJobWandbIntegrationObject>, nil] A list of integrations to enable for this fine-tuning job.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param method_ [OpenAI::FineTuning::FineTuningJob::Method] The method used for fine-tuning.
        #
        #   @param object [Symbol, :"fine_tuning.job"] The object type, which is always "fine_tuning.job".

        # @see OpenAI::FineTuning::FineTuningJob#error
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
          #   This field will be null if the failure was not parameter-specific.
          #
          #   @return [String, nil]
          required :param, String, nil?: true

          # @!method initialize(code:, message:, param:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::FineTuning::FineTuningJob::Error} for more details.
          #
          #   For fine-tuning jobs that have `failed`, this will contain more information on
          #   the cause of the failure.
          #
          #   @param code [String] A machine-readable error code.
          #
          #   @param message [String] A human-readable error message.
          #
          #   @param param [String, nil] The parameter that was invalid, usually `training_file` or `validation_file`. Th
        end

        # @see OpenAI::FineTuning::FineTuningJob#hyperparameters
        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          # @!attribute batch_size
          #   Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :batch_size, union: -> { OpenAI::FineTuning::FineTuningJob::Hyperparameters::BatchSize }

          # @!attribute learning_rate_multiplier
          #   Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :learning_rate_multiplier,
                   union: -> { OpenAI::FineTuning::FineTuningJob::Hyperparameters::LearningRateMultiplier }

          # @!attribute n_epochs
          #   The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :n_epochs, union: -> { OpenAI::FineTuning::FineTuningJob::Hyperparameters::NEpochs }

          # @!method initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::FineTuning::FineTuningJob::Hyperparameters} for more details.
          #
          #   The hyperparameters used for the fine-tuning job. This value will only be
          #   returned when running `supervised` jobs.
          #
          #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
          #
          #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
          #
          #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          #
          # @see OpenAI::FineTuning::FineTuningJob::Hyperparameters#batch_size
          module BatchSize
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Integer)]
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          # avoid overfitting.
          #
          # @see OpenAI::FineTuning::FineTuningJob::Hyperparameters#learning_rate_multiplier
          module LearningRateMultiplier
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Float

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Float)]
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          # through the training dataset.
          #
          # @see OpenAI::FineTuning::FineTuningJob::Hyperparameters#n_epochs
          module NEpochs
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Integer)]
          end
        end

        # The current status of the fine-tuning job, which can be either
        # `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`.
        #
        # @see OpenAI::FineTuning::FineTuningJob#status
        module Status
          extend OpenAI::Internal::Type::Enum

          VALIDATING_FILES = :validating_files
          QUEUED = :queued
          RUNNING = :running
          SUCCEEDED = :succeeded
          FAILED = :failed
          CANCELLED = :cancelled

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::FineTuning::FineTuningJob#method_
        class Method < OpenAI::Internal::Type::BaseModel
          # @!attribute dpo
          #   Configuration for the DPO fine-tuning method.
          #
          #   @return [OpenAI::FineTuning::FineTuningJob::Method::Dpo, nil]
          optional :dpo, -> { OpenAI::FineTuning::FineTuningJob::Method::Dpo }

          # @!attribute supervised
          #   Configuration for the supervised fine-tuning method.
          #
          #   @return [OpenAI::FineTuning::FineTuningJob::Method::Supervised, nil]
          optional :supervised, -> { OpenAI::FineTuning::FineTuningJob::Method::Supervised }

          # @!attribute type
          #   The type of method. Is either `supervised` or `dpo`.
          #
          #   @return [Symbol, OpenAI::FineTuning::FineTuningJob::Method::Type, nil]
          optional :type, enum: -> { OpenAI::FineTuning::FineTuningJob::Method::Type }

          # @!method initialize(dpo: nil, supervised: nil, type: nil)
          #   The method used for fine-tuning.
          #
          #   @param dpo [OpenAI::FineTuning::FineTuningJob::Method::Dpo] Configuration for the DPO fine-tuning method.
          #
          #   @param supervised [OpenAI::FineTuning::FineTuningJob::Method::Supervised] Configuration for the supervised fine-tuning method.
          #
          #   @param type [Symbol, OpenAI::FineTuning::FineTuningJob::Method::Type] The type of method. Is either `supervised` or `dpo`.

          # @see OpenAI::FineTuning::FineTuningJob::Method#dpo
          class Dpo < OpenAI::Internal::Type::BaseModel
            # @!attribute hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters, nil]
            optional :hyperparameters, -> { OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters }

            # @!method initialize(hyperparameters: nil)
            #   Configuration for the DPO fine-tuning method.
            #
            #   @param hyperparameters [OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters] The hyperparameters used for the fine-tuning job.

            # @see OpenAI::FineTuning::FineTuningJob::Method::Dpo#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::BatchSize
                       }

              # @!attribute beta
              #   The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :beta,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::Beta
                       }

              # @!attribute learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::LearningRateMultiplier
                       }

              # @!attribute n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters::NEpochs
                       }

              # @!method initialize(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters} for more
              #   details.
              #
              #   The hyperparameters used for the fine-tuning job.
              #
              #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
              #
              #   @param beta [Symbol, :auto, Float] The beta value for the DPO method. A higher beta value will increase the weight
              #
              #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
              #
              #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle t

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#batch_size
              module BatchSize
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Integer)]
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              # of the penalty between the policy and reference model.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#beta
              module Beta
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Float)]
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              # avoid overfitting.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#learning_rate_multiplier
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Float)]
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              # through the training dataset.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Dpo::Hyperparameters#n_epochs
              module NEpochs
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Integer)]
              end
            end
          end

          # @see OpenAI::FineTuning::FineTuningJob::Method#supervised
          class Supervised < OpenAI::Internal::Type::BaseModel
            # @!attribute hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters, nil]
            optional :hyperparameters,
                     -> {
                       OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters
                     }

            # @!method initialize(hyperparameters: nil)
            #   Configuration for the supervised fine-tuning method.
            #
            #   @param hyperparameters [OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters] The hyperparameters used for the fine-tuning job.

            # @see OpenAI::FineTuning::FineTuningJob::Method::Supervised#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::BatchSize
                       }

              # @!attribute learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::LearningRateMultiplier
                       }

              # @!attribute n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> {
                         OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters::NEpochs
                       }

              # @!method initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters} for
              #   more details.
              #
              #   The hyperparameters used for the fine-tuning job.
              #
              #   @param batch_size [Symbol, :auto, Integer] Number of examples in each batch. A larger batch size means that model parameter
              #
              #   @param learning_rate_multiplier [Symbol, :auto, Float] Scaling factor for the learning rate. A smaller learning rate may be useful to a
              #
              #   @param n_epochs [Symbol, :auto, Integer] The number of epochs to train the model for. An epoch refers to one full cycle t

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#batch_size
              module BatchSize
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Integer)]
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              # avoid overfitting.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#learning_rate_multiplier
              module LearningRateMultiplier
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Float

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Float)]
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              # through the training dataset.
              #
              # @see OpenAI::FineTuning::FineTuningJob::Method::Supervised::Hyperparameters#n_epochs
              module NEpochs
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Integer)]
              end
            end
          end

          # The type of method. Is either `supervised` or `dpo`.
          #
          # @see OpenAI::FineTuning::FineTuningJob::Method#type
          module Type
            extend OpenAI::Internal::Type::Enum

            SUPERVISED = :supervised
            DPO = :dpo

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    FineTuningJob = FineTuning::FineTuningJob
  end
end

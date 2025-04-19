# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#create
      class JobCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute model
        #   The name of the model to fine-tune. You can select one of the
        #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        #
        #   @return [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model]
        required :model, union: -> { OpenAI::Models::FineTuning::JobCreateParams::Model }

        # @!attribute training_file
        #   The ID of an uploaded file that contains training data.
        #
        #   See [upload file](https://platform.openai.com/docs/api-reference/files/create)
        #   for how to upload a file.
        #
        #   Your dataset must be formatted as a JSONL file. Additionally, you must upload
        #   your file with the purpose `fine-tune`.
        #
        #   The contents of the file should differ depending on if the model uses the
        #   [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
        #   [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
        #   format, or if the fine-tuning method uses the
        #   [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
        #   format.
        #
        #   See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #   for more details.
        #
        #   @return [String]
        required :training_file, String

        # @!attribute hyperparameters
        #   @deprecated
        #
        #   The hyperparameters used for the fine-tuning job. This value is now deprecated
        #   in favor of `method`, and should be passed in under the `method` parameter.
        #
        #   @return [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters }

        # @!attribute integrations
        #   A list of integrations to enable for your fine-tuning job.
        #
        #   @return [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        optional :integrations,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::FineTuning::JobCreateParams::Integration] },
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
        #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method, nil]
        optional :method_, -> { OpenAI::Models::FineTuning::JobCreateParams::Method }, api_name: :method

        # @!attribute seed
        #   The seed controls the reproducibility of the job. Passing in the same seed and
        #   job parameters should produce the same results, but may differ in rare cases. If
        #   a seed is not specified, one will be generated for you.
        #
        #   @return [Integer, nil]
        optional :seed, Integer, nil?: true

        # @!attribute suffix
        #   A string of up to 64 characters that will be added to your fine-tuned model
        #   name.
        #
        #   For example, a `suffix` of "custom-model-name" would produce a model name like
        #   `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        #
        #   @return [String, nil]
        optional :suffix, String, nil?: true

        # @!attribute validation_file
        #   The ID of an uploaded file that contains validation data.
        #
        #   If you provide this file, the data is used to generate validation metrics
        #   periodically during fine-tuning. These metrics can be viewed in the fine-tuning
        #   results file. The same data should not be present in both train and validation
        #   files.
        #
        #   Your dataset must be formatted as a JSONL file. You must upload your file with
        #   the purpose `fine-tune`.
        #
        #   See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #   for more details.
        #
        #   @return [String, nil]
        optional :validation_file, String, nil?: true

        # @!method initialize(model:, training_file:, hyperparameters: nil, integrations: nil, metadata: nil, method_: nil, seed: nil, suffix: nil, validation_file: nil, request_options: {})
        #   @param model [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model]
        #   @param training_file [String]
        #   @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters]
        #   @param integrations [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        #   @param metadata [Hash{Symbol=>String}, nil]
        #   @param method_ [OpenAI::Models::FineTuning::JobCreateParams::Method]
        #   @param seed [Integer, nil]
        #   @param suffix [String, nil]
        #   @param validation_file [String, nil]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The name of the model to fine-tune. You can select one of the
        # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::FineTuning::JobCreateParams::Model::BABBAGE_002 }

          variant const: -> { OpenAI::Models::FineTuning::JobCreateParams::Model::DAVINCI_002 }

          variant const: -> { OpenAI::Models::FineTuning::JobCreateParams::Model::GPT_3_5_TURBO }

          variant const: -> { OpenAI::Models::FineTuning::JobCreateParams::Model::GPT_4O_MINI }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          # @!group

          BABBAGE_002 = :"babbage-002"
          DAVINCI_002 = :"davinci-002"
          GPT_3_5_TURBO = :"gpt-3.5-turbo"
          GPT_4O_MINI = :"gpt-4o-mini"

          # @!endgroup
        end

        # @deprecated
        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          # @!attribute batch_size
          #   Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :batch_size,
                   union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::BatchSize }

          # @!attribute learning_rate_multiplier
          #   Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :learning_rate_multiplier,
                   union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::LearningRateMultiplier }

          # @!attribute n_epochs
          #   The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :n_epochs, union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::NEpochs }

          # @!method initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
          #   The hyperparameters used for the fine-tuning job. This value is now deprecated
          #   in favor of `method`, and should be passed in under the `method` parameter.
          #
          #   @param batch_size [Symbol, :auto, Integer]
          #   @param learning_rate_multiplier [Symbol, :auto, Float]
          #   @param n_epochs [Symbol, :auto, Integer]

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          #
          # @see OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters#batch_size
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
          # @see OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters#learning_rate_multiplier
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
          # @see OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters#n_epochs
          module NEpochs
            extend OpenAI::Internal::Type::Union

            variant const: :auto

            variant Integer

            # @!method self.variants
            #   @return [Array(Symbol, :auto, Integer)]
          end
        end

        class Integration < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of integration to enable. Currently, only "wandb" (Weights and Biases)
          #   is supported.
          #
          #   @return [Symbol, :wandb]
          required :type, const: :wandb

          # @!attribute wandb
          #   The settings for your integration with Weights and Biases. This payload
          #   specifies the project that metrics will be sent to. Optionally, you can set an
          #   explicit display name for your run, add tags to your run, and set a default
          #   entity (team, username, etc) to be associated with your run.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb]
          required :wandb, -> { OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb }

          # @!method initialize(wandb:, type: :wandb)
          #   @param wandb [OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb]
          #   @param type [Symbol, :wandb]

          # @see OpenAI::Models::FineTuning::JobCreateParams::Integration#wandb
          class Wandb < OpenAI::Internal::Type::BaseModel
            # @!attribute project
            #   The name of the project that the new run will be created under.
            #
            #   @return [String]
            required :project, String

            # @!attribute entity
            #   The entity to use for the run. This allows you to set the team or username of
            #   the WandB user that you would like associated with the run. If not set, the
            #   default entity for the registered WandB API key is used.
            #
            #   @return [String, nil]
            optional :entity, String, nil?: true

            # @!attribute name
            #   A display name to set for the run. If not set, we will use the Job ID as the
            #   name.
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute tags
            #   A list of tags to be attached to the newly created run. These tags are passed
            #   through directly to WandB. Some default tags are generated by OpenAI:
            #   "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
            #
            #   @return [Array<String>, nil]
            optional :tags, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(project:, entity: nil, name: nil, tags: nil)
            #   The settings for your integration with Weights and Biases. This payload
            #   specifies the project that metrics will be sent to. Optionally, you can set an
            #   explicit display name for your run, add tags to your run, and set a default
            #   entity (team, username, etc) to be associated with your run.
            #
            #   @param project [String]
            #   @param entity [String, nil]
            #   @param name [String, nil]
            #   @param tags [Array<String>]
          end
        end

        class Method < OpenAI::Internal::Type::BaseModel
          # @!attribute dpo
          #   Configuration for the DPO fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo, nil]
          optional :dpo, -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo }

          # @!attribute supervised
          #   Configuration for the supervised fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised, nil]
          optional :supervised, -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised }

          # @!attribute type
          #   The type of method. Is either `supervised` or `dpo`.
          #
          #   @return [Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type, nil]
          optional :type, enum: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Type }

          # @!method initialize(dpo: nil, supervised: nil, type: nil)
          #   The method used for fine-tuning.
          #
          #   @param dpo [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo]
          #   @param supervised [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised]
          #   @param type [Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type]

          # @see OpenAI::Models::FineTuning::JobCreateParams::Method#dpo
          class Dpo < OpenAI::Internal::Type::BaseModel
            # @!attribute hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters, nil]
            optional :hyperparameters,
                     -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters }

            # @!method initialize(hyperparameters: nil)
            #   Configuration for the DPO fine-tuning method.
            #
            #   @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters]

            # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::BatchSize }

              # @!attribute beta
              #   The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :beta,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::Beta }

              # @!attribute learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::LearningRateMultiplier }

              # @!attribute n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::NEpochs }

              # @!method initialize(batch_size: nil, beta: nil, learning_rate_multiplier: nil, n_epochs: nil)
              #   The hyperparameters used for the fine-tuning job.
              #
              #   @param batch_size [Symbol, :auto, Integer]
              #   @param beta [Symbol, :auto, Float]
              #   @param learning_rate_multiplier [Symbol, :auto, Float]
              #   @param n_epochs [Symbol, :auto, Integer]

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters#batch_size
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
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters#beta
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
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters#learning_rate_multiplier
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
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters#n_epochs
              module NEpochs
                extend OpenAI::Internal::Type::Union

                variant const: :auto

                variant Integer

                # @!method self.variants
                #   @return [Array(Symbol, :auto, Integer)]
              end
            end
          end

          # @see OpenAI::Models::FineTuning::JobCreateParams::Method#supervised
          class Supervised < OpenAI::Internal::Type::BaseModel
            # @!attribute hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters, nil]
            optional :hyperparameters,
                     -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters }

            # @!method initialize(hyperparameters: nil)
            #   Configuration for the supervised fine-tuning method.
            #
            #   @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters]

            # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised#hyperparameters
            class Hyperparameters < OpenAI::Internal::Type::BaseModel
              # @!attribute batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::BatchSize }

              # @!attribute learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::LearningRateMultiplier }

              # @!attribute n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::NEpochs }

              # @!method initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil)
              #   The hyperparameters used for the fine-tuning job.
              #
              #   @param batch_size [Symbol, :auto, Integer]
              #   @param learning_rate_multiplier [Symbol, :auto, Float]
              #   @param n_epochs [Symbol, :auto, Integer]

              # Number of examples in each batch. A larger batch size means that model
              # parameters are updated less frequently, but with lower variance.
              #
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters#batch_size
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
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters#learning_rate_multiplier
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
              # @see OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters#n_epochs
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
          # @see OpenAI::Models::FineTuning::JobCreateParams::Method#type
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
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class JobCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute model
        #   The name of the model to fine-tune. You can select one of the
        #     [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        #
        #   @return [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model::Preset]
        required :model, union: -> { OpenAI::Models::FineTuning::JobCreateParams::Model }

        # @!attribute training_file
        #   The ID of an uploaded file that contains training data.
        #
        #     See [upload file](https://platform.openai.com/docs/api-reference/files/create)
        #     for how to upload a file.
        #
        #     Your dataset must be formatted as a JSONL file. Additionally, you must upload
        #     your file with the purpose `fine-tune`.
        #
        #     The contents of the file should differ depending on if the model uses the
        #     [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
        #     [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
        #     format, or if the fine-tuning method uses the
        #     [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
        #     format.
        #
        #     See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #     for more details.
        #
        #   @return [String]
        required :training_file, String

        # @!attribute [r] hyperparameters
        #   The hyperparameters used for the fine-tuning job. This value is now deprecated
        #     in favor of `method`, and should be passed in under the `method` parameter.
        #
        #   @return [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters, nil]
        optional :hyperparameters, -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters }

        # @!parse
        #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters]
        #   attr_writer :hyperparameters

        # @!attribute integrations
        #   A list of integrations to enable for your fine-tuning job.
        #
        #   @return [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        optional :integrations,
                 -> { OpenAI::ArrayOf[OpenAI::Models::FineTuning::JobCreateParams::Integration] },
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
        optional :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute [r] method_
        #   The method used for fine-tuning.
        #
        #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method, nil]
        optional :method_, -> { OpenAI::Models::FineTuning::JobCreateParams::Method }, api_name: :method

        # @!parse
        #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Method]
        #   attr_writer :method_

        # @!attribute seed
        #   The seed controls the reproducibility of the job. Passing in the same seed and
        #     job parameters should produce the same results, but may differ in rare cases. If
        #     a seed is not specified, one will be generated for you.
        #
        #   @return [Integer, nil]
        optional :seed, Integer, nil?: true

        # @!attribute suffix
        #   A string of up to 64 characters that will be added to your fine-tuned model
        #     name.
        #
        #     For example, a `suffix` of "custom-model-name" would produce a model name like
        #     `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        #
        #   @return [String, nil]
        optional :suffix, String, nil?: true

        # @!attribute validation_file
        #   The ID of an uploaded file that contains validation data.
        #
        #     If you provide this file, the data is used to generate validation metrics
        #     periodically during fine-tuning. These metrics can be viewed in the fine-tuning
        #     results file. The same data should not be present in both train and validation
        #     files.
        #
        #     Your dataset must be formatted as a JSONL file. You must upload your file with
        #     the purpose `fine-tune`.
        #
        #     See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        #     for more details.
        #
        #   @return [String, nil]
        optional :validation_file, String, nil?: true

        # @!parse
        #   # @param model [String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model::Preset]
        #   # @param training_file [String]
        #   # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters]
        #   # @param integrations [Array<OpenAI::Models::FineTuning::JobCreateParams::Integration>, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param method_ [OpenAI::Models::FineTuning::JobCreateParams::Method]
        #   # @param seed [Integer, nil]
        #   # @param suffix [String, nil]
        #   # @param validation_file [String, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(
        #     model:,
        #     training_file:,
        #     hyperparameters: nil,
        #     integrations: nil,
        #     metadata: nil,
        #     method_: nil,
        #     seed: nil,
        #     suffix: nil,
        #     validation_file: nil,
        #     request_options: {},
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # The name of the model to fine-tune. You can select one of the
        #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        class Model < OpenAI::Union
          variant String

          # The name of the model to fine-tune. You can select one of the
          # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
          variant enum: -> { OpenAI::Models::FineTuning::JobCreateParams::Model::Preset }

          # @abstract
          #
          # The name of the model to fine-tune. You can select one of the
          #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
          class Preset < OpenAI::Enum
            BABBAGE_002 = :"babbage-002"
            DAVINCI_002 = :"davinci-002"
            GPT_3_5_TURBO = :"gpt-3.5-turbo"
            GPT_4O_MINI = :"gpt-4o-mini"

            finalize!
          end

          # @!parse
          #   class << self
          #     # @return [Array(String, Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model::Preset)]
          #     def variants; end
          #   end
        end

        # @deprecated
        class Hyperparameters < OpenAI::BaseModel
          # @!attribute [r] batch_size
          #   Number of examples in each batch. A larger batch size means that model
          #     parameters are updated less frequently, but with lower variance.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :batch_size,
                   union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::BatchSize }

          # @!parse
          #   # @return [Symbol, :auto, Integer]
          #   attr_writer :batch_size

          # @!attribute [r] learning_rate_multiplier
          #   Scaling factor for the learning rate. A smaller learning rate may be useful to
          #     avoid overfitting.
          #
          #   @return [Symbol, :auto, Float, nil]
          optional :learning_rate_multiplier,
                   union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::LearningRateMultiplier }

          # @!parse
          #   # @return [Symbol, :auto, Float]
          #   attr_writer :learning_rate_multiplier

          # @!attribute [r] n_epochs
          #   The number of epochs to train the model for. An epoch refers to one full cycle
          #     through the training dataset.
          #
          #   @return [Symbol, :auto, Integer, nil]
          optional :n_epochs, union: -> { OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters::NEpochs }

          # @!parse
          #   # @return [Symbol, :auto, Integer]
          #   attr_writer :n_epochs

          # @!parse
          #   # The hyperparameters used for the fine-tuning job. This value is now deprecated
          #   #   in favor of `method`, and should be passed in under the `method` parameter.
          #   #
          #   # @param batch_size [Symbol, :auto, Integer]
          #   # @param learning_rate_multiplier [Symbol, :auto, Float]
          #   # @param n_epochs [Symbol, :auto, Integer]
          #   #
          #   def initialize(batch_size: nil, learning_rate_multiplier: nil, n_epochs: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # @abstract
          #
          # Number of examples in each batch. A larger batch size means that model
          #   parameters are updated less frequently, but with lower variance.
          class BatchSize < OpenAI::Union
            variant const: :auto

            variant Integer

            # @!parse
            #   class << self
            #     # @return [Array(Symbol, :auto, Integer)]
            #     def variants; end
            #   end
          end

          # @abstract
          #
          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          class LearningRateMultiplier < OpenAI::Union
            variant const: :auto

            variant Float

            # @!parse
            #   class << self
            #     # @return [Array(Symbol, :auto, Float)]
            #     def variants; end
            #   end
          end

          # @abstract
          #
          # The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          class NEpochs < OpenAI::Union
            variant const: :auto

            variant Integer

            # @!parse
            #   class << self
            #     # @return [Array(Symbol, :auto, Integer)]
            #     def variants; end
            #   end
          end
        end

        class Integration < OpenAI::BaseModel
          # @!attribute type
          #   The type of integration to enable. Currently, only "wandb" (Weights and Biases)
          #     is supported.
          #
          #   @return [Symbol, :wandb]
          required :type, const: :wandb

          # @!attribute wandb
          #   The settings for your integration with Weights and Biases. This payload
          #     specifies the project that metrics will be sent to. Optionally, you can set an
          #     explicit display name for your run, add tags to your run, and set a default
          #     entity (team, username, etc) to be associated with your run.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb]
          required :wandb, -> { OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb }

          # @!parse
          #   # @param wandb [OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb]
          #   # @param type [Symbol, :wandb]
          #   #
          #   def initialize(wandb:, type: :wandb, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class Wandb < OpenAI::BaseModel
            # @!attribute project
            #   The name of the project that the new run will be created under.
            #
            #   @return [String]
            required :project, String

            # @!attribute entity
            #   The entity to use for the run. This allows you to set the team or username of
            #     the WandB user that you would like associated with the run. If not set, the
            #     default entity for the registered WandB API key is used.
            #
            #   @return [String, nil]
            optional :entity, String, nil?: true

            # @!attribute name
            #   A display name to set for the run. If not set, we will use the Job ID as the
            #     name.
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute [r] tags
            #   A list of tags to be attached to the newly created run. These tags are passed
            #     through directly to WandB. Some default tags are generated by OpenAI:
            #     "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
            #
            #   @return [Array<String>, nil]
            optional :tags, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :tags

            # @!parse
            #   # The settings for your integration with Weights and Biases. This payload
            #   #   specifies the project that metrics will be sent to. Optionally, you can set an
            #   #   explicit display name for your run, add tags to your run, and set a default
            #   #   entity (team, username, etc) to be associated with your run.
            #   #
            #   # @param project [String]
            #   # @param entity [String, nil]
            #   # @param name [String, nil]
            #   # @param tags [Array<String>]
            #   #
            #   def initialize(project:, entity: nil, name: nil, tags: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end

        class Method < OpenAI::BaseModel
          # @!attribute [r] dpo
          #   Configuration for the DPO fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo, nil]
          optional :dpo, -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo }

          # @!parse
          #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo]
          #   attr_writer :dpo

          # @!attribute [r] supervised
          #   Configuration for the supervised fine-tuning method.
          #
          #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised, nil]
          optional :supervised, -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised }

          # @!parse
          #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised]
          #   attr_writer :supervised

          # @!attribute [r] type
          #   The type of method. Is either `supervised` or `dpo`.
          #
          #   @return [Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type, nil]
          optional :type, enum: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Type }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type]
          #   attr_writer :type

          # @!parse
          #   # The method used for fine-tuning.
          #   #
          #   # @param dpo [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo]
          #   # @param supervised [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised]
          #   # @param type [Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type]
          #   #
          #   def initialize(dpo: nil, supervised: nil, type: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class Dpo < OpenAI::BaseModel
            # @!attribute [r] hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters, nil]
            optional :hyperparameters,
                     -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters }

            # @!parse
            #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters]
            #   attr_writer :hyperparameters

            # @!parse
            #   # Configuration for the DPO fine-tuning method.
            #   #
            #   # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters]
            #   #
            #   def initialize(hyperparameters: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class Hyperparameters < OpenAI::BaseModel
              # @!attribute [r] batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #     parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::BatchSize }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :batch_size

              # @!attribute [r] beta
              #   The beta value for the DPO method. A higher beta value will increase the weight
              #     of the penalty between the policy and reference model.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :beta,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::Beta }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :beta

              # @!attribute [r] learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #     avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::LearningRateMultiplier }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :learning_rate_multiplier

              # @!attribute [r] n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #     through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters::NEpochs }

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

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              # @abstract
              #
              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              class BatchSize < OpenAI::Union
                variant const: :auto

                variant Integer

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Integer)]
                #     def variants; end
                #   end
              end

              # @abstract
              #
              # The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              class Beta < OpenAI::Union
                variant const: :auto

                variant Float

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Float)]
                #     def variants; end
                #   end
              end

              # @abstract
              #
              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                variant const: :auto

                variant Float

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Float)]
                #     def variants; end
                #   end
              end

              # @abstract
              #
              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                variant const: :auto

                variant Integer

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Integer)]
                #     def variants; end
                #   end
              end
            end
          end

          class Supervised < OpenAI::BaseModel
            # @!attribute [r] hyperparameters
            #   The hyperparameters used for the fine-tuning job.
            #
            #   @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters, nil]
            optional :hyperparameters,
                     -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters }

            # @!parse
            #   # @return [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters]
            #   attr_writer :hyperparameters

            # @!parse
            #   # Configuration for the supervised fine-tuning method.
            #   #
            #   # @param hyperparameters [OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters]
            #   #
            #   def initialize(hyperparameters: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class Hyperparameters < OpenAI::BaseModel
              # @!attribute [r] batch_size
              #   Number of examples in each batch. A larger batch size means that model
              #     parameters are updated less frequently, but with lower variance.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :batch_size,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::BatchSize }

              # @!parse
              #   # @return [Symbol, :auto, Integer]
              #   attr_writer :batch_size

              # @!attribute [r] learning_rate_multiplier
              #   Scaling factor for the learning rate. A smaller learning rate may be useful to
              #     avoid overfitting.
              #
              #   @return [Symbol, :auto, Float, nil]
              optional :learning_rate_multiplier,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::LearningRateMultiplier }

              # @!parse
              #   # @return [Symbol, :auto, Float]
              #   attr_writer :learning_rate_multiplier

              # @!attribute [r] n_epochs
              #   The number of epochs to train the model for. An epoch refers to one full cycle
              #     through the training dataset.
              #
              #   @return [Symbol, :auto, Integer, nil]
              optional :n_epochs,
                       union: -> { OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters::NEpochs }

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

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              # @abstract
              #
              # Number of examples in each batch. A larger batch size means that model
              #   parameters are updated less frequently, but with lower variance.
              class BatchSize < OpenAI::Union
                variant const: :auto

                variant Integer

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Integer)]
                #     def variants; end
                #   end
              end

              # @abstract
              #
              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                variant const: :auto

                variant Float

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Float)]
                #     def variants; end
                #   end
              end

              # @abstract
              #
              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                variant const: :auto

                variant Integer

                # @!parse
                #   class << self
                #     # @return [Array(Symbol, :auto, Integer)]
                #     def variants; end
                #   end
              end
            end
          end

          # @abstract
          #
          # The type of method. Is either `supervised` or `dpo`.
          class Type < OpenAI::Enum
            SUPERVISED = :supervised
            DPO = :dpo

            finalize!
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The name of the model to fine-tune. You can select one of the
        #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        # The ID of an uploaded file that contains training data.
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
        sig { returns(String) }
        def training_file
        end

        sig { params(_: String).returns(String) }
        def training_file=(_)
        end

        # The hyperparameters used for the fine-tuning job. This value is now deprecated
        #   in favor of `method`, and should be passed in under the `method` parameter.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)) }
        def hyperparameters
        end

        sig do
          params(_: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)
            .returns(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)
        end
        def hyperparameters=(_)
        end

        # A list of integrations to enable for your fine-tuning job.
        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration])) }
        def integrations
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]))
            .returns(T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]))
        end
        def integrations=(_)
        end

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        # The method used for fine-tuning.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method)) }
        def method_
        end

        sig do
          params(_: OpenAI::Models::FineTuning::JobCreateParams::Method)
            .returns(OpenAI::Models::FineTuning::JobCreateParams::Method)
        end
        def method_=(_)
        end

        # The seed controls the reproducibility of the job. Passing in the same seed and
        #   job parameters should produce the same results, but may differ in rare cases. If
        #   a seed is not specified, one will be generated for you.
        sig { returns(T.nilable(Integer)) }
        def seed
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def seed=(_)
        end

        # A string of up to 64 characters that will be added to your fine-tuned model
        #   name.
        #
        #   For example, a `suffix` of "custom-model-name" would produce a model name like
        #   `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        sig { returns(T.nilable(String)) }
        def suffix
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def suffix=(_)
        end

        # The ID of an uploaded file that contains validation data.
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

        # The name of the model to fine-tune. You can select one of the
        #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        class Model < OpenAI::Union
          abstract!

          # The name of the model to fine-tune. You can select one of the
          #   [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
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
            sig { override.returns([String, Symbol]) }
            def variants
            end
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

          # The hyperparameters used for the fine-tuning job. This value is now deprecated
          #   in favor of `method`, and should be passed in under the `method` parameter.
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

            class << self
              sig { override.returns([Symbol, Integer]) }
              def variants
              end
            end
          end

          # Scaling factor for the learning rate. A smaller learning rate may be useful to
          #   avoid overfitting.
          class LearningRateMultiplier < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([Symbol, Float]) }
              def variants
              end
            end
          end

          # The number of epochs to train the model for. An epoch refers to one full cycle
          #   through the training dataset.
          class NEpochs < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([Symbol, Integer]) }
              def variants
              end
            end
          end
        end

        class Integration < OpenAI::BaseModel
          # The type of integration to enable. Currently, only "wandb" (Weights and Biases)
          #   is supported.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # The settings for your integration with Weights and Biases. This payload
          #   specifies the project that metrics will be sent to. Optionally, you can set an
          #   explicit display name for your run, add tags to your run, and set a default
          #   entity (team, username, etc) to be associated with your run.
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
            # The name of the project that the new run will be created under.
            sig { returns(String) }
            def project
            end

            sig { params(_: String).returns(String) }
            def project=(_)
            end

            # The entity to use for the run. This allows you to set the team or username of
            #   the WandB user that you would like associated with the run. If not set, the
            #   default entity for the registered WandB API key is used.
            sig { returns(T.nilable(String)) }
            def entity
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def entity=(_)
            end

            # A display name to set for the run. If not set, we will use the Job ID as the
            #   name.
            sig { returns(T.nilable(String)) }
            def name
            end

            sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
            def name=(_)
            end

            # A list of tags to be attached to the newly created run. These tags are passed
            #   through directly to WandB. Some default tags are generated by OpenAI:
            #   "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
            sig { returns(T.nilable(T::Array[String])) }
            def tags
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def tags=(_)
            end

            # The settings for your integration with Weights and Biases. This payload
            #   specifies the project that metrics will be sent to. Optionally, you can set an
            #   explicit display name for your run, add tags to your run, and set a default
            #   entity (team, username, etc) to be associated with your run.
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
          # Configuration for the DPO fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)) }
          def dpo
          end

          sig do
            params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)
              .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)
          end
          def dpo=(_)
          end

          # Configuration for the supervised fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)) }
          def supervised
          end

          sig do
            params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)
              .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)
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
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            # Configuration for the DPO fine-tuning method.
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

                class << self
                  sig { override.returns([Symbol, Integer]) }
                  def variants
                  end
                end
              end

              # The beta value for the DPO method. A higher beta value will increase the weight
              #   of the penalty between the policy and reference model.
              class Beta < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([Symbol, Float]) }
                  def variants
                  end
                end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([Symbol, Float]) }
                  def variants
                  end
                end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([Symbol, Integer]) }
                  def variants
                  end
                end
              end
            end
          end

          class Supervised < OpenAI::BaseModel
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)) }
            def hyperparameters
            end

            sig do
              params(_: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)
                .returns(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)
            end
            def hyperparameters=(_)
            end

            # Configuration for the supervised fine-tuning method.
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

                class << self
                  sig { override.returns([Symbol, Integer]) }
                  def variants
                  end
                end
              end

              # Scaling factor for the learning rate. A smaller learning rate may be useful to
              #   avoid overfitting.
              class LearningRateMultiplier < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([Symbol, Float]) }
                  def variants
                  end
                end
              end

              # The number of epochs to train the model for. An epoch refers to one full cycle
              #   through the training dataset.
              class NEpochs < OpenAI::Union
                abstract!

                class << self
                  sig { override.returns([Symbol, Integer]) }
                  def variants
                  end
                end
              end
            end
          end

          # The type of method. Is either `supervised` or `dpo`.
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

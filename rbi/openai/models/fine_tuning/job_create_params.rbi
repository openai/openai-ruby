# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The name of the model to fine-tune. You can select one of the
        # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        sig do
          returns(
            T.any(String, OpenAI::FineTuning::JobCreateParams::Model::OrSymbol)
          )
        end
        attr_accessor :model

        # The ID of an uploaded file that contains training data.
        #
        # See [upload file](https://platform.openai.com/docs/api-reference/files/create)
        # for how to upload a file.
        #
        # Your dataset must be formatted as a JSONL file. Additionally, you must upload
        # your file with the purpose `fine-tune`.
        #
        # The contents of the file should differ depending on if the model uses the
        # [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
        # [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
        # format, or if the fine-tuning method uses the
        # [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
        # format.
        #
        # See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        # for more details.
        sig { returns(String) }
        attr_accessor :training_file

        # The hyperparameters used for the fine-tuning job. This value is now deprecated
        # in favor of `method`, and should be passed in under the `method` parameter.
        sig do
          returns(
            T.nilable(OpenAI::FineTuning::JobCreateParams::Hyperparameters)
          )
        end
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters:
              OpenAI::FineTuning::JobCreateParams::Hyperparameters::OrHash
          ).void
        end
        attr_writer :hyperparameters

        # A list of integrations to enable for your fine-tuning job.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::FineTuning::JobCreateParams::Integration]
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
        sig { returns(T.nilable(OpenAI::FineTuning::JobCreateParams::Method)) }
        attr_reader :method_

        sig do
          params(
            method_: OpenAI::FineTuning::JobCreateParams::Method::OrHash
          ).void
        end
        attr_writer :method_

        # The seed controls the reproducibility of the job. Passing in the same seed and
        # job parameters should produce the same results, but may differ in rare cases. If
        # a seed is not specified, one will be generated for you.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :seed

        # A string of up to 64 characters that will be added to your fine-tuned model
        # name.
        #
        # For example, a `suffix` of "custom-model-name" would produce a model name like
        # `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
        sig { returns(T.nilable(String)) }
        attr_accessor :suffix

        # The ID of an uploaded file that contains validation data.
        #
        # If you provide this file, the data is used to generate validation metrics
        # periodically during fine-tuning. These metrics can be viewed in the fine-tuning
        # results file. The same data should not be present in both train and validation
        # files.
        #
        # Your dataset must be formatted as a JSONL file. You must upload your file with
        # the purpose `fine-tune`.
        #
        # See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
        # for more details.
        sig { returns(T.nilable(String)) }
        attr_accessor :validation_file

        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::FineTuning::JobCreateParams::Model::OrSymbol
              ),
            training_file: String,
            hyperparameters:
              OpenAI::FineTuning::JobCreateParams::Hyperparameters::OrHash,
            integrations:
              T.nilable(
                T::Array[
                  OpenAI::FineTuning::JobCreateParams::Integration::OrHash
                ]
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            method_: OpenAI::FineTuning::JobCreateParams::Method::OrHash,
            seed: T.nilable(Integer),
            suffix: T.nilable(String),
            validation_file: T.nilable(String),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The name of the model to fine-tune. You can select one of the
          # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
          model:,
          # The ID of an uploaded file that contains training data.
          #
          # See [upload file](https://platform.openai.com/docs/api-reference/files/create)
          # for how to upload a file.
          #
          # Your dataset must be formatted as a JSONL file. Additionally, you must upload
          # your file with the purpose `fine-tune`.
          #
          # The contents of the file should differ depending on if the model uses the
          # [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input),
          # [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input)
          # format, or if the fine-tuning method uses the
          # [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input)
          # format.
          #
          # See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
          # for more details.
          training_file:,
          # The hyperparameters used for the fine-tuning job. This value is now deprecated
          # in favor of `method`, and should be passed in under the `method` parameter.
          hyperparameters: nil,
          # A list of integrations to enable for your fine-tuning job.
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
          # The seed controls the reproducibility of the job. Passing in the same seed and
          # job parameters should produce the same results, but may differ in rare cases. If
          # a seed is not specified, one will be generated for you.
          seed: nil,
          # A string of up to 64 characters that will be added to your fine-tuned model
          # name.
          #
          # For example, a `suffix` of "custom-model-name" would produce a model name like
          # `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.
          suffix: nil,
          # The ID of an uploaded file that contains validation data.
          #
          # If you provide this file, the data is used to generate validation metrics
          # periodically during fine-tuning. These metrics can be viewed in the fine-tuning
          # results file. The same data should not be present in both train and validation
          # files.
          #
          # Your dataset must be formatted as a JSONL file. You must upload your file with
          # the purpose `fine-tune`.
          #
          # See the [fine-tuning guide](https://platform.openai.com/docs/guides/fine-tuning)
          # for more details.
          validation_file: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              model:
                T.any(
                  String,
                  OpenAI::FineTuning::JobCreateParams::Model::OrSymbol
                ),
              training_file: String,
              hyperparameters:
                OpenAI::FineTuning::JobCreateParams::Hyperparameters,
              integrations:
                T.nilable(
                  T::Array[OpenAI::FineTuning::JobCreateParams::Integration]
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              method_: OpenAI::FineTuning::JobCreateParams::Method,
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
        # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::FineTuning::JobCreateParams::Model::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::FineTuning::JobCreateParams::Model::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::FineTuning::JobCreateParams::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          BABBAGE_002 =
            T.let(
              :"babbage-002",
              OpenAI::FineTuning::JobCreateParams::Model::TaggedSymbol
            )
          DAVINCI_002 =
            T.let(
              :"davinci-002",
              OpenAI::FineTuning::JobCreateParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO =
            T.let(
              :"gpt-3.5-turbo",
              OpenAI::FineTuning::JobCreateParams::Model::TaggedSymbol
            )
          GPT_4O_MINI =
            T.let(
              :"gpt-4o-mini",
              OpenAI::FineTuning::JobCreateParams::Model::TaggedSymbol
            )
        end

        class Hyperparameters < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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

          # The hyperparameters used for the fine-tuning job. This value is now deprecated
          # in favor of `method`, and should be passed in under the `method` parameter.
          sig do
            params(
              batch_size: T.any(Symbol, Integer),
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
                batch_size: T.any(Symbol, Integer),
                learning_rate_multiplier: T.any(Symbol, Float),
                n_epochs: T.any(Symbol, Integer)
              }
            )
          end
          def to_hash
          end

          # Number of examples in each batch. A larger batch size means that model
          # parameters are updated less frequently, but with lower variance.
          module BatchSize
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(Symbol, Integer) }

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::JobCreateParams::Hyperparameters::BatchSize::Variants
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
                  OpenAI::FineTuning::JobCreateParams::Hyperparameters::LearningRateMultiplier::Variants
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
                  OpenAI::FineTuning::JobCreateParams::Hyperparameters::NEpochs::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        class Integration < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The type of integration to enable. Currently, only "wandb" (Weights and Biases)
          # is supported.
          sig { returns(Symbol) }
          attr_accessor :type

          # The settings for your integration with Weights and Biases. This payload
          # specifies the project that metrics will be sent to. Optionally, you can set an
          # explicit display name for your run, add tags to your run, and set a default
          # entity (team, username, etc) to be associated with your run.
          sig do
            returns(OpenAI::FineTuning::JobCreateParams::Integration::Wandb)
          end
          attr_reader :wandb

          sig do
            params(
              wandb:
                OpenAI::FineTuning::JobCreateParams::Integration::Wandb::OrHash
            ).void
          end
          attr_writer :wandb

          sig do
            params(
              wandb:
                OpenAI::FineTuning::JobCreateParams::Integration::Wandb::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The settings for your integration with Weights and Biases. This payload
            # specifies the project that metrics will be sent to. Optionally, you can set an
            # explicit display name for your run, add tags to your run, and set a default
            # entity (team, username, etc) to be associated with your run.
            wandb:,
            # The type of integration to enable. Currently, only "wandb" (Weights and Biases)
            # is supported.
            type: :wandb
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                wandb: OpenAI::FineTuning::JobCreateParams::Integration::Wandb
              }
            )
          end
          def to_hash
          end

          class Wandb < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The name of the project that the new run will be created under.
            sig { returns(String) }
            attr_accessor :project

            # The entity to use for the run. This allows you to set the team or username of
            # the WandB user that you would like associated with the run. If not set, the
            # default entity for the registered WandB API key is used.
            sig { returns(T.nilable(String)) }
            attr_accessor :entity

            # A display name to set for the run. If not set, we will use the Job ID as the
            # name.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # A list of tags to be attached to the newly created run. These tags are passed
            # through directly to WandB. Some default tags are generated by OpenAI:
            # "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :tags

            sig { params(tags: T::Array[String]).void }
            attr_writer :tags

            # The settings for your integration with Weights and Biases. This payload
            # specifies the project that metrics will be sent to. Optionally, you can set an
            # explicit display name for your run, add tags to your run, and set a default
            # entity (team, username, etc) to be associated with your run.
            sig do
              params(
                project: String,
                entity: T.nilable(String),
                name: T.nilable(String),
                tags: T::Array[String]
              ).returns(T.attached_class)
            end
            def self.new(
              # The name of the project that the new run will be created under.
              project:,
              # The entity to use for the run. This allows you to set the team or username of
              # the WandB user that you would like associated with the run. If not set, the
              # default entity for the registered WandB API key is used.
              entity: nil,
              # A display name to set for the run. If not set, we will use the Job ID as the
              # name.
              name: nil,
              # A list of tags to be attached to the newly created run. These tags are passed
              # through directly to WandB. Some default tags are generated by OpenAI:
              # "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
              tags: nil
            )
            end

            sig do
              override.returns(
                {
                  project: String,
                  entity: T.nilable(String),
                  name: T.nilable(String),
                  tags: T::Array[String]
                }
              )
            end
            def to_hash
            end
          end
        end

        class Method < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The type of method. Is either `supervised`, `dpo`, or `reinforcement`.
          sig do
            returns(OpenAI::FineTuning::JobCreateParams::Method::Type::OrSymbol)
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
              type: OpenAI::FineTuning::JobCreateParams::Method::Type::OrSymbol,
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
                  OpenAI::FineTuning::JobCreateParams::Method::Type::OrSymbol,
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
                T.all(Symbol, OpenAI::FineTuning::JobCreateParams::Method::Type)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SUPERVISED =
              T.let(
                :supervised,
                OpenAI::FineTuning::JobCreateParams::Method::Type::TaggedSymbol
              )
            DPO =
              T.let(
                :dpo,
                OpenAI::FineTuning::JobCreateParams::Method::Type::TaggedSymbol
              )
            REINFORCEMENT =
              T.let(
                :reinforcement,
                OpenAI::FineTuning::JobCreateParams::Method::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::FineTuning::JobCreateParams::Method::Type::TaggedSymbol
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

# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # The name of the model to fine-tune. You can select one of the
        # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        sig { returns(T.any(String, OpenAI::Models::FineTuning::JobCreateParams::Model::OrSymbol)) }
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
        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters)) }
        attr_reader :hyperparameters

        sig do
          params(
            hyperparameters: T.any(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :hyperparameters

        # A list of integrations to enable for your fine-tuning job.
        sig { returns(T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration])) }
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
        sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method)) }
        attr_reader :method_

        sig do
          params(method_: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method, OpenAI::Internal::AnyHash)).void
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
            model: T.any(String, OpenAI::Models::FineTuning::JobCreateParams::Model::OrSymbol),
            training_file: String,
            hyperparameters: T.any(OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters, OpenAI::Internal::AnyHash),
            integrations: T.nilable(
              T::Array[T.any(OpenAI::Models::FineTuning::JobCreateParams::Integration, OpenAI::Internal::AnyHash)]
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            method_: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method, OpenAI::Internal::AnyHash),
            seed: T.nilable(Integer),
            suffix: T.nilable(String),
            validation_file: T.nilable(String),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
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
        ); end
        sig do
          override
            .returns(
              {
                model: T.any(String, OpenAI::Models::FineTuning::JobCreateParams::Model::OrSymbol),
                training_file: String,
                hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Hyperparameters,
                integrations: T.nilable(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Integration]),
                metadata: T.nilable(T::Hash[Symbol, String]),
                method_: OpenAI::Models::FineTuning::JobCreateParams::Method,
                seed: T.nilable(Integer),
                suffix: T.nilable(String),
                validation_file: T.nilable(String),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # The name of the model to fine-tune. You can select one of the
        # [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).
        module Model
          extend OpenAI::Internal::Type::Union

          sig { override.returns([String, OpenAI::Models::FineTuning::JobCreateParams::Model::OrSymbol]) }
          def self.variants; end

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::JobCreateParams::Model) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::FineTuning::JobCreateParams::Model::TaggedSymbol) }

          BABBAGE_002 = T.let(:"babbage-002", OpenAI::Models::FineTuning::JobCreateParams::Model::TaggedSymbol)
          DAVINCI_002 = T.let(:"davinci-002", OpenAI::Models::FineTuning::JobCreateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO = T.let(:"gpt-3.5-turbo", OpenAI::Models::FineTuning::JobCreateParams::Model::TaggedSymbol)
          GPT_4O_MINI = T.let(:"gpt-4o-mini", OpenAI::Models::FineTuning::JobCreateParams::Model::TaggedSymbol)
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

          # The hyperparameters used for the fine-tuning job. This value is now deprecated
          # in favor of `method`, and should be passed in under the `method` parameter.
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

        class Integration < OpenAI::Internal::Type::BaseModel
          # The type of integration to enable. Currently, only "wandb" (Weights and Biases)
          # is supported.
          sig { returns(Symbol) }
          attr_accessor :type

          # The settings for your integration with Weights and Biases. This payload
          # specifies the project that metrics will be sent to. Optionally, you can set an
          # explicit display name for your run, add tags to your run, and set a default
          # entity (team, username, etc) to be associated with your run.
          sig { returns(OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb) }
          attr_reader :wandb

          sig do
            params(
              wandb: T.any(OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :wandb

          sig do
            params(
              wandb: T.any(OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb, OpenAI::Internal::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(wandb:, type: :wandb); end

          sig { override.returns({type: Symbol, wandb: OpenAI::Models::FineTuning::JobCreateParams::Integration::Wandb}) }
          def to_hash; end

          class Wandb < OpenAI::Internal::Type::BaseModel
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
              )
                .returns(T.attached_class)
            end
            def self.new(project:, entity: nil, name: nil, tags: nil); end

            sig do
              override
                .returns({
                           project: String,
                           entity: T.nilable(String),
                           name: T.nilable(String),
                           tags: T::Array[String]
                         })
            end
            def to_hash; end
          end
        end

        class Method < OpenAI::Internal::Type::BaseModel
          # Configuration for the DPO fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo)) }
          attr_reader :dpo

          sig do
            params(dpo: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo, OpenAI::Internal::AnyHash))
              .void
          end
          attr_writer :dpo

          # Configuration for the supervised fine-tuning method.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised)) }
          attr_reader :supervised

          sig do
            params(
              supervised: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :supervised

          # The type of method. Is either `supervised` or `dpo`.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Models::FineTuning::JobCreateParams::Method::Type::OrSymbol).void }
          attr_writer :type

          # The method used for fine-tuning.
          sig do
            params(
              dpo: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo, OpenAI::Internal::AnyHash),
              supervised: T.any(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised, OpenAI::Internal::AnyHash),
              type: OpenAI::Models::FineTuning::JobCreateParams::Method::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(dpo: nil, supervised: nil, type: nil); end

          sig do
            override
              .returns(
                {
                  dpo: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo,
                  supervised: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised,
                  type: OpenAI::Models::FineTuning::JobCreateParams::Method::Type::OrSymbol
                }
              )
          end
          def to_hash; end

          class Dpo < OpenAI::Internal::Type::BaseModel
            # The hyperparameters used for the fine-tuning job.
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters)) }
            attr_reader :hyperparameters

            sig do
              params(
                hyperparameters: T.any(
                  OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters,
                  OpenAI::Internal::AnyHash
                )
              )
                .void
            end
            attr_writer :hyperparameters

            # Configuration for the DPO fine-tuning method.
            sig do
              params(
                hyperparameters: T.any(
                  OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters,
                  OpenAI::Internal::AnyHash
                )
              )
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil); end

            sig do
              override
                .returns({hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Dpo::Hyperparameters})
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
            sig { returns(T.nilable(OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters)) }
            attr_reader :hyperparameters

            sig do
              params(
                hyperparameters: T.any(
                  OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters,
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
                  OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters,
                  OpenAI::Internal::AnyHash
                )
              )
                .returns(T.attached_class)
            end
            def self.new(hyperparameters: nil); end

            sig do
              override
                .returns(
                  {hyperparameters: OpenAI::Models::FineTuning::JobCreateParams::Method::Supervised::Hyperparameters}
                )
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

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::JobCreateParams::Method::Type) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::FineTuning::JobCreateParams::Method::Type::TaggedSymbol) }

            SUPERVISED = T.let(:supervised, OpenAI::Models::FineTuning::JobCreateParams::Method::Type::TaggedSymbol)
            DPO = T.let(:dpo, OpenAI::Models::FineTuning::JobCreateParams::Method::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::FineTuning::JobCreateParams::Method::Type::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end

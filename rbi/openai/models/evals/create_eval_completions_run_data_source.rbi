# typed: strong

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Internal::AnyHash
            )
          end

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        sig do
          returns(
            T.any(
              OpenAI::Evals::EvalJSONLFileContentSource,
              OpenAI::Evals::EvalJSONLFileIDSource,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
            )
          )
        end
        attr_accessor :source

        # The type of run data source. Always `completions`.
        sig do
          returns(
            OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol
          )
        end
        attr_accessor :type

        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
              )
            )
          )
        end
        attr_reader :input_messages

        sig do
          params(
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference::OrHash
              )
          ).void
        end
        attr_writer :input_messages

        # The name of the model to use for generating completions (e.g. "o3-mini").
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        sig do
          returns(
            T.nilable(
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams
            )
          )
        end
        attr_reader :sampling_params

        sig do
          params(
            sampling_params:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::OrHash
          ).void
        end
        attr_writer :sampling_params

        # A CompletionsRunDataSource object describing a model sampling configuration.
        sig do
          params(
            source:
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource::OrHash,
                OpenAI::Evals::EvalJSONLFileIDSource::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions::OrHash
              ),
            type:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference::OrHash
              ),
            model: String,
            sampling_params:
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # A StoredCompletionsRunDataSource configuration describing a set of filters
          source:,
          # The type of run data source. Always `completions`.
          type:,
          input_messages: nil,
          # The name of the model to use for generating completions (e.g. "o3-mini").
          model: nil,
          sampling_params: nil
        )
        end

        sig do
          override.returns(
            {
              source:
                T.any(
                  OpenAI::Evals::EvalJSONLFileContentSource,
                  OpenAI::Evals::EvalJSONLFileIDSource,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
                ),
              type:
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
              input_messages:
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
                ),
              model: String,
              sampling_params:
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams
            }
          )
        end
        def to_hash
        end

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        module Source
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource,
                OpenAI::Evals::EvalJSONLFileIDSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
              )
            end

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions,
                  OpenAI::Internal::AnyHash
                )
              end

            # The type of source. Always `stored_completions`.
            sig { returns(Symbol) }
            attr_accessor :type

            # An optional Unix timestamp to filter items created after this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_after

            # An optional Unix timestamp to filter items created before this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_before

            # An optional maximum number of items to return.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # An optional model to filter by (e.g., 'gpt-4o').
            sig { returns(T.nilable(String)) }
            attr_accessor :model

            # A StoredCompletionsRunDataSource configuration describing a set of filters
            sig do
              params(
                created_after: T.nilable(Integer),
                created_before: T.nilable(Integer),
                limit: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.nilable(String),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # An optional Unix timestamp to filter items created after this time.
              created_after: nil,
              # An optional Unix timestamp to filter items created before this time.
              created_before: nil,
              # An optional maximum number of items to return.
              limit: nil,
              # Set of 16 key-value pairs that can be attached to an object. This can be useful
              # for storing additional information about the object in a structured format, and
              # querying for objects via API or the dashboard.
              #
              # Keys are strings with a maximum length of 64 characters. Values are strings with
              # a maximum length of 512 characters.
              metadata: nil,
              # An optional model to filter by (e.g., 'gpt-4o').
              model: nil,
              # The type of source. Always `stored_completions`.
              type: :stored_completions
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  created_after: T.nilable(Integer),
                  created_before: T.nilable(Integer),
                  limit: T.nilable(Integer),
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  model: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The type of run data source. Always `completions`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETIONS =
            T.let(
              :completions,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module InputMessages
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
              )
            end

          class Template < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of chat messages forming the prompt or context. May include variable
            # references to the "item" namespace, ie {{item.name}}.
            sig do
              returns(
                T::Array[
                  T.any(OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem)
                ]
              )
            end
            attr_accessor :template

            # The type of input messages. Always `template`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                template:
                  T::Array[
                    T.any(
                      OpenAI::Responses::EasyInputMessage::OrHash,
                      OpenAI::EvalItem::OrHash
                    )
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # A list of chat messages forming the prompt or context. May include variable
              # references to the "item" namespace, ie {{item.name}}.
              template:,
              # The type of input messages. Always `template`.
              type: :template
            )
            end

            sig do
              override.returns(
                {
                  template:
                    T::Array[
                      T.any(
                        OpenAI::Responses::EasyInputMessage,
                        OpenAI::EvalItem
                      )
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            module Template
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(OpenAI::Responses::EasyInputMessage, OpenAI::EvalItem)
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end

          class ItemReference < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference,
                  OpenAI::Internal::AnyHash
                )
              end

            # A reference to a variable in the "item" namespace. Ie, "item.name"
            sig { returns(String) }
            attr_accessor :item_reference

            # The type of input messages. Always `item_reference`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(item_reference: String, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # A reference to a variable in the "item" namespace. Ie, "item.name"
              item_reference:,
              # The type of input messages. Always `item_reference`.
              type: :item_reference
            )
            end

            sig { override.returns({ item_reference: String, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class SamplingParams < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The maximum number of tokens in the generated output.
          sig { returns(T.nilable(Integer)) }
          attr_reader :max_completion_tokens

          sig { params(max_completion_tokens: Integer).void }
          attr_writer :max_completion_tokens

          # A seed value to initialize the randomness, during sampling.
          sig { returns(T.nilable(Integer)) }
          attr_reader :seed

          sig { params(seed: Integer).void }
          attr_writer :seed

          # A higher temperature increases randomness in the outputs.
          sig { returns(T.nilable(Float)) }
          attr_reader :temperature

          sig { params(temperature: Float).void }
          attr_writer :temperature

          # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
          sig { returns(T.nilable(Float)) }
          attr_reader :top_p

          sig { params(top_p: Float).void }
          attr_writer :top_p

          sig do
            params(
              max_completion_tokens: Integer,
              seed: Integer,
              temperature: Float,
              top_p: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The maximum number of tokens in the generated output.
            max_completion_tokens: nil,
            # A seed value to initialize the randomness, during sampling.
            seed: nil,
            # A higher temperature increases randomness in the outputs.
            temperature: nil,
            # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
            top_p: nil
          )
          end

          sig do
            override.returns(
              {
                max_completion_tokens: Integer,
                seed: Integer,
                temperature: Float,
                top_p: Float
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end

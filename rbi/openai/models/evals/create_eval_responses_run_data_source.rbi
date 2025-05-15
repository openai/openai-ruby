# typed: strong

module OpenAI
  module Models
    module Evals
      class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::CreateEvalResponsesRunDataSource,
              OpenAI::Internal::AnyHash
            )
          end

        # A EvalResponsesSource object describing a run data source configuration.
        sig do
          returns(
            T.any(
              OpenAI::Evals::EvalJSONLFileContentSource,
              OpenAI::Evals::EvalJSONLFileIDSource,
              OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses
            )
          )
        end
        attr_accessor :source

        # The type of run data source. Always `responses`.
        sig do
          returns(
            OpenAI::Evals::CreateEvalResponsesRunDataSource::Type::OrSymbol
          )
        end
        attr_accessor :type

        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
              )
            )
          )
        end
        attr_reader :input_messages

        sig do
          params(
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference::OrHash
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
              OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams
            )
          )
        end
        attr_reader :sampling_params

        sig do
          params(
            sampling_params:
              OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams::OrHash
          ).void
        end
        attr_writer :sampling_params

        # A ResponsesRunDataSource object describing a model sampling configuration.
        sig do
          params(
            source:
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource::OrHash,
                OpenAI::Evals::EvalJSONLFileIDSource::OrHash,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses::OrHash
              ),
            type:
              OpenAI::Evals::CreateEvalResponsesRunDataSource::Type::OrSymbol,
            input_messages:
              T.any(
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::OrHash,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference::OrHash
              ),
            model: String,
            sampling_params:
              OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # A EvalResponsesSource object describing a run data source configuration.
          source:,
          # The type of run data source. Always `responses`.
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
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses
                ),
              type:
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Type::OrSymbol,
              input_messages:
                T.any(
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template,
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                ),
              model: String,
              sampling_params:
                OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams
            }
          )
        end
        def to_hash
        end

        # A EvalResponsesSource object describing a run data source configuration.
        module Source
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::EvalJSONLFileContentSource,
                OpenAI::Evals::EvalJSONLFileIDSource,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses
              )
            end

          class Responses < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Responses,
                  OpenAI::Internal::AnyHash
                )
              end

            # The type of run data source. Always `responses`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Only include items created after this timestamp (inclusive). This is a query
            # parameter used to select responses.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_after

            # Only include items created before this timestamp (inclusive). This is a query
            # parameter used to select responses.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_before

            # Whether the response has tool calls. This is a query parameter used to select
            # responses.
            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :has_tool_calls

            # Optional string to search the 'instructions' field. This is a query parameter
            # used to select responses.
            sig { returns(T.nilable(String)) }
            attr_accessor :instructions_search

            # Metadata filter for the responses. This is a query parameter used to select
            # responses.
            sig { returns(T.nilable(T.anything)) }
            attr_accessor :metadata

            # The name of the model to find responses for. This is a query parameter used to
            # select responses.
            sig { returns(T.nilable(String)) }
            attr_accessor :model

            # Optional reasoning effort parameter. This is a query parameter used to select
            # responses.
            sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
            attr_accessor :reasoning_effort

            # Sampling temperature. This is a query parameter used to select responses.
            sig { returns(T.nilable(Float)) }
            attr_accessor :temperature

            # List of tool names. This is a query parameter used to select responses.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :tools

            # Nucleus sampling parameter. This is a query parameter used to select responses.
            sig { returns(T.nilable(Float)) }
            attr_accessor :top_p

            # List of user identifiers. This is a query parameter used to select responses.
            sig { returns(T.nilable(T::Array[String])) }
            attr_accessor :users

            # A EvalResponsesSource object describing a run data source configuration.
            sig do
              params(
                created_after: T.nilable(Integer),
                created_before: T.nilable(Integer),
                has_tool_calls: T.nilable(T::Boolean),
                instructions_search: T.nilable(String),
                metadata: T.nilable(T.anything),
                model: T.nilable(String),
                reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                temperature: T.nilable(Float),
                tools: T.nilable(T::Array[String]),
                top_p: T.nilable(Float),
                users: T.nilable(T::Array[String]),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Only include items created after this timestamp (inclusive). This is a query
              # parameter used to select responses.
              created_after: nil,
              # Only include items created before this timestamp (inclusive). This is a query
              # parameter used to select responses.
              created_before: nil,
              # Whether the response has tool calls. This is a query parameter used to select
              # responses.
              has_tool_calls: nil,
              # Optional string to search the 'instructions' field. This is a query parameter
              # used to select responses.
              instructions_search: nil,
              # Metadata filter for the responses. This is a query parameter used to select
              # responses.
              metadata: nil,
              # The name of the model to find responses for. This is a query parameter used to
              # select responses.
              model: nil,
              # Optional reasoning effort parameter. This is a query parameter used to select
              # responses.
              reasoning_effort: nil,
              # Sampling temperature. This is a query parameter used to select responses.
              temperature: nil,
              # List of tool names. This is a query parameter used to select responses.
              tools: nil,
              # Nucleus sampling parameter. This is a query parameter used to select responses.
              top_p: nil,
              # List of user identifiers. This is a query parameter used to select responses.
              users: nil,
              # The type of run data source. Always `responses`.
              type: :responses
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  created_after: T.nilable(Integer),
                  created_before: T.nilable(Integer),
                  has_tool_calls: T.nilable(T::Boolean),
                  instructions_search: T.nilable(String),
                  metadata: T.nilable(T.anything),
                  model: T.nilable(String),
                  reasoning_effort:
                    T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                  temperature: T.nilable(Float),
                  tools: T.nilable(T::Array[String]),
                  top_p: T.nilable(Float),
                  users: T.nilable(T::Array[String])
                }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Source::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The type of run data source. Always `responses`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          RESPONSES =
            T.let(
              :responses,
              OpenAI::Evals::CreateEvalResponsesRunDataSource::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Evals::CreateEvalResponsesRunDataSource::Type::TaggedSymbol
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
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
              )
            end

          class Template < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of chat messages forming the prompt or context. May include variable
            # references to the "item" namespace, ie {{item.name}}.
            sig do
              returns(
                T::Array[
                  T.any(
                    OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                    OpenAI::EvalItem
                  )
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
                      OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage::OrHash,
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
                        OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
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
                  T.any(
                    OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                    OpenAI::EvalItem
                  )
                end

              class ChatMessage < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The content of the message.
                sig { returns(String) }
                attr_accessor :content

                # The role of the message (e.g. "system", "assistant", "user").
                sig { returns(String) }
                attr_accessor :role

                sig do
                  params(content: String, role: String).returns(
                    T.attached_class
                  )
                end
                def self.new(
                  # The content of the message.
                  content:,
                  # The role of the message (e.g. "system", "assistant", "user").
                  role:
                )
                end

                sig { override.returns({ content: String, role: String }) }
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::Variants
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
                  OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::ItemReference,
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
                OpenAI::Evals::CreateEvalResponsesRunDataSource::InputMessages::Variants
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
                OpenAI::Evals::CreateEvalResponsesRunDataSource::SamplingParams,
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

# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::AssistantCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        sig { returns(T.any(String, OpenAI::ChatModel::OrSymbol)) }
        attr_accessor :model

        # The description of the assistant. The maximum length is 512 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # The system instructions that the assistant uses. The maximum length is 256,000
        # characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The name of the assistant. The maximum length is 256 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # Constrains effort on reasoning for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
        # effort can result in faster responses and fewer tokens used on reasoning in a
        # response.
        sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
        attr_accessor :reasoning_effort

        # Specifies the format that the model must output. Compatible with
        # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        # Outputs which ensures the model will match your supplied JSON schema. Learn more
        # in the
        # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        # message the model generates is valid JSON.
        #
        # **Important:** when using JSON mode, you **must** also instruct the model to
        # produce JSON yourself via a system or user message. Without this, the model may
        # generate an unending stream of whitespace until the generation reaches the token
        # limit, resulting in a long-running and seemingly "stuck" request. Also note that
        # the message content may be partially cut off if `finish_reason="length"`, which
        # indicates the generation exceeded `max_tokens` or the conversation exceeded the
        # max context length.
        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::ResponseFormatText,
                OpenAI::ResponseFormatJSONObject,
                OpenAI::ResponseFormatJSONSchema
              )
            )
          )
        end
        attr_accessor :response_format

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # A set of resources that are used by the assistant's tools. The resources are
        # specific to the type of tool. For example, the `code_interpreter` tool requires
        # a list of file IDs, while the `file_search` tool requires a list of vector store
        # IDs.
        sig do
          returns(T.nilable(OpenAI::Beta::AssistantCreateParams::ToolResources))
        end
        attr_reader :tool_resources

        sig do
          params(
            tool_resources:
              T.nilable(
                OpenAI::Beta::AssistantCreateParams::ToolResources::OrHash
              )
          ).void
        end
        attr_writer :tool_resources

        # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        # assistant. Tools can be of types `code_interpreter`, `file_search`, or
        # `function`.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::CodeInterpreterTool,
                  OpenAI::Beta::FileSearchTool,
                  OpenAI::Beta::FunctionTool
                )
              ]
            )
          )
        end
        attr_reader :tools

        sig do
          params(
            tools:
              T::Array[
                T.any(
                  OpenAI::Beta::CodeInterpreterTool::OrHash,
                  OpenAI::Beta::FileSearchTool::OrHash,
                  OpenAI::Beta::FunctionTool::OrHash
                )
              ]
          ).void
        end
        attr_writer :tools

        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or temperature but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        sig do
          params(
            model: T.any(String, OpenAI::ChatModel::OrSymbol),
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: T.nilable(String),
            reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            response_format:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash
                )
              ),
            temperature: T.nilable(Float),
            tool_resources:
              T.nilable(
                OpenAI::Beta::AssistantCreateParams::ToolResources::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Beta::CodeInterpreterTool::OrHash,
                  OpenAI::Beta::FileSearchTool::OrHash,
                  OpenAI::Beta::FunctionTool::OrHash
                )
              ],
            top_p: T.nilable(Float),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # ID of the model to use. You can use the
          # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
          # see all of your available models, or see our
          # [Model overview](https://platform.openai.com/docs/models) for descriptions of
          # them.
          model:,
          # The description of the assistant. The maximum length is 512 characters.
          description: nil,
          # The system instructions that the assistant uses. The maximum length is 256,000
          # characters.
          instructions: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The name of the assistant. The maximum length is 256 characters.
          name: nil,
          # Constrains effort on reasoning for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
          # effort can result in faster responses and fewer tokens used on reasoning in a
          # response.
          reasoning_effort: nil,
          # Specifies the format that the model must output. Compatible with
          # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          # message the model generates is valid JSON.
          #
          # **Important:** when using JSON mode, you **must** also instruct the model to
          # produce JSON yourself via a system or user message. Without this, the model may
          # generate an unending stream of whitespace until the generation reaches the token
          # limit, resulting in a long-running and seemingly "stuck" request. Also note that
          # the message content may be partially cut off if `finish_reason="length"`, which
          # indicates the generation exceeded `max_tokens` or the conversation exceeded the
          # max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic.
          temperature: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          tool_resources: nil,
          # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
          # assistant. Tools can be of types `code_interpreter`, `file_search`, or
          # `function`.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or temperature but not both.
          top_p: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              model: T.any(String, OpenAI::ChatModel::OrSymbol),
              description: T.nilable(String),
              instructions: T.nilable(String),
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: T.nilable(String),
              reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
              response_format:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::ResponseFormatText,
                    OpenAI::ResponseFormatJSONObject,
                    OpenAI::ResponseFormatJSONSchema
                  )
                ),
              temperature: T.nilable(Float),
              tool_resources:
                T.nilable(OpenAI::Beta::AssistantCreateParams::ToolResources),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Beta::CodeInterpreterTool,
                    OpenAI::Beta::FileSearchTool,
                    OpenAI::Beta::FunctionTool
                  )
                ],
              top_p: T.nilable(Float),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias { T.any(String, OpenAI::ChatModel::TaggedSymbol) }

          sig do
            override.returns(
              T::Array[OpenAI::Beta::AssistantCreateParams::Model::Variants]
            )
          end
          def self.variants
          end
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::AssistantCreateParams::ToolResources,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter
              )
            )
          end
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter:
                OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter::OrHash
            ).void
          end
          attr_writer :code_interpreter

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch
              )
            )
          end
          attr_reader :file_search

          sig do
            params(
              file_search:
                OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::OrHash
            ).void
          end
          attr_writer :file_search

          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          sig do
            params(
              code_interpreter:
                OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter::OrHash,
              file_search:
                OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::OrHash
            ).returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override.returns(
              {
                code_interpreter:
                  OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter,
                file_search:
                  OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch
              }
            )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            # available to the `code_interpreter` tool. There can be a maximum of 20 files
            # associated with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :file_ids

            sig { params(file_ids: T::Array[String]).void }
            attr_writer :file_ids

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(
              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              # available to the `code_interpreter` tool. There can be a maximum of 20 files
              # associated with the tool.
              file_ids: nil
            )
            end

            sig { override.returns({ file_ids: T::Array[String] }) }
            def to_hash
            end
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch,
                  OpenAI::Internal::AnyHash
                )
              end

            # The
            # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            # attached to this assistant. There can be a maximum of 1 vector store attached to
            # the assistant.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :vector_store_ids

            sig { params(vector_store_ids: T::Array[String]).void }
            attr_writer :vector_store_ids

            # A helper to create a
            # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            # with file_ids and attach it to this assistant. There can be a maximum of 1
            # vector store attached to the assistant.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore
                  ]
                )
              )
            end
            attr_reader :vector_stores

            sig do
              params(
                vector_stores:
                  T::Array[
                    OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::OrHash
                  ]
              ).void
            end
            attr_writer :vector_stores

            sig do
              params(
                vector_store_ids: T::Array[String],
                vector_stores:
                  T::Array[
                    OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::OrHash
                  ]
              ).returns(T.attached_class)
            end
            def self.new(
              # The
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # attached to this assistant. There can be a maximum of 1 vector store attached to
              # the assistant.
              vector_store_ids: nil,
              # A helper to create a
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # with file_ids and attach it to this assistant. There can be a maximum of 1
              # vector store attached to the assistant.
              vector_stores: nil
            )
            end

            sig do
              override.returns(
                {
                  vector_store_ids: T::Array[String],
                  vector_stores:
                    T::Array[
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore
                    ]
                }
              )
            end
            def to_hash
            end

            class VectorStore < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
              sig do
                returns(
                  T.nilable(
                    T.any(
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
                )
              end
              attr_reader :chunking_strategy

              sig do
                params(
                  chunking_strategy:
                    T.any(
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto::OrHash,
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::OrHash
                    )
                ).void
              end
              attr_writer :chunking_strategy

              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
              # add to the vector store. There can be a maximum of 10000 files in a vector
              # store.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :file_ids

              sig { params(file_ids: T::Array[String]).void }
              attr_writer :file_ids

              # Set of 16 key-value pairs that can be attached to an object. This can be useful
              # for storing additional information about the object in a structured format, and
              # querying for objects via API or the dashboard.
              #
              # Keys are strings with a maximum length of 64 characters. Values are strings with
              # a maximum length of 512 characters.
              sig { returns(T.nilable(T::Hash[Symbol, String])) }
              attr_accessor :metadata

              sig do
                params(
                  chunking_strategy:
                    T.any(
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto::OrHash,
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::OrHash
                    ),
                  file_ids: T::Array[String],
                  metadata: T.nilable(T::Hash[Symbol, String])
                ).returns(T.attached_class)
              end
              def self.new(
                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                # strategy.
                chunking_strategy: nil,
                # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
                # add to the vector store. There can be a maximum of 10000 files in a vector
                # store.
                file_ids: nil,
                # Set of 16 key-value pairs that can be attached to an object. This can be useful
                # for storing additional information about the object in a structured format, and
                # querying for objects via API or the dashboard.
                #
                # Keys are strings with a maximum length of 64 characters. Values are strings with
                # a maximum length of 512 characters.
                metadata: nil
              )
              end

              sig do
                override.returns(
                  {
                    chunking_strategy:
                      T.any(
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      ),
                    file_ids: T::Array[String],
                    metadata: T.nilable(T::Hash[Symbol, String])
                  }
                )
              end
              def to_hash
              end

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
              module ChunkingStrategy
                extend OpenAI::Internal::Type::Union

                Variants =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  end

                class Auto < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # Always `auto`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                  # `800` and `chunk_overlap_tokens` of `400`.
                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(
                    # Always `auto`.
                    type: :auto
                  )
                  end

                  sig { override.returns({ type: Symbol }) }
                  def to_hash
                  end
                end

                class Static < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  sig do
                    returns(
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                  end
                  attr_reader :static

                  sig do
                    params(
                      static:
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static::OrHash
                    ).void
                  end
                  attr_writer :static

                  # Always `static`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig do
                    params(
                      static:
                        OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static::OrHash,
                      type: Symbol
                    ).returns(T.attached_class)
                  end
                  def self.new(
                    static:,
                    # Always `static`.
                    type: :static
                  )
                  end

                  sig do
                    override.returns(
                      {
                        static:
                          OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                        type: Symbol
                      }
                    )
                  end
                  def to_hash
                  end

                  class Static < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # The number of tokens that overlap between chunks. The default value is `400`.
                    #
                    # Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                    sig { returns(Integer) }
                    attr_accessor :chunk_overlap_tokens

                    # The maximum number of tokens in each chunk. The default value is `800`. The
                    # minimum value is `100` and the maximum value is `4096`.
                    sig { returns(Integer) }
                    attr_accessor :max_chunk_size_tokens

                    sig do
                      params(
                        chunk_overlap_tokens: Integer,
                        max_chunk_size_tokens: Integer
                      ).returns(T.attached_class)
                    end
                    def self.new(
                      # The number of tokens that overlap between chunks. The default value is `400`.
                      #
                      # Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                      chunk_overlap_tokens:,
                      # The maximum number of tokens in each chunk. The default value is `800`. The
                      # minimum value is `100` and the maximum value is `4096`.
                      max_chunk_size_tokens:
                    )
                    end

                    sig do
                      override.returns(
                        {
                          chunk_overlap_tokens: Integer,
                          max_chunk_size_tokens: Integer
                        }
                      )
                    end
                    def to_hash
                    end
                  end
                end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Variants
                    ]
                  )
                end
                def self.variants
                end
              end
            end
          end
        end
      end
    end
  end
end

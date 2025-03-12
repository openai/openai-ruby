# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_)
        end

        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def reasoning_effort
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def reasoning_effort=(_)
        end

        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            )
          )
        end
        def response_format
        end

        sig do
          params(
            _: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            )
          )
            .returns(
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              )
            )
        end
        def response_format=(_)
        end

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources))
        end
        def tool_resources=(_)
        end

        sig do
          returns(
            T.nilable(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            )
          )
        end
        def tools
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            )
        end
        def tools=(_)
        end

        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig do
          params(
            model: T.any(String, Symbol),
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(OpenAI::Models::Metadata),
            name: T.nilable(String),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          model:,
          description: nil,
          instructions: nil,
          metadata: nil,
          name: nil,
          reasoning_effort: nil,
          response_format: nil,
          temperature: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                model: T.any(String, Symbol),
                description: T.nilable(String),
                instructions: T.nilable(String),
                metadata: T.nilable(OpenAI::Models::Metadata),
                name: T.nilable(String),
                reasoning_effort: T.nilable(Symbol),
                response_format: T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                ),
                temperature: T.nilable(Float),
                tool_resources: T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources),
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ],
                top_p: T.nilable(Float),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Model < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch
                }
              )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::BaseModel
            sig { returns(T.nilable(T::Array[String])) }
            def file_ids
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def file_ids=(_)
            end

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(file_ids: nil)
            end

            sig { override.returns({file_ids: T::Array[String]}) }
            def to_hash
            end
          end

          class FileSearch < OpenAI::BaseModel
            sig { returns(T.nilable(T::Array[String])) }
            def vector_store_ids
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def vector_store_ids=(_)
            end

            sig do
              returns(
                T.nilable(T::Array[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore])
              )
            end
            def vector_stores
            end

            sig do
              params(_: T::Array[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore])
                .returns(T::Array[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore])
            end
            def vector_stores=(_)
            end

            sig do
              params(
                vector_store_ids: T::Array[String],
                vector_stores: T::Array[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore]
              )
                .returns(T.attached_class)
            end
            def self.new(vector_store_ids: nil, vector_stores: nil)
            end

            sig do
              override
                .returns(
                  {
                    vector_store_ids: T::Array[String],
                    vector_stores: T::Array[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore]
                  }
                )
            end
            def to_hash
            end

            class VectorStore < OpenAI::BaseModel
              sig do
                returns(
                  T.nilable(
                    T.any(
                      OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
                )
              end
              def chunking_strategy
              end

              sig do
                params(
                  _: T.any(
                    OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                  )
                )
                  .returns(
                    T.any(
                      OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
              end
              def chunking_strategy=(_)
              end

              sig { returns(T.nilable(T::Array[String])) }
              def file_ids
              end

              sig { params(_: T::Array[String]).returns(T::Array[String]) }
              def file_ids=(_)
              end

              sig { returns(T.nilable(OpenAI::Models::Metadata)) }
              def metadata
              end

              sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
              def metadata=(_)
              end

              sig do
                params(
                  chunking_strategy: T.any(
                    OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                  ),
                  file_ids: T::Array[String],
                  metadata: T.nilable(OpenAI::Models::Metadata)
                )
                  .returns(T.attached_class)
              end
              def self.new(chunking_strategy: nil, file_ids: nil, metadata: nil)
              end

              sig do
                override
                  .returns(
                    {
                      chunking_strategy: T.any(
                        OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      ),
                      file_ids: T::Array[String],
                      metadata: T.nilable(OpenAI::Models::Metadata)
                    }
                  )
              end
              def to_hash
              end

              class ChunkingStrategy < OpenAI::Union
                abstract!

                class Auto < OpenAI::BaseModel
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(type: :auto)
                  end

                  sig { override.returns({type: Symbol}) }
                  def to_hash
                  end
                end

                class Static < OpenAI::BaseModel
                  sig do
                    returns(
                      OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                  end
                  def static
                  end

                  sig do
                    params(
                      _: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                      .returns(
                        OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                  end
                  def static=(_)
                  end

                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig do
                    params(
                      static: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(static:, type: :static)
                  end

                  sig do
                    override
                      .returns(
                        {
                          static: OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                          type: Symbol
                        }
                      )
                  end
                  def to_hash
                  end

                  class Static < OpenAI::BaseModel
                    sig { returns(Integer) }
                    def chunk_overlap_tokens
                    end

                    sig { params(_: Integer).returns(Integer) }
                    def chunk_overlap_tokens=(_)
                    end

                    sig { returns(Integer) }
                    def max_chunk_size_tokens
                    end

                    sig { params(_: Integer).returns(Integer) }
                    def max_chunk_size_tokens=(_)
                    end

                    sig do
                      params(
                        chunk_overlap_tokens: Integer,
                        max_chunk_size_tokens: Integer
                      ).returns(T.attached_class)
                    end
                    def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:)
                    end

                    sig { override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer}) }
                    def to_hash
                    end
                  end
                end

                class << self
                  sig do
                    override
                      .returns(
                        [[Symbol, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto], [Symbol, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]]
                      )
                  end
                  private def variants
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])) }
        def messages
        end

        sig do
          params(_: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])
            .returns(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])
        end
        def messages=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources))
        end
        def tool_resources=(_)
        end

        sig do
          params(
            messages: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message],
            metadata: T.nilable(OpenAI::Models::Metadata),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(messages: nil, metadata: nil, tool_resources: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                messages: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message],
                metadata: T.nilable(OpenAI::Models::Metadata),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Message < OpenAI::BaseModel
          sig do
            returns(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              )
            )
          end
          def content
          end

          sig do
            params(
              _: T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              )
            )
              .returns(
                T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                )
              )
          end
          def content=(_)
          end

          sig { returns(Symbol) }
          def role
          end

          sig { params(_: Symbol).returns(Symbol) }
          def role=(_)
          end

          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment])) }
          def attachments
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]))
          end
          def attachments=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          sig do
            params(
              content: T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              ),
              role: Symbol,
              attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]),
              metadata: T.nilable(OpenAI::Models::Metadata)
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, attachments: nil, metadata: nil)
          end

          sig do
            override
              .returns(
                {
                  content: T.any(
                    String,
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                      OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                      OpenAI::Models::Beta::Threads::TextContentBlockParam
                    )
                    ]
                  ),
                  role: Symbol,
                  attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]),
                  metadata: T.nilable(OpenAI::Models::Metadata)
                }
              )
          end
          def to_hash
          end

          class Content < OpenAI::Union
            abstract!

            MessageContentPartParamArray = T.type_alias do
              T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                OpenAI::Models::Beta::Threads::TextContentBlockParam
              )
              ]
            end

            class << self
              sig do
                override
                  .returns(
                    [
                      [NilClass, String],
                      [
                        NilClass,
                        T::Array[
                                            T.any(
                                              OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                                              OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                                              OpenAI::Models::Beta::Threads::TextContentBlockParam
                                            )
                                            ]
                      ]
                    ]
                  )
              end
              private def variants
              end
            end
          end

          class Role < OpenAI::Enum
            abstract!

            USER = :user
            ASSISTANT = :assistant

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class Attachment < OpenAI::BaseModel
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            sig do
              returns(
                T.nilable(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
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
                  OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                )
                ]
              )
                .returns(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                  )
                  ]
                )
            end
            def tools=(_)
            end

            sig do
              params(
                file_id: String,
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                )
                ]
              )
                .returns(T.attached_class)
            end
            def self.new(file_id: nil, tools: nil)
            end

            sig do
              override
                .returns(
                  {
                    file_id: String,
                    tools: T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                    )
                    ]
                  }
                )
            end
            def to_hash
            end

            class Tool < OpenAI::Union
              abstract!

              class FileSearch < OpenAI::BaseModel
                sig { returns(Symbol) }
                def type
                end

                sig { params(_: Symbol).returns(Symbol) }
                def type=(_)
                end

                sig { params(type: Symbol).returns(T.attached_class) }
                def self.new(type: :file_search)
                end

                sig { override.returns({type: Symbol}) }
                def to_hash
                end
              end

              class << self
                sig do
                  override
                    .returns(
                      [[Symbol, OpenAI::Models::Beta::CodeInterpreterTool], [Symbol, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch]]
                    )
                end
                private def variants
                end
              end
            end
          end
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch
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
                T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore])
              )
            end
            def vector_stores
            end

            sig do
              params(_: T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore])
                .returns(T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore])
            end
            def vector_stores=(_)
            end

            sig do
              params(
                vector_store_ids: T::Array[String],
                vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore]
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
                    vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore]
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
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
                )
              end
              def chunking_strategy
              end

              sig do
                params(
                  _: T.any(
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                  )
                )
                  .returns(
                    T.any(
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
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
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
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
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
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
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                  end
                  def static
                  end

                  sig do
                    params(
                      _: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                      .returns(
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
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
                      static: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
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
                          static: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
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
                        [[Symbol, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto], [Symbol, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]]
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

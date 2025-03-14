# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
        #   start the thread with.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])) }
        def messages
        end

        sig do
          params(_: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])
            .returns(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])
        end
        def messages=(_)
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

        # A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
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
          # The text contents of the message.
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

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
          sig { returns(Symbol) }
          def role
          end

          sig { params(_: Symbol).returns(Symbol) }
          def role=(_)
          end

          # A list of files attached to the message, and the tools they should be added to.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment])) }
          def attachments
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]))
          end
          def attachments=(_)
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

          # The text contents of the message.
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
                      String,
                      T::Array[
                                          T.any(
                                            OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                                            OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                                            OpenAI::Models::Beta::Threads::TextContentBlockParam
                                          )
                                          ]
                    ]
                  )
              end
              def variants
              end
            end
          end

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
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
            # The ID of the file to attach to the message.
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The tools to add this file to.
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
                # The type of tool being defined: `file_search`
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
                      [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch]
                    )
                end
                def variants
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

          # A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
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
            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
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
            # The
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this thread. There can be a maximum of 1 vector store attached to
            #   the thread.
            sig { returns(T.nilable(T::Array[String])) }
            def vector_store_ids
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def vector_store_ids=(_)
            end

            # A helper to create a
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   with file_ids and attach it to this thread. There can be a maximum of 1 vector
            #   store attached to the thread.
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
              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #   strategy.
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

              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
              #   add to the vector store. There can be a maximum of 10000 files in a vector
              #   store.
              sig { returns(T.nilable(T::Array[String])) }
              def file_ids
              end

              sig { params(_: T::Array[String]).returns(T::Array[String]) }
              def file_ids=(_)
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

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #   strategy.
              class ChunkingStrategy < OpenAI::Union
                abstract!

                class Auto < OpenAI::BaseModel
                  # Always `auto`.
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                  #   `800` and `chunk_overlap_tokens` of `400`.
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

                  # Always `static`.
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
                    # The number of tokens that overlap between chunks. The default value is `400`.
                    #
                    #   Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                    sig { returns(Integer) }
                    def chunk_overlap_tokens
                    end

                    sig { params(_: Integer).returns(Integer) }
                    def chunk_overlap_tokens=(_)
                    end

                    # The maximum number of tokens in each chunk. The default value is `800`. The
                    #   minimum value is `100` and the maximum value is `4096`.
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
                        [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
                      )
                  end
                  def variants
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

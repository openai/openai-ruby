# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
        # start the thread with.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message])) }
        attr_reader :messages

        sig do
          params(
            messages: T::Array[T.any(OpenAI::Models::Beta::ThreadCreateParams::Message, OpenAI::Internal::AnyHash)]
          )
            .void
        end
        attr_writer :messages

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # A set of resources that are made available to the assistant's tools in this
        # thread. The resources are specific to the type of tool. For example, the
        # `code_interpreter` tool requires a list of file IDs, while the `file_search`
        # tool requires a list of vector store IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources)) }
        attr_reader :tool_resources

        sig do
          params(
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources, OpenAI::Internal::AnyHash))
          )
            .void
        end
        attr_writer :tool_resources

        sig do
          params(
            messages: T::Array[T.any(OpenAI::Models::Beta::ThreadCreateParams::Message, OpenAI::Internal::AnyHash)],
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources, OpenAI::Internal::AnyHash)),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(messages: nil, metadata: nil, tool_resources: nil, request_options: {}); end

        sig do
          override
            .returns(
              {
                messages: T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message],
                metadata: T.nilable(T::Hash[Symbol, String]),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        class Message < OpenAI::Internal::Type::BaseModel
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
          attr_accessor :content

          # The role of the entity that is creating the message. Allowed values include:
          #
          # - `user`: Indicates the message is sent by an actual user and should be used in
          #   most cases to represent user-generated messages.
          # - `assistant`: Indicates the message is generated by the assistant. Use this
          #   value to insert messages from the assistant into the conversation.
          sig { returns(OpenAI::Models::Beta::ThreadCreateParams::Message::Role::OrSymbol) }
          attr_accessor :role

          # A list of files attached to the message, and the tools they should be added to.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment])) }
          attr_accessor :attachments

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
              content: T.any(
                String,
                T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                ]
              ),
              role: OpenAI::Models::Beta::ThreadCreateParams::Message::Role::OrSymbol,
              attachments: T.nilable(
                T::Array[T.any(OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment, OpenAI::Internal::AnyHash)]
              ),
              metadata: T.nilable(T::Hash[Symbol, String])
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, attachments: nil, metadata: nil); end

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
                  role: OpenAI::Models::Beta::ThreadCreateParams::Message::Role::OrSymbol,
                  attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment]),
                  metadata: T.nilable(T::Hash[Symbol, String])
                }
              )
          end
          def to_hash; end

          # The text contents of the message.
          module Content
            extend OpenAI::Internal::Type::Union

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
            def self.variants; end

            MessageContentPartParamArray =
              T.let(
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContentPartParam],
                OpenAI::Internal::Type::Converter
              )
          end

          # The role of the entity that is creating the message. Allowed values include:
          #
          # - `user`: Indicates the message is sent by an actual user and should be used in
          #   most cases to represent user-generated messages.
          # - `assistant`: Indicates the message is generated by the assistant. Use this
          #   value to insert messages from the assistant into the conversation.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::ThreadCreateParams::Message::Role) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::ThreadCreateParams::Message::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::Beta::ThreadCreateParams::Message::Role::TaggedSymbol)
            ASSISTANT = T.let(:assistant, OpenAI::Models::Beta::ThreadCreateParams::Message::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::ThreadCreateParams::Message::Role::TaggedSymbol]) }
            def self.values; end
          end

          class Attachment < OpenAI::Internal::Type::BaseModel
            # The ID of the file to attach to the message.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

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
            attr_reader :tools

            sig do
              params(
                tools: T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                  )
                ]
              )
                .void
            end
            attr_writer :tools

            sig do
              params(
                file_id: String,
                tools: T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch
                  )
                ]
              )
                .returns(T.attached_class)
            end
            def self.new(file_id: nil, tools: nil); end

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
            def to_hash; end

            module Tool
              extend OpenAI::Internal::Type::Union

              class FileSearch < OpenAI::Internal::Type::BaseModel
                # The type of tool being defined: `file_search`
                sig { returns(Symbol) }
                attr_accessor :type

                sig { params(type: Symbol).returns(T.attached_class) }
                def self.new(type: :file_search); end

                sig { override.returns({type: Symbol}) }
                def to_hash; end
              end

              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch]
                  )
              end
              def self.variants; end
            end
          end
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter)) }
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter: T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :code_interpreter

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch)) }
          attr_reader :file_search

          sig do
            params(
              file_search: T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :file_search

          # A set of resources that are made available to the assistant's tools in this
          # thread. The resources are specific to the type of tool. For example, the
          # `code_interpreter` tool requires a list of file IDs, while the `file_search`
          # tool requires a list of vector store IDs.
          sig do
            params(
              code_interpreter: T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter, OpenAI::Internal::AnyHash),
              file_search: T.any(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil); end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch
                }
              )
          end
          def to_hash; end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            # available to the `code_interpreter` tool. There can be a maximum of 20 files
            # associated with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :file_ids

            sig { params(file_ids: T::Array[String]).void }
            attr_writer :file_ids

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(file_ids: nil); end

            sig { override.returns({file_ids: T::Array[String]}) }
            def to_hash; end
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            # The
            # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            # attached to this thread. There can be a maximum of 1 vector store attached to
            # the thread.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :vector_store_ids

            sig { params(vector_store_ids: T::Array[String]).void }
            attr_writer :vector_store_ids

            # A helper to create a
            # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            # with file_ids and attach it to this thread. There can be a maximum of 1 vector
            # store attached to the thread.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore])
              )
            end
            attr_reader :vector_stores

            sig do
              params(
                vector_stores: T::Array[
                  T.any(
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore,
                    OpenAI::Internal::AnyHash
                  )
                ]
              )
                .void
            end
            attr_writer :vector_stores

            sig do
              params(
                vector_store_ids: T::Array[String],
                vector_stores: T::Array[
                  T.any(
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore,
                    OpenAI::Internal::AnyHash
                  )
                ]
              )
                .returns(T.attached_class)
            end
            def self.new(vector_store_ids: nil, vector_stores: nil); end

            sig do
              override
                .returns(
                  {
                    vector_store_ids: T::Array[String],
                    vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore]
                  }
                )
            end
            def to_hash; end

            class VectorStore < OpenAI::Internal::Type::BaseModel
              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
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
              attr_reader :chunking_strategy

              sig do
                params(
                  chunking_strategy: T.any(
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                  )
                )
                  .void
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
                  chunking_strategy: T.any(
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                  ),
                  file_ids: T::Array[String],
                  metadata: T.nilable(T::Hash[Symbol, String])
                )
                  .returns(T.attached_class)
              end
              def self.new(chunking_strategy: nil, file_ids: nil, metadata: nil); end

              sig do
                override
                  .returns(
                    {
                      chunking_strategy: T.any(
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      ),
                      file_ids: T::Array[String],
                      metadata: T.nilable(T::Hash[Symbol, String])
                    }
                  )
              end
              def to_hash; end

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
              module ChunkingStrategy
                extend OpenAI::Internal::Type::Union

                class Auto < OpenAI::Internal::Type::BaseModel
                  # Always `auto`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                  # `800` and `chunk_overlap_tokens` of `400`.
                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(type: :auto); end

                  sig { override.returns({type: Symbol}) }
                  def to_hash; end
                end

                class Static < OpenAI::Internal::Type::BaseModel
                  sig do
                    returns(
                      OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                    )
                  end
                  attr_reader :static

                  sig do
                    params(
                      static: T.any(
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                        OpenAI::Internal::AnyHash
                      )
                    )
                      .void
                  end
                  attr_writer :static

                  # Always `static`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig do
                    params(
                      static: T.any(
                        OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                        OpenAI::Internal::AnyHash
                      ),
                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(static:, type: :static); end

                  sig do
                    override
                      .returns(
                        {
                          static: OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                          type: Symbol
                        }
                      )
                  end
                  def to_hash; end

                  class Static < OpenAI::Internal::Type::BaseModel
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
                    def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:); end

                    sig { override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer}) }
                    def to_hash; end
                  end
                end

                sig do
                  override
                    .returns(
                      [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
                    )
                end
                def self.variants; end
              end
            end
          end
        end
      end
    end
  end
end

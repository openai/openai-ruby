# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute [r] messages
        #   A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
        #     start the thread with.
        #
        #   @return [Array<OpenAI::Models::Beta::ThreadCreateParams::Message>, nil]
        optional :messages, -> { OpenAI::ArrayOf[OpenAI::Models::Beta::ThreadCreateParams::Message] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Beta::ThreadCreateParams::Message>]
        #   attr_writer :messages

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute tool_resources
        #   A set of resources that are made available to the assistant's tools in this
        #     thread. The resources are specific to the type of tool. For example, the
        #     `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #     tool requires a list of vector store IDs.
        #
        #   @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources }, nil?: true

        # @!parse
        #   # @param messages [Array<OpenAI::Models::Beta::ThreadCreateParams::Message>]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param tool_resources [OpenAI::Models::Beta::ThreadCreateParams::ToolResources, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(messages: nil, metadata: nil, tool_resources: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class Message < OpenAI::BaseModel
          # @!attribute content
          #   The text contents of the message.
          #
          #   @return [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
          required :content, union: -> { OpenAI::Models::Beta::ThreadCreateParams::Message::Content }

          # @!attribute role
          #   The role of the entity that is creating the message. Allowed values include:
          #
          #     - `user`: Indicates the message is sent by an actual user and should be used in
          #       most cases to represent user-generated messages.
          #     - `assistant`: Indicates the message is generated by the assistant. Use this
          #       value to insert messages from the assistant into the conversation.
          #
          #   @return [Symbol, OpenAI::Models::Beta::ThreadCreateParams::Message::Role]
          required :role, enum: -> { OpenAI::Models::Beta::ThreadCreateParams::Message::Role }

          # @!attribute attachments
          #   A list of files attached to the message, and the tools they should be added to.
          #
          #   @return [Array<OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment>, nil]
          optional :attachments,
                   -> { OpenAI::ArrayOf[OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment] },
                   nil?: true

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #     for storing additional information about the object in a structured format, and
          #     querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::HashOf[String], nil?: true

          # @!parse
          #   # @param content [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
          #   # @param role [Symbol, OpenAI::Models::Beta::ThreadCreateParams::Message::Role]
          #   # @param attachments [Array<OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment>, nil]
          #   # @param metadata [Hash{Symbol=>String}, nil]
          #   #
          #   def initialize(content:, role:, attachments: nil, metadata: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # The text contents of the message.
          module Content
            extend OpenAI::Union

            # The text contents of the message.
            variant String

            # An array of content parts with a defined type, each can be of type `text` or images can be passed with `image_url` or `image_file`. Image types are only supported on [Vision-compatible models](https://platform.openai.com/docs/models).
            variant -> { OpenAI::Models::Beta::ThreadCreateParams::Message::Content::MessageContentPartParamArray }

            # @!parse
            #   # @return [Array(String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>)]
            #   def self.variants; end

            MessageContentPartParamArray =
              OpenAI::ArrayOf[union: -> { OpenAI::Models::Beta::Threads::MessageContentPartParam }]
          end

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
          module Role
            extend OpenAI::Enum

            USER = :user
            ASSISTANT = :assistant

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end

          class Attachment < OpenAI::BaseModel
            # @!attribute [r] file_id
            #   The ID of the file to attach to the message.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_id

            # @!attribute [r] tools
            #   The tools to add this file to.
            #
            #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch>, nil]
            optional :tools,
                     -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch>]
            #   attr_writer :tools

            # @!parse
            #   # @param file_id [String]
            #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch>]
            #   #
            #   def initialize(file_id: nil, tools: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            module Tool
              extend OpenAI::Union

              discriminator :type

              variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

              variant :file_search,
                      -> { OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch }

              class FileSearch < OpenAI::BaseModel
                # @!attribute type
                #   The type of tool being defined: `file_search`
                #
                #   @return [Symbol, :file_search]
                required :type, const: :file_search

                # @!parse
                #   # @param type [Symbol, :file_search]
                #   #
                #   def initialize(type: :file_search, **) = super

                # def initialize: (Hash | OpenAI::BaseModel) -> void
              end

              # @!parse
              #   # @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateParams::Message::Attachment::Tool::FileSearch)]
              #   def self.variants; end
            end
          end
        end

        class ToolResources < OpenAI::BaseModel
          # @!attribute [r] code_interpreter
          #
          #   @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter,
                   -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter }

          # @!parse
          #   # @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter]
          #   attr_writer :code_interpreter

          # @!attribute [r] file_search
          #
          #   @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch }

          # @!parse
          #   # @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch]
          #   attr_writer :file_search

          # @!parse
          #   # A set of resources that are made available to the assistant's tools in this
          #   #   thread. The resources are specific to the type of tool. For example, the
          #   #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   #   tool requires a list of vector store IDs.
          #   #
          #   # @param code_interpreter [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::CodeInterpreter]
          #   # @param file_search [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch]
          #   #
          #   def initialize(code_interpreter: nil, file_search: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class CodeInterpreter < OpenAI::BaseModel
            # @!attribute [r] file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #     available to the `code_interpreter` tool. There can be a maximum of 20 files
            #     associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :file_ids

            # @!parse
            #   # @param file_ids [Array<String>]
            #   #
            #   def initialize(file_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end

          class FileSearch < OpenAI::BaseModel
            # @!attribute [r] vector_store_ids
            #   The
            #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #     attached to this thread. There can be a maximum of 1 vector store attached to
            #     the thread.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :vector_store_ids

            # @!attribute [r] vector_stores
            #   A helper to create a
            #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #     with file_ids and attach it to this thread. There can be a maximum of 1 vector
            #     store attached to the thread.
            #
            #   @return [Array<OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore>, nil]
            optional :vector_stores,
                     -> { OpenAI::ArrayOf[OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore>]
            #   attr_writer :vector_stores

            # @!parse
            #   # @param vector_store_ids [Array<String>]
            #   # @param vector_stores [Array<OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore>]
            #   #
            #   def initialize(vector_store_ids: nil, vector_stores: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class VectorStore < OpenAI::BaseModel
              # @!attribute [r] chunking_strategy
              #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #     strategy.
              #
              #   @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static, nil]
              optional :chunking_strategy,
                       union: -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy }

              # @!parse
              #   # @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
              #   attr_writer :chunking_strategy

              # @!attribute [r] file_ids
              #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
              #     add to the vector store. There can be a maximum of 10000 files in a vector
              #     store.
              #
              #   @return [Array<String>, nil]
              optional :file_ids, OpenAI::ArrayOf[String]

              # @!parse
              #   # @return [Array<String>]
              #   attr_writer :file_ids

              # @!attribute metadata
              #   Set of 16 key-value pairs that can be attached to an object. This can be useful
              #     for storing additional information about the object in a structured format, and
              #     querying for objects via API or the dashboard.
              #
              #     Keys are strings with a maximum length of 64 characters. Values are strings with
              #     a maximum length of 512 characters.
              #
              #   @return [Hash{Symbol=>String}, nil]
              optional :metadata, OpenAI::HashOf[String], nil?: true

              # @!parse
              #   # @param chunking_strategy [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
              #   # @param file_ids [Array<String>]
              #   # @param metadata [Hash{Symbol=>String}, nil]
              #   #
              #   def initialize(chunking_strategy: nil, file_ids: nil, metadata: nil, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #   strategy.
              module ChunkingStrategy
                extend OpenAI::Union

                discriminator :type

                # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
                variant :auto,
                        -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto }

                variant :static,
                        -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static }

                class Auto < OpenAI::BaseModel
                  # @!attribute type
                  #   Always `auto`.
                  #
                  #   @return [Symbol, :auto]
                  required :type, const: :auto

                  # @!parse
                  #   # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                  #   #   `800` and `chunk_overlap_tokens` of `400`.
                  #   #
                  #   # @param type [Symbol, :auto]
                  #   #
                  #   def initialize(type: :auto, **) = super

                  # def initialize: (Hash | OpenAI::BaseModel) -> void
                end

                class Static < OpenAI::BaseModel
                  # @!attribute static
                  #
                  #   @return [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  required :static,
                           -> { OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static }

                  # @!attribute type
                  #   Always `static`.
                  #
                  #   @return [Symbol, :static]
                  required :type, const: :static

                  # @!parse
                  #   # @param static [OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  #   # @param type [Symbol, :static]
                  #   #
                  #   def initialize(static:, type: :static, **) = super

                  # def initialize: (Hash | OpenAI::BaseModel) -> void

                  class Static < OpenAI::BaseModel
                    # @!attribute chunk_overlap_tokens
                    #   The number of tokens that overlap between chunks. The default value is `400`.
                    #
                    #     Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                    #
                    #   @return [Integer]
                    required :chunk_overlap_tokens, Integer

                    # @!attribute max_chunk_size_tokens
                    #   The maximum number of tokens in each chunk. The default value is `800`. The
                    #     minimum value is `100` and the maximum value is `4096`.
                    #
                    #   @return [Integer]
                    required :max_chunk_size_tokens, Integer

                    # @!parse
                    #   # @param chunk_overlap_tokens [Integer]
                    #   # @param max_chunk_size_tokens [Integer]
                    #   #
                    #   def initialize(chunk_overlap_tokens:, max_chunk_size_tokens:, **) = super

                    # def initialize: (Hash | OpenAI::BaseModel) -> void
                  end
                end

                # @!parse
                #   # @return [Array(OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static)]
                #   def self.variants; end
              end
            end
          end
        end
      end
    end
  end
end

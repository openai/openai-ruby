# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Threads#create_and_run
      #
      # @see OpenAI::Resources::Beta::Threads#stream_raw
      class ThreadCreateAndRunParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute assistant_id
        #   The ID of the
        #   [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
        #   execute this run.
        #
        #   @return [String]
        required :assistant_id, String

        # @!attribute instructions
        #   Override the default system message of the assistant. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute max_completion_tokens
        #   The maximum number of completion tokens that may be used over the course of the
        #   run. The run will make a best effort to use only the number of completion tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   completion tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        #   @return [Integer, nil]
        optional :max_completion_tokens, Integer, nil?: true

        # @!attribute max_prompt_tokens
        #   The maximum number of prompt tokens that may be used over the course of the run.
        #   The run will make a best effort to use only the number of prompt tokens
        #   specified, across multiple turns of the run. If the run exceeds the number of
        #   prompt tokens specified, the run will end with status `incomplete`. See
        #   `incomplete_details` for more info.
        #
        #   @return [Integer, nil]
        optional :max_prompt_tokens, Integer, nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute model
        #   The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #   be used to execute this run. If a value is provided here, it will override the
        #   model associated with the assistant. If not, the model associated with the
        #   assistant will be used.
        #
        #   @return [String, Symbol, OpenAI::Models::ChatModel, nil]
        optional :model, union: -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Model }, nil?: true

        # @!attribute parallel_tool_calls
        #   Whether to enable
        #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        #   during tool use.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean

        # @!attribute response_format
        #   Specifies the format that the model must output. Compatible with
        #   [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        #   [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        #   and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #   Outputs which ensures the model will match your supplied JSON schema. Learn more
        #   in the
        #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #   message the model generates is valid JSON.
        #
        #   **Important:** when using JSON mode, you **must** also instruct the model to
        #   produce JSON yourself via a system or user message. Without this, the model may
        #   generate an unending stream of whitespace until the generation reaches the token
        #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #   the message content may be partially cut off if `finish_reason="length"`, which
        #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #   max context length.
        #
        #   @return [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        optional :response_format, union: -> { OpenAI::Models::Beta::AssistantResponseFormatOption }, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

        # @!attribute thread
        #   Options to create a new thread. If no thread is provided when running a request,
        #   an empty thread will be created.
        #
        #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread, nil]
        optional :thread, -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread }

        # @!attribute tool_choice
        #   Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tools and instead generates a message. `auto` is the default value
        #   and means the model can pick between generating a message or calling one or more
        #   tools. `required` means the model must call one or more tools before responding
        #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
        optional :tool_choice, union: -> { OpenAI::Models::Beta::AssistantToolChoiceOption }, nil?: true

        # @!attribute tool_resources
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources }, nil?: true

        # @!attribute tools
        #   Override the tools the assistant can use for this run. This is useful for
        #   modifying the behavior on a per-run basis.
        #
        #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        optional :tools,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::AssistantTool] },
                 nil?: true

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!attribute truncation_strategy
        #   Controls for how a thread will be truncated prior to the run. Use this to
        #   control the intial context window of the run.
        #
        #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil]
        optional :truncation_strategy,
                 -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy },
                 nil?: true

        # @!method initialize(assistant_id:, instructions: nil, max_completion_tokens: nil, max_prompt_tokens: nil, metadata: nil, model: nil, parallel_tool_calls: nil, response_format: nil, temperature: nil, thread: nil, tool_choice: nil, tool_resources: nil, tools: nil, top_p: nil, truncation_strategy: nil, request_options: {})
        #   @param assistant_id [String]
        #   @param instructions [String, nil]
        #   @param max_completion_tokens [Integer, nil]
        #   @param max_prompt_tokens [Integer, nil]
        #   @param metadata [Hash{Symbol=>String}, nil]
        #   @param model [String, Symbol, OpenAI::Models::ChatModel, nil]
        #   @param parallel_tool_calls [Boolean]
        #   @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   @param temperature [Float, nil]
        #   @param thread [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread]
        #   @param tool_choice [Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto, OpenAI::Models::Beta::AssistantToolChoice, nil]
        #   @param tool_resources [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources, nil]
        #   @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        #   @param top_p [Float, nil]
        #   @param truncation_strategy [OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy, nil]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        # be used to execute this run. If a value is provided here, it will override the
        # model associated with the assistant. If not, the model associated with the
        # assistant will be used.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to be used to execute this run. If a value is provided here, it will override the model associated with the assistant. If not, the model associated with the assistant will be used.
          variant enum: -> { OpenAI::Models::ChatModel }

          # @!method self.variants
          #   @return [Array(String, Symbol, OpenAI::Models::ChatModel)]
        end

        class Thread < OpenAI::Internal::Type::BaseModel
          # @!attribute messages
          #   A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
          #   start the thread with.
          #
          #   @return [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message>, nil]
          optional :messages,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message] }

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute tool_resources
          #   A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          #
          #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources, nil]
          optional :tool_resources,
                   -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources },
                   nil?: true

          # @!method initialize(messages: nil, metadata: nil, tool_resources: nil)
          #   Options to create a new thread. If no thread is provided when running a request,
          #   an empty thread will be created.
          #
          #   @param messages [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message>]
          #   @param metadata [Hash{Symbol=>String}, nil]
          #   @param tool_resources [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources, nil]

          class Message < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The text contents of the message.
            #
            #   @return [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
            required :content, union: -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Content }

            # @!attribute role
            #   The role of the entity that is creating the message. Allowed values include:
            #
            #   - `user`: Indicates the message is sent by an actual user and should be used in
            #     most cases to represent user-generated messages.
            #   - `assistant`: Indicates the message is generated by the assistant. Use this
            #     value to insert messages from the assistant into the conversation.
            #
            #   @return [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role]
            required :role, enum: -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role }

            # @!attribute attachments
            #   A list of files attached to the message, and the tools they should be added to.
            #
            #   @return [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment>, nil]
            optional :attachments,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment] },
                     nil?: true

            # @!attribute metadata
            #   Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

            # @!method initialize(content:, role:, attachments: nil, metadata: nil)
            #   @param content [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
            #   @param role [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role]
            #   @param attachments [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment>, nil]
            #   @param metadata [Hash{Symbol=>String}, nil]

            # The text contents of the message.
            #
            # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message#content
            module Content
              extend OpenAI::Internal::Type::Union

              # The text contents of the message.
              variant String

              # An array of content parts with a defined type, each can be of type `text` or images can be passed with `image_url` or `image_file`. Image types are only supported on [Vision-compatible models](https://platform.openai.com/docs/models).
              variant -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Content::MessageContentPartParamArray }

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>)]

              MessageContentPartParamArray =
                OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Models::Beta::Threads::MessageContentPartParam }]
            end

            # The role of the entity that is creating the message. Allowed values include:
            #
            # - `user`: Indicates the message is sent by an actual user and should be used in
            #   most cases to represent user-generated messages.
            # - `assistant`: Indicates the message is generated by the assistant. Use this
            #   value to insert messages from the assistant into the conversation.
            #
            # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message#role
            module Role
              extend OpenAI::Internal::Type::Enum

              USER = :user
              ASSISTANT = :assistant

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            class Attachment < OpenAI::Internal::Type::BaseModel
              # @!attribute file_id
              #   The ID of the file to attach to the message.
              #
              #   @return [String, nil]
              optional :file_id, String

              # @!attribute tools
              #   The tools to add this file to.
              #
              #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch>, nil]
              optional :tools,
                       -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool] }

              # @!method initialize(file_id: nil, tools: nil)
              #   @param file_id [String]
              #   @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch>]

              module Tool
                extend OpenAI::Internal::Type::Union

                discriminator :type

                variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

                variant :file_search,
                        -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch }

                class FileSearch < OpenAI::Internal::Type::BaseModel
                  # @!attribute type
                  #   The type of tool being defined: `file_search`
                  #
                  #   @return [Symbol, :file_search]
                  required :type, const: :file_search

                  # @!method initialize(type: :file_search)
                  #   @param type [Symbol, :file_search]
                end

                # @!method self.variants
                #   @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch)]
              end
            end
          end

          # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread#tool_resources
          class ToolResources < OpenAI::Internal::Type::BaseModel
            # @!attribute code_interpreter
            #
            #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter, nil]
            optional :code_interpreter,
                     -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter }

            # @!attribute file_search
            #
            #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch, nil]
            optional :file_search,
                     -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch }

            # @!method initialize(code_interpreter: nil, file_search: nil)
            #   A set of resources that are made available to the assistant's tools in this
            #   thread. The resources are specific to the type of tool. For example, the
            #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
            #   tool requires a list of vector store IDs.
            #
            #   @param code_interpreter [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter]
            #   @param file_search [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch]

            # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources#code_interpreter
            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              # @!attribute file_ids
              #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              #   available to the `code_interpreter` tool. There can be a maximum of 20 files
              #   associated with the tool.
              #
              #   @return [Array<String>, nil]
              optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(file_ids: nil)
              #   @param file_ids [Array<String>]
            end

            # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources#file_search
            class FileSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute vector_store_ids
              #   The
              #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              #   attached to this thread. There can be a maximum of 1 vector store attached to
              #   the thread.
              #
              #   @return [Array<String>, nil]
              optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute vector_stores
              #   A helper to create a
              #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              #   with file_ids and attach it to this thread. There can be a maximum of 1 vector
              #   store attached to the thread.
              #
              #   @return [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore>, nil]
              optional :vector_stores,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore] }

              # @!method initialize(vector_store_ids: nil, vector_stores: nil)
              #   @param vector_store_ids [Array<String>]
              #   @param vector_stores [Array<OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore>]

              class VectorStore < OpenAI::Internal::Type::BaseModel
                # @!attribute chunking_strategy
                #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                #   strategy.
                #
                #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static, nil]
                optional :chunking_strategy,
                         union: -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy }

                # @!attribute file_ids
                #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
                #   add to the vector store. There can be a maximum of 10000 files in a vector
                #   store.
                #
                #   @return [Array<String>, nil]
                optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

                # @!attribute metadata
                #   Set of 16 key-value pairs that can be attached to an object. This can be useful
                #   for storing additional information about the object in a structured format, and
                #   querying for objects via API or the dashboard.
                #
                #   Keys are strings with a maximum length of 64 characters. Values are strings with
                #   a maximum length of 512 characters.
                #
                #   @return [Hash{Symbol=>String}, nil]
                optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

                # @!method initialize(chunking_strategy: nil, file_ids: nil, metadata: nil)
                #   @param chunking_strategy [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
                #   @param file_ids [Array<String>]
                #   @param metadata [Hash{Symbol=>String}, nil]

                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                # strategy.
                #
                # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore#chunking_strategy
                module ChunkingStrategy
                  extend OpenAI::Internal::Type::Union

                  discriminator :type

                  # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
                  variant :auto,
                          -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto }

                  variant :static,
                          -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static }

                  class Auto < OpenAI::Internal::Type::BaseModel
                    # @!attribute type
                    #   Always `auto`.
                    #
                    #   @return [Symbol, :auto]
                    required :type, const: :auto

                    # @!method initialize(type: :auto)
                    #   The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                    #   `800` and `chunk_overlap_tokens` of `400`.
                    #
                    #   @param type [Symbol, :auto]
                  end

                  class Static < OpenAI::Internal::Type::BaseModel
                    # @!attribute static
                    #
                    #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                    required :static,
                             -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static }

                    # @!attribute type
                    #   Always `static`.
                    #
                    #   @return [Symbol, :static]
                    required :type, const: :static

                    # @!method initialize(static:, type: :static)
                    #   @param static [OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                    #   @param type [Symbol, :static]

                    # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static#static
                    class Static < OpenAI::Internal::Type::BaseModel
                      # @!attribute chunk_overlap_tokens
                      #   The number of tokens that overlap between chunks. The default value is `400`.
                      #
                      #   Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                      #
                      #   @return [Integer]
                      required :chunk_overlap_tokens, Integer

                      # @!attribute max_chunk_size_tokens
                      #   The maximum number of tokens in each chunk. The default value is `800`. The
                      #   minimum value is `100` and the maximum value is `4096`.
                      #
                      #   @return [Integer]
                      required :max_chunk_size_tokens, Integer

                      # @!method initialize(chunk_overlap_tokens:, max_chunk_size_tokens:)
                      #   @param chunk_overlap_tokens [Integer]
                      #   @param max_chunk_size_tokens [Integer]
                    end
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static)]
                end
              end
            end
          end
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute code_interpreter
          #
          #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter,
                   -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter }

          # @!attribute file_search
          #
          #   @return [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch }

          # @!method initialize(code_interpreter: nil, file_search: nil)
          #   A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          #
          #   @param code_interpreter [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter]
          #   @param file_search [OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch]

          # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(file_ids: nil)
            #   @param file_ids [Array<String>]
          end

          # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute vector_store_ids
            #   The ID of the
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this assistant. There can be a maximum of 1 vector store attached to
            #   the assistant.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(vector_store_ids: nil)
            #   @param vector_store_ids [Array<String>]
          end
        end

        class TruncationStrategy < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The truncation strategy to use for the thread. The default is `auto`. If set to
          #   `last_messages`, the thread will be truncated to the n most recent messages in
          #   the thread. When set to `auto`, messages in the middle of the thread will be
          #   dropped to fit the context length of the model, `max_prompt_tokens`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type]
          required :type, enum: -> { OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type }

          # @!attribute last_messages
          #   The number of most recent messages from the thread when constructing the context
          #   for the run.
          #
          #   @return [Integer, nil]
          optional :last_messages, Integer, nil?: true

          # @!method initialize(type:, last_messages: nil)
          #   Controls for how a thread will be truncated prior to the run. Use this to
          #   control the intial context window of the run.
          #
          #   @param type [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type]
          #   @param last_messages [Integer, nil]

          # The truncation strategy to use for the thread. The default is `auto`. If set to
          # `last_messages`, the thread will be truncated to the n most recent messages in
          # the thread. When set to `auto`, messages in the middle of the thread will be
          # dropped to fit the context length of the model, `max_prompt_tokens`.
          #
          # @see OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy#type
          module Type
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            LAST_MESSAGES = :last_messages

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end

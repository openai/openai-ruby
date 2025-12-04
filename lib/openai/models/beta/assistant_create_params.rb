# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#create
      class AssistantCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute model
        #   ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        #
        #   @return [String, Symbol, OpenAI::Models::ChatModel]
        required :model, union: -> { OpenAI::Beta::AssistantCreateParams::Model }

        # @!attribute description
        #   The description of the assistant. The maximum length is 512 characters.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!attribute instructions
        #   The system instructions that the assistant uses. The maximum length is 256,000
        #   characters.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

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

        # @!attribute name
        #   The name of the assistant. The maximum length is 256 characters.
        #
        #   @return [String, nil]
        optional :name, String, nil?: true

        # @!attribute reasoning_effort
        #   Constrains effort on reasoning for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #   supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
        #   Reducing reasoning effort can result in faster responses and fewer tokens used
        #   on reasoning in a response.
        #
        #   - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
        #     reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
        #     calls are supported for all reasoning values in gpt-5.1.
        #   - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
        #     support `none`.
        #   - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
        #   - `xhigh` is currently only supported for `gpt-5.1-codex-max`.
        #
        #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
        optional :reasoning_effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

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
        optional :response_format, union: -> { OpenAI::Beta::AssistantResponseFormatOption }, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

        # @!attribute tool_resources
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Beta::AssistantCreateParams::ToolResources }, nil?: true

        # @!attribute tools
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #   `function`.
        #
        #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AssistantTool] }

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!method initialize(model:, description: nil, instructions: nil, metadata: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::AssistantCreateParams} for more details.
        #
        #   @param model [String, Symbol, OpenAI::Models::ChatModel] ID of the model to use. You can use the [List models](https://platform.openai.co
        #
        #   @param description [String, nil] The description of the assistant. The maximum length is 512 characters.
        #
        #   @param instructions [String, nil] The system instructions that the assistant uses. The maximum length is 256,000 c
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param name [String, nil] The name of the assistant. The maximum length is 256 characters.
        #
        #   @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] Constrains effort on reasoning for
        #
        #   @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
        #
        #   @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        #   @param tool_resources [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil] A set of resources that are used by the assistant's tools. The resources are spe
        #
        #   @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>] A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #
        #   @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them.
          variant enum: -> { OpenAI::ChatModel }

          # @!method self.variants
          #   @return [Array(String, Symbol, OpenAI::Models::ChatModel)]
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute code_interpreter
          #
          #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter, -> { OpenAI::Beta::AssistantCreateParams::ToolResources::CodeInterpreter }

          # @!attribute file_search
          #
          #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch }

          # @!method initialize(code_interpreter: nil, file_search: nil)
          #   A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          #
          #   @param code_interpreter [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter]
          #   @param file_search [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch]

          # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(file_ids: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter}
            #   for more details.
            #
            #   @param file_ids [Array<String>] A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
          end

          # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute vector_store_ids
            #   The
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this assistant. There can be a maximum of 1 vector store attached to
            #   the assistant.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute vector_stores
            #   A helper to create a
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   with file_ids and attach it to this assistant. There can be a maximum of 1
            #   vector store attached to the assistant.
            #
            #   @return [Array<OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore>, nil]
            optional :vector_stores,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore] }

            # @!method initialize(vector_store_ids: nil, vector_stores: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch} for
            #   more details.
            #
            #   @param vector_store_ids [Array<String>] The [vector store](https://platform.openai.com/docs/api-reference/vector-stores/
            #
            #   @param vector_stores [Array<OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore>] A helper to create a [vector store](https://platform.openai.com/docs/api-referen

            class VectorStore < OpenAI::Internal::Type::BaseModel
              # @!attribute chunking_strategy
              #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #   strategy.
              #
              #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static, nil]
              optional :chunking_strategy,
                       union: -> { OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy }

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
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore}
              #   for more details.
              #
              #   @param chunking_strategy [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static] The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #
              #   @param file_ids [Array<String>] A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to ad
              #
              #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
              #
              # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore#chunking_strategy
              module ChunkingStrategy
                extend OpenAI::Internal::Type::Union

                discriminator :type

                # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
                variant :auto,
                        -> { OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto }

                variant :static,
                        -> { OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static }

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
                  #   @param type [Symbol, :auto] Always `auto`.
                end

                class Static < OpenAI::Internal::Type::BaseModel
                  # @!attribute static
                  #
                  #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  required :static,
                           -> { OpenAI::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static }

                  # @!attribute type
                  #   Always `static`.
                  #
                  #   @return [Symbol, :static]
                  required :type, const: :static

                  # @!method initialize(static:, type: :static)
                  #   @param static [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  #
                  #   @param type [Symbol, :static] Always `static`.

                  # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static#static
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
                    #   Some parameter documentations has been truncated, see
                    #   {OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static}
                    #   for more details.
                    #
                    #   @param chunk_overlap_tokens [Integer] The number of tokens that overlap between chunks. The default value is `400`.
                    #
                    #   @param max_chunk_size_tokens [Integer] The maximum number of tokens in each chunk. The default value is `800`. The mini
                  end
                end

                # @!method self.variants
                #   @return [Array(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static)]
              end
            end
          end
        end
      end
    end
  end
end

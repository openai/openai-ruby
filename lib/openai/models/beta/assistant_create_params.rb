# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#create
      class AssistantCreateParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute model
        #   ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        #
        #   @return [String, Symbol, OpenAI::Models::ChatModel]
        required :model, union: -> { OpenAI::Models::Beta::AssistantCreateParams::Model }

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
        #   **o-series models only**
        #
        #   Constrains effort on reasoning for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #   result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
        optional :reasoning_effort, enum: -> { OpenAI::Models::ReasoningEffort }, nil?: true

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

        # @!attribute tool_resources
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources }, nil?: true

        # @!attribute [r] tools
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #   `function`.
        #
        #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::AssistantTool] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   attr_writer :tools

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!parse
        #   # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   # @param description [String, nil]
        #   # @param instructions [String, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param name [String, nil]
        #   # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   # @param temperature [Float, nil]
        #   # @param tool_resources [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil]
        #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   # @param top_p [Float, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(
        #     model:,
        #     description: nil,
        #     instructions: nil,
        #     metadata: nil,
        #     name: nil,
        #     reasoning_effort: nil,
        #     response_format: nil,
        #     temperature: nil,
        #     tool_resources: nil,
        #     tools: nil,
        #     top_p: nil,
        #     request_options: {},
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them.
          variant enum: -> { OpenAI::Models::ChatModel }

          # @!parse
          #   # @return [Array(String, Symbol, OpenAI::Models::ChatModel)]
          #   def self.variants; end
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] code_interpreter
          #
          #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter,
                   -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter }

          # @!parse
          #   # @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter]
          #   attr_writer :code_interpreter

          # @!attribute [r] file_search
          #
          #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch }

          # @!parse
          #   # @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch]
          #   attr_writer :file_search

          # @!parse
          #   # A set of resources that are used by the assistant's tools. The resources are
          #   # specific to the type of tool. For example, the `code_interpreter` tool requires
          #   # a list of file IDs, while the `file_search` tool requires a list of vector store
          #   # IDs.
          #   #
          #   # @param code_interpreter [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::CodeInterpreter]
          #   # @param file_search [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch]
          #   #
          #   def initialize(code_interpreter: nil, file_search: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :file_ids

            # @!parse
            #   # @param file_ids [Array<String>]
            #   #
            #   def initialize(file_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end

          # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] vector_store_ids
            #   The
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this assistant. There can be a maximum of 1 vector store attached to
            #   the assistant.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :vector_store_ids

            # @!attribute [r] vector_stores
            #   A helper to create a
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   with file_ids and attach it to this assistant. There can be a maximum of 1
            #   vector store attached to the assistant.
            #
            #   @return [Array<OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore>, nil]
            optional :vector_stores,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore>]
            #   attr_writer :vector_stores

            # @!parse
            #   # @param vector_store_ids [Array<String>]
            #   # @param vector_stores [Array<OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore>]
            #   #
            #   def initialize(vector_store_ids: nil, vector_stores: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            class VectorStore < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] chunking_strategy
              #   The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              #   strategy.
              #
              #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static, nil]
              optional :chunking_strategy,
                       union: -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy }

              # @!parse
              #   # @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
              #   attr_writer :chunking_strategy

              # @!attribute [r] file_ids
              #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
              #   add to the vector store. There can be a maximum of 10000 files in a vector
              #   store.
              #
              #   @return [Array<String>, nil]
              optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

              # @!parse
              #   # @return [Array<String>]
              #   attr_writer :file_ids

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

              # @!parse
              #   # @param chunking_strategy [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]
              #   # @param file_ids [Array<String>]
              #   # @param metadata [Hash{Symbol=>String}, nil]
              #   #
              #   def initialize(chunking_strategy: nil, file_ids: nil, metadata: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
              # strategy.
              #
              # @see OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore#chunking_strategy
              module ChunkingStrategy
                extend OpenAI::Internal::Type::Union

                discriminator :type

                # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
                variant :auto,
                        -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto }

                variant :static,
                        -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static }

                class Auto < OpenAI::Internal::Type::BaseModel
                  # @!attribute type
                  #   Always `auto`.
                  #
                  #   @return [Symbol, :auto]
                  required :type, const: :auto

                  # @!parse
                  #   # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                  #   # `800` and `chunk_overlap_tokens` of `400`.
                  #   #
                  #   # @param type [Symbol, :auto]
                  #   #
                  #   def initialize(type: :auto, **) = super

                  # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
                end

                class Static < OpenAI::Internal::Type::BaseModel
                  # @!attribute static
                  #
                  #   @return [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  required :static,
                           -> { OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static }

                  # @!attribute type
                  #   Always `static`.
                  #
                  #   @return [Symbol, :static]
                  required :type, const: :static

                  # @!parse
                  #   # @param static [OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static]
                  #   # @param type [Symbol, :static]
                  #   #
                  #   def initialize(static:, type: :static, **) = super

                  # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

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

                    # @!parse
                    #   # @param chunk_overlap_tokens [Integer]
                    #   # @param max_chunk_size_tokens [Integer]
                    #   #
                    #   def initialize(chunk_overlap_tokens:, max_chunk_size_tokens:, **) = super

                    # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
                  end
                end

                # @!parse
                #   # @return [Array(OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto, OpenAI::Models::Beta::AssistantCreateParams::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static)]
                #   def self.variants; end
              end
            end
          end
        end
      end
    end
  end
end

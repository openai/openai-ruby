# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#create
      class Assistant < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The identifier, which can be referenced in API endpoints.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the assistant was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute description
        #   The description of the assistant. The maximum length is 512 characters.
        #
        #   @return [String, nil]
        required :description, String, nil?: true

        # @!attribute instructions
        #   The system instructions that the assistant uses. The maximum length is 256,000
        #     characters.
        #
        #   @return [String, nil]
        required :instructions, String, nil?: true

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute model
        #   ID of the model to use. You can use the
        #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #     see all of your available models, or see our
        #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #     them.
        #
        #   @return [String]
        required :model, String

        # @!attribute name
        #   The name of the assistant. The maximum length is 256 characters.
        #
        #   @return [String, nil]
        required :name, String, nil?: true

        # @!attribute object
        #   The object type, which is always `assistant`.
        #
        #   @return [Symbol, :assistant]
        required :object, const: :assistant

        # @!attribute tools
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #     assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #     `function`.
        #
        #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        required :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::AssistantTool] }

        # @!attribute response_format
        #   Specifies the format that the model must output. Compatible with
        #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #     Outputs which ensures the model will match your supplied JSON schema. Learn more
        #     in the
        #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #     message the model generates is valid JSON.
        #
        #     **Important:** when using JSON mode, you **must** also instruct the model to
        #     produce JSON yourself via a system or user message. Without this, the model may
        #     generate an unending stream of whitespace until the generation reaches the token
        #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #     the message content may be partially cut off if `finish_reason="length"`, which
        #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #     max context length.
        #
        #   @return [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        optional :response_format, union: -> { OpenAI::Models::Beta::AssistantResponseFormatOption }, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

        # @!attribute tool_resources
        #   A set of resources that are used by the assistant's tools. The resources are
        #     specific to the type of tool. For example, the `code_interpreter` tool requires
        #     a list of file IDs, while the `file_search` tool requires a list of vector store
        #     IDs.
        #
        #   @return [OpenAI::Models::Beta::Assistant::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::Assistant::ToolResources }, nil?: true

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or temperature but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!parse
        #   # Represents an `assistant` that can call the model and use tools.
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param description [String, nil]
        #   # @param instructions [String, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param model [String]
        #   # @param name [String, nil]
        #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   # @param temperature [Float, nil]
        #   # @param tool_resources [OpenAI::Models::Beta::Assistant::ToolResources, nil]
        #   # @param top_p [Float, nil]
        #   # @param object [Symbol, :assistant]
        #   #
        #   def initialize(
        #     id:,
        #     created_at:,
        #     description:,
        #     instructions:,
        #     metadata:,
        #     model:,
        #     name:,
        #     tools:,
        #     response_format: nil,
        #     temperature: nil,
        #     tool_resources: nil,
        #     top_p: nil,
        #     object: :assistant,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # @see OpenAI::Models::Beta::Assistant#tool_resources
        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] code_interpreter
          #
          #   @return [OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter, -> { OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter]
          #   attr_writer :code_interpreter

          # @!attribute [r] file_search
          #
          #   @return [OpenAI::Models::Beta::Assistant::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::Assistant::ToolResources::FileSearch }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Assistant::ToolResources::FileSearch]
          #   attr_writer :file_search

          # @!parse
          #   # A set of resources that are used by the assistant's tools. The resources are
          #   #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   #   IDs.
          #   #
          #   # @param code_interpreter [OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter]
          #   # @param file_search [OpenAI::Models::Beta::Assistant::ToolResources::FileSearch]
          #   #
          #   def initialize(code_interpreter: nil, file_search: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::Assistant::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] file_ids
            #   A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #     available to the `code_interpreter`` tool. There can be a maximum of 20 files
            #     associated with the tool.
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

          # @see OpenAI::Models::Beta::Assistant::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] vector_store_ids
            #   The ID of the
            #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #     attached to this assistant. There can be a maximum of 1 vector store attached to
            #     the assistant.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :vector_store_ids

            # @!parse
            #   # @param vector_store_ids [Array<String>]
            #   #
            #   def initialize(vector_store_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end
      end
    end
  end
end

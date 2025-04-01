# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Assistants#update
      class AssistantUpdateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute description
        #   The description of the assistant. The maximum length is 512 characters.
        #
        #   @return [String, nil]
        optional :description, String, nil?: true

        # @!attribute instructions
        #   The system instructions that the assistant uses. The maximum length is 256,000
        #     characters.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

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

        # @!attribute [r] model
        #   ID of the model to use. You can use the
        #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #     see all of your available models, or see our
        #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #     them.
        #
        #   @return [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model, nil]
        optional :model, union: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model }

        # @!parse
        #   # @return [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model]
        #   attr_writer :model

        # @!attribute name
        #   The name of the assistant. The maximum length is 256 characters.
        #
        #   @return [String, nil]
        optional :name, String, nil?: true

        # @!attribute reasoning_effort
        #   **o-series models only**
        #
        #     Constrains effort on reasoning for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #     result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
        optional :reasoning_effort, enum: -> { OpenAI::Models::ReasoningEffort }, nil?: true

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
        #   @return [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Models::Beta::AssistantUpdateParams::ToolResources }, nil?: true

        # @!attribute [r] tools
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #     assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #     `function`.
        #
        #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>, nil]
        optional :tools, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::AssistantTool] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   attr_writer :tools

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
        #   # @param description [String, nil]
        #   # @param instructions [String, nil]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param model [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model]
        #   # @param name [String, nil]
        #   # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   # @param temperature [Float, nil]
        #   # @param tool_resources [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil]
        #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   # @param top_p [Float, nil]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(
        #     description: nil,
        #     instructions: nil,
        #     metadata: nil,
        #     model: nil,
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

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        module Model
          extend OpenAI::Union

          variant String

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::O3_MINI }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::O3_MINI_2025_01_31 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::O1 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::O1_2024_12_17 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O_2024_11_20 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O_2024_08_06 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O_2024_05_13 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O_MINI }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4O_MINI_2024_07_18 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_5_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_5_PREVIEW_2025_02_27 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_TURBO }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_TURBO_2024_04_09 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_0125_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_TURBO_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_1106_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_VISION_PREVIEW }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_0314 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_0613 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_32K }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_32K_0314 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_4_32K_0613 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO_16K }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO_0613 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO_1106 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO_0125 }

          variant const: -> { OpenAI::Models::Beta::AssistantUpdateParams::Model::GPT_3_5_TURBO_16K_0613 }

          # @!parse
          #   # @return [Array(String, Symbol)]
          #   def self.variants; end

          # @!group

          O3_MINI = :"o3-mini"
          O3_MINI_2025_01_31 = :"o3-mini-2025-01-31"
          O1 = :o1
          O1_2024_12_17 = :"o1-2024-12-17"
          GPT_4O = :"gpt-4o"
          GPT_4O_2024_11_20 = :"gpt-4o-2024-11-20"
          GPT_4O_2024_08_06 = :"gpt-4o-2024-08-06"
          GPT_4O_2024_05_13 = :"gpt-4o-2024-05-13"
          GPT_4O_MINI = :"gpt-4o-mini"
          GPT_4O_MINI_2024_07_18 = :"gpt-4o-mini-2024-07-18"
          GPT_4_5_PREVIEW = :"gpt-4.5-preview"
          GPT_4_5_PREVIEW_2025_02_27 = :"gpt-4.5-preview-2025-02-27"
          GPT_4_TURBO = :"gpt-4-turbo"
          GPT_4_TURBO_2024_04_09 = :"gpt-4-turbo-2024-04-09"
          GPT_4_0125_PREVIEW = :"gpt-4-0125-preview"
          GPT_4_TURBO_PREVIEW = :"gpt-4-turbo-preview"
          GPT_4_1106_PREVIEW = :"gpt-4-1106-preview"
          GPT_4_VISION_PREVIEW = :"gpt-4-vision-preview"
          GPT_4 = :"gpt-4"
          GPT_4_0314 = :"gpt-4-0314"
          GPT_4_0613 = :"gpt-4-0613"
          GPT_4_32K = :"gpt-4-32k"
          GPT_4_32K_0314 = :"gpt-4-32k-0314"
          GPT_4_32K_0613 = :"gpt-4-32k-0613"
          GPT_3_5_TURBO = :"gpt-3.5-turbo"
          GPT_3_5_TURBO_16K = :"gpt-3.5-turbo-16k"
          GPT_3_5_TURBO_0613 = :"gpt-3.5-turbo-0613"
          GPT_3_5_TURBO_1106 = :"gpt-3.5-turbo-1106"
          GPT_3_5_TURBO_0125 = :"gpt-3.5-turbo-0125"
          GPT_3_5_TURBO_16K_0613 = :"gpt-3.5-turbo-16k-0613"

          # @!endgroup
        end

        class ToolResources < OpenAI::BaseModel
          # @!attribute [r] code_interpreter
          #
          #   @return [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter,
                   -> { OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter }

          # @!parse
          #   # @return [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter]
          #   attr_writer :code_interpreter

          # @!attribute [r] file_search
          #
          #   @return [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch }

          # @!parse
          #   # @return [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch]
          #   attr_writer :file_search

          # @!parse
          #   # A set of resources that are used by the assistant's tools. The resources are
          #   #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   #   IDs.
          #   #
          #   # @param code_interpreter [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter]
          #   # @param file_search [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch]
          #   #
          #   def initialize(code_interpreter: nil, file_search: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # @see OpenAI::Models::Beta::AssistantUpdateParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::BaseModel
            # @!attribute [r] file_ids
            #   Overrides the list of
            #     [file](https://platform.openai.com/docs/api-reference/files) IDs made available
            #     to the `code_interpreter` tool. There can be a maximum of 20 files associated
            #     with the tool.
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

          # @see OpenAI::Models::Beta::AssistantUpdateParams::ToolResources#file_search
          class FileSearch < OpenAI::BaseModel
            # @!attribute [r] vector_store_ids
            #   Overrides the
            #     [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #     attached to this assistant. There can be a maximum of 1 vector store attached to
            #     the assistant.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::ArrayOf[String]

            # @!parse
            #   # @return [Array<String>]
            #   attr_writer :vector_store_ids

            # @!parse
            #   # @param vector_store_ids [Array<String>]
            #   #
            #   def initialize(vector_store_ids: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end

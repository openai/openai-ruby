# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#create
      #
      # @see OpenAI::Resources::Responses#stream_raw
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute input
        #   Text, image, or file inputs to the model, used to generate a response.
        #
        #   Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Image inputs](https://platform.openai.com/docs/guides/images)
        #   - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        #   - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        #   - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        #
        #   @return [String, Array<OpenAI::Responses::EasyInputMessage, OpenAI::Responses::ResponseInputItem::Message, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseInputItem::LocalShellCall, OpenAI::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Responses::ResponseInputItem::McpListTools, OpenAI::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Responses::ResponseInputItem::McpCall, OpenAI::Responses::ResponseInputItem::ItemReference>]
        required :input, union: -> { OpenAI::Responses::ResponseCreateParams::Input }

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        #
        #   @return [String, Symbol, OpenAI::ChatModel, OpenAI::ResponsesModel::ResponsesOnlyModel]
        required :model, union: -> { OpenAI::ResponsesModel }

        # @!attribute background
        #   Whether to run the model response in the background.
        #   [Learn more](https://platform.openai.com/docs/guides/background).
        #
        #   @return [Boolean, nil]
        optional :background, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute include
        #   Specify additional output data to include in the model response. Currently
        #   supported values are:
        #
        #   - `file_search_call.results`: Include the search results of the file search tool
        #     call.
        #   - `message.input_image.image_url`: Include image urls from the input message.
        #   - `computer_call_output.output.image_url`: Include image urls from the computer
        #     call output.
        #   - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #     tokens in reasoning item outputs. This enables reasoning items to be used in
        #     multi-turn conversations when using the Responses API statelessly (like when
        #     the `store` parameter is set to `false`, or when an organization is enrolled
        #     in the zero data retention program).
        #
        #   @return [Array<Symbol, OpenAI::Responses::ResponseIncludable>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] },
                 nil?: true

        # @!attribute instructions
        #   Inserts a system (or developer) message as the first item in the model's
        #   context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will not be carried over to the next response. This makes it simple to
        #   swap out system (or developer) messages in new responses.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute max_output_tokens
        #   An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [Integer, nil]
        optional :max_output_tokens, Integer, nil?: true

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

        # @!attribute parallel_tool_calls
        #   Whether to allow the model to run tool calls in parallel.
        #
        #   @return [Boolean, nil]
        optional :parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!attribute reasoning
        #   **o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        #
        #   @return [OpenAI::Reasoning, nil]
        optional :reasoning, -> { OpenAI::Reasoning }, nil?: true

        # @!attribute service_tier
        #   Specifies the latency tier to use for processing the request. This parameter is
        #   relevant for customers subscribed to the scale tier service:
        #
        #   - If set to 'auto', and the Project is Scale tier enabled, the system will
        #     utilize scale tier credits until they are exhausted.
        #   - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #     be processed using the default service tier with a lower uptime SLA and no
        #     latency guarentee.
        #   - If set to 'default', the request will be processed using the default service
        #     tier with a lower uptime SLA and no latency guarentee.
        #   - If set to 'flex', the request will be processed with the Flex Processing
        #     service tier.
        #     [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        #   - When not set, the default behavior is 'auto'.
        #
        #   When this parameter is set, the response body will include the `service_tier`
        #   utilized.
        #
        #   @return [Symbol, OpenAI::Responses::ResponseCreateParams::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Responses::ResponseCreateParams::ServiceTier }, nil?: true

        # @!attribute store
        #   Whether to store the generated model response for later retrieval via API.
        #
        #   @return [Boolean, nil]
        optional :store, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute temperature
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        #
        #   @return [Float, nil]
        optional :temperature, Float, nil?: true

        # @!attribute text
        #   Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        #
        #   @return [OpenAI::Responses::ResponseTextConfig, nil]
        optional :text, -> { OpenAI::Responses::ResponseTextConfig }

        # @!attribute tool_choice
        #   How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        #
        #   @return [Symbol, OpenAI::Responses::ToolChoiceOptions, OpenAI::Responses::ToolChoiceTypes, OpenAI::Responses::ToolChoiceFunction, nil]
        optional :tool_choice, union: -> { OpenAI::Responses::ResponseCreateParams::ToolChoice }

        # @!attribute tools
        #   An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   The two categories of tools you can provide the model are:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code. Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        #
        #   @return [Array<OpenAI::Responses::FunctionTool, OpenAI::Responses::FileSearchTool, OpenAI::Responses::ComputerTool, OpenAI::Responses::Tool::Mcp, OpenAI::Responses::Tool::CodeInterpreter, OpenAI::Responses::Tool::ImageGeneration, OpenAI::Responses::Tool::LocalShell, OpenAI::Responses::WebSearchTool>, nil]
        optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool] }

        # @!attribute top_p
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        #
        #   @return [Float, nil]
        optional :top_p, Float, nil?: true

        # @!attribute truncation
        #   The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        #
        #   @return [Symbol, OpenAI::Responses::ResponseCreateParams::Truncation, nil]
        optional :truncation, enum: -> { OpenAI::Responses::ResponseCreateParams::Truncation }, nil?: true

        # @!attribute user
        #   A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        #
        #   @return [String, nil]
        optional :user, String

        # @!method initialize(input:, model:, background: nil, include: nil, instructions: nil, max_output_tokens: nil, metadata: nil, parallel_tool_calls: nil, previous_response_id: nil, reasoning: nil, service_tier: nil, store: nil, temperature: nil, text: nil, tool_choice: nil, tools: nil, top_p: nil, truncation: nil, user: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCreateParams} for more details.
        #
        #   @param input [String, Array<OpenAI::Responses::EasyInputMessage, OpenAI::Responses::ResponseInputItem::Message, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseInputItem::LocalShellCall, OpenAI::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Responses::ResponseInputItem::McpListTools, OpenAI::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Responses::ResponseInputItem::McpCall, OpenAI::Responses::ResponseInputItem::ItemReference>] Text, image, or file inputs to the model, used to generate a response.
        #
        #   @param model [String, Symbol, OpenAI::ChatModel, OpenAI::ResponsesModel::ResponsesOnlyModel] Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
        #
        #   @param background [Boolean, nil] Whether to run the model response in the background.
        #
        #   @param include [Array<Symbol, OpenAI::Responses::ResponseIncludable>, nil] Specify additional output data to include in the model response. Currently
        #
        #   @param instructions [String, nil] Inserts a system (or developer) message as the first item in the model's context
        #
        #   @param max_output_tokens [Integer, nil] An upper bound for the number of tokens that can be generated for a response, in
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param parallel_tool_calls [Boolean, nil] Whether to allow the model to run tool calls in parallel.
        #
        #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to
        #
        #   @param reasoning [OpenAI::Reasoning, nil] **o-series models only**
        #
        #   @param service_tier [Symbol, OpenAI::Responses::ResponseCreateParams::ServiceTier, nil] Specifies the latency tier to use for processing the request. This parameter is
        #
        #   @param store [Boolean, nil] Whether to store the generated model response for later retrieval via
        #
        #   @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        #
        #   @param text [OpenAI::Responses::ResponseTextConfig] Configuration options for a text response from the model. Can be plain
        #
        #   @param tool_choice [Symbol, OpenAI::Responses::ToolChoiceOptions, OpenAI::Responses::ToolChoiceTypes, OpenAI::Responses::ToolChoiceFunction] How the model should select which tool (or tools) to use when generating
        #
        #   @param tools [Array<OpenAI::Responses::FunctionTool, OpenAI::Responses::FileSearchTool, OpenAI::Responses::ComputerTool, OpenAI::Responses::Tool::Mcp, OpenAI::Responses::Tool::CodeInterpreter, OpenAI::Responses::Tool::ImageGeneration, OpenAI::Responses::Tool::LocalShell, OpenAI::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
        #
        #   @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling,
        #
        #   @param truncation [Symbol, OpenAI::Responses::ResponseCreateParams::Truncation, nil] The truncation strategy to use for the model response.
        #
        #   @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        module Input
          extend OpenAI::Internal::Type::Union

          # A text input to the model, equivalent to a text input with the
          # `user` role.
          variant String

          # A list of one or many input items to the model, containing
          # different content types.
          variant -> { OpenAI::Responses::ResponseInput }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Responses::EasyInputMessage, OpenAI::Responses::ResponseInputItem::Message, OpenAI::Responses::ResponseOutputMessage, OpenAI::Responses::ResponseFileSearchToolCall, OpenAI::Responses::ResponseComputerToolCall, OpenAI::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Responses::ResponseFunctionWebSearch, OpenAI::Responses::ResponseFunctionToolCall, OpenAI::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Responses::ResponseReasoningItem, OpenAI::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Responses::ResponseCodeInterpreterToolCall, OpenAI::Responses::ResponseInputItem::LocalShellCall, OpenAI::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Responses::ResponseInputItem::McpListTools, OpenAI::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Responses::ResponseInputItem::McpCall, OpenAI::Responses::ResponseInputItem::ItemReference>)]
        end

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          # Controls which (if any) tool is called by the model.
          #
          # `none` means the model will not call any tool and instead generates a message.
          #
          # `auto` means the model can pick between generating a message or calling one or
          # more tools.
          #
          # `required` means the model must call one or more tools.
          variant enum: -> { OpenAI::Responses::ToolChoiceOptions }

          # Indicates that the model should use a built-in tool to generate a response.
          # [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
          variant -> { OpenAI::Responses::ToolChoiceTypes }

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Responses::ToolChoiceFunction }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Responses::ToolChoiceOptions, OpenAI::Responses::ToolChoiceTypes, OpenAI::Responses::ToolChoiceFunction)]
        end

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DISABLED = :disabled

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses#compact
      class ResponseCompactParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute model
        #   Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        #
        #   @return [Symbol, String, OpenAI::Models::Responses::ResponseCompactParams::Model, nil]
        required :model, union: -> { OpenAI::Responses::ResponseCompactParams::Model }, nil?: true

        # @!attribute input
        #   Text, image, or file inputs to the model, used to generate a response
        #
        #   @return [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil]
        optional :input, union: -> { OpenAI::Responses::ResponseCompactParams::Input }, nil?: true

        # @!attribute instructions
        #   A system (or developer) message inserted into the model's context. When used
        #   along with `previous_response_id`, the instructions from a previous response
        #   will not be carried over to the next response. This makes it simple to swap out
        #   system (or developer) messages in new responses.
        #
        #   @return [String, nil]
        optional :instructions, String, nil?: true

        # @!attribute previous_response_id
        #   The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        #   Cannot be used in conjunction with `conversation`.
        #
        #   @return [String, nil]
        optional :previous_response_id, String, nil?: true

        # @!method initialize(model:, input: nil, instructions: nil, previous_response_id: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCompactParams} for more details.
        #
        #   @param model [Symbol, String, OpenAI::Models::Responses::ResponseCompactParams::Model, nil] Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a wi
        #
        #   @param input [String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil] Text, image, or file inputs to the model, used to generate a response
        #
        #   @param instructions [String, nil] A system (or developer) message inserted into the model's context.
        #
        #   @param previous_response_id [String, nil] The unique ID of the previous response to the model. Use this to create multi-tu
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        module Model
          extend OpenAI::Internal::Type::Union

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2_2025_12_11 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2_PRO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2_PRO_2025_12_11 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1_2025_11_13 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1_CODEX }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_NANO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_2025_08_07 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_MINI_2025_08_07 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_NANO_2025_08_07 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_CHAT_LATEST }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1_NANO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1_2025_04_14 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1_MINI_2025_04_14 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1_NANO_2025_04_14 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O4_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O4_MINI_2025_04_16 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_2025_04_16 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_MINI_2025_01_31 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_2024_12_17 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_PREVIEW_2024_09_12 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_MINI_2024_09_12 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_2024_11_20 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_2024_08_06 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_2024_05_13 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_AUDIO_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_AUDIO_PREVIEW_2024_10_01 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_AUDIO_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_AUDIO_PREVIEW_2025_06_03 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI_AUDIO_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_SEARCH_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI_SEARCH_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_SEARCH_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::CHATGPT_4O_LATEST }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::CODEX_MINI_LATEST }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4O_MINI_2024_07_18 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_TURBO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_TURBO_2024_04_09 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_0125_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_TURBO_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_1106_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_VISION_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_0314 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_0613 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_32K }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_32K_0314 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_4_32K_0613 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_16K }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_0301 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_0613 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_1106 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_0125 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_3_5_TURBO_16K_0613 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_PRO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O1_PRO_2025_03_19 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_PRO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_PRO_2025_06_10 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_DEEP_RESEARCH }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O3_DEEP_RESEARCH_2025_06_26 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O4_MINI_DEEP_RESEARCH }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::O4_MINI_DEEP_RESEARCH_2025_06_26 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::COMPUTER_USE_PREVIEW }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::COMPUTER_USE_PREVIEW_2025_03_11 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_CODEX }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_PRO }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_PRO_2025_10_06 }

          variant const: -> { OpenAI::Models::Responses::ResponseCompactParams::Model::GPT_5_1_CODEX_MAX }

          variant String

          # @!method self.variants
          #   @return [Array(Symbol, String)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol, String) }
          end

          # @!group

          GPT_5_2 = :"gpt-5.2"
          GPT_5_2_2025_12_11 = :"gpt-5.2-2025-12-11"
          GPT_5_2_CHAT_LATEST = :"gpt-5.2-chat-latest"
          GPT_5_2_PRO = :"gpt-5.2-pro"
          GPT_5_2_PRO_2025_12_11 = :"gpt-5.2-pro-2025-12-11"
          GPT_5_1 = :"gpt-5.1"
          GPT_5_1_2025_11_13 = :"gpt-5.1-2025-11-13"
          GPT_5_1_CODEX = :"gpt-5.1-codex"
          GPT_5_1_MINI = :"gpt-5.1-mini"
          GPT_5_1_CHAT_LATEST = :"gpt-5.1-chat-latest"
          GPT_5 = :"gpt-5"
          GPT_5_MINI = :"gpt-5-mini"
          GPT_5_NANO = :"gpt-5-nano"
          GPT_5_2025_08_07 = :"gpt-5-2025-08-07"
          GPT_5_MINI_2025_08_07 = :"gpt-5-mini-2025-08-07"
          GPT_5_NANO_2025_08_07 = :"gpt-5-nano-2025-08-07"
          GPT_5_CHAT_LATEST = :"gpt-5-chat-latest"
          GPT_4_1 = :"gpt-4.1"
          GPT_4_1_MINI = :"gpt-4.1-mini"
          GPT_4_1_NANO = :"gpt-4.1-nano"
          GPT_4_1_2025_04_14 = :"gpt-4.1-2025-04-14"
          GPT_4_1_MINI_2025_04_14 = :"gpt-4.1-mini-2025-04-14"
          GPT_4_1_NANO_2025_04_14 = :"gpt-4.1-nano-2025-04-14"
          O4_MINI = :"o4-mini"
          O4_MINI_2025_04_16 = :"o4-mini-2025-04-16"
          O3 = :o3
          O3_2025_04_16 = :"o3-2025-04-16"
          O3_MINI = :"o3-mini"
          O3_MINI_2025_01_31 = :"o3-mini-2025-01-31"
          O1 = :o1
          O1_2024_12_17 = :"o1-2024-12-17"
          O1_PREVIEW = :"o1-preview"
          O1_PREVIEW_2024_09_12 = :"o1-preview-2024-09-12"
          O1_MINI = :"o1-mini"
          O1_MINI_2024_09_12 = :"o1-mini-2024-09-12"
          GPT_4O = :"gpt-4o"
          GPT_4O_2024_11_20 = :"gpt-4o-2024-11-20"
          GPT_4O_2024_08_06 = :"gpt-4o-2024-08-06"
          GPT_4O_2024_05_13 = :"gpt-4o-2024-05-13"
          GPT_4O_AUDIO_PREVIEW = :"gpt-4o-audio-preview"
          GPT_4O_AUDIO_PREVIEW_2024_10_01 = :"gpt-4o-audio-preview-2024-10-01"
          GPT_4O_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-audio-preview-2024-12-17"
          GPT_4O_AUDIO_PREVIEW_2025_06_03 = :"gpt-4o-audio-preview-2025-06-03"
          GPT_4O_MINI_AUDIO_PREVIEW = :"gpt-4o-mini-audio-preview"
          GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-mini-audio-preview-2024-12-17"
          GPT_4O_SEARCH_PREVIEW = :"gpt-4o-search-preview"
          GPT_4O_MINI_SEARCH_PREVIEW = :"gpt-4o-mini-search-preview"
          GPT_4O_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-search-preview-2025-03-11"
          GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-mini-search-preview-2025-03-11"
          CHATGPT_4O_LATEST = :"chatgpt-4o-latest"
          CODEX_MINI_LATEST = :"codex-mini-latest"
          GPT_4O_MINI = :"gpt-4o-mini"
          GPT_4O_MINI_2024_07_18 = :"gpt-4o-mini-2024-07-18"
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
          GPT_3_5_TURBO_0301 = :"gpt-3.5-turbo-0301"
          GPT_3_5_TURBO_0613 = :"gpt-3.5-turbo-0613"
          GPT_3_5_TURBO_1106 = :"gpt-3.5-turbo-1106"
          GPT_3_5_TURBO_0125 = :"gpt-3.5-turbo-0125"
          GPT_3_5_TURBO_16K_0613 = :"gpt-3.5-turbo-16k-0613"
          O1_PRO = :"o1-pro"
          O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
          O3_PRO = :"o3-pro"
          O3_PRO_2025_06_10 = :"o3-pro-2025-06-10"
          O3_DEEP_RESEARCH = :"o3-deep-research"
          O3_DEEP_RESEARCH_2025_06_26 = :"o3-deep-research-2025-06-26"
          O4_MINI_DEEP_RESEARCH = :"o4-mini-deep-research"
          O4_MINI_DEEP_RESEARCH_2025_06_26 = :"o4-mini-deep-research-2025-06-26"
          COMPUTER_USE_PREVIEW = :"computer-use-preview"
          COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"
          GPT_5_CODEX = :"gpt-5-codex"
          GPT_5_PRO = :"gpt-5-pro"
          GPT_5_PRO_2025_10_06 = :"gpt-5-pro-2025-10-06"
          GPT_5_1_CODEX_MAX = :"gpt-5.1-codex-max"

          # @!endgroup
        end

        # Text, image, or file inputs to the model, used to generate a response
        module Input
          extend OpenAI::Internal::Type::Union

          # A text input to the model, equivalent to a text input with the `user` role.
          variant String

          # A list of one or many input items to the model, containing different content types.
          variant -> { OpenAI::Models::Responses::ResponseCompactParams::Input::ResponseInputItemArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>)]

          # @type [OpenAI::Internal::Type::Converter]
          ResponseInputItemArray =
            OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ResponseInputItem }]
        end
      end
    end
  end
end

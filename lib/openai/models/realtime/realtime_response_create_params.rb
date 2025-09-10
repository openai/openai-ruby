# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseCreateParams < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Configuration for audio input and output.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeResponseCreateAudioOutput }

        # @!attribute conversation
        #   Controls which conversation the response is added to. Currently supports `auto`
        #   and `none`, with `auto` as the default value. The `auto` value means that the
        #   contents of the response will be added to the default conversation. Set this to
        #   `none` to create an out-of-band response which will not add items to default
        #   conversation.
        #
        #   @return [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateParams::Conversation, nil]
        optional :conversation, union: -> { OpenAI::Realtime::RealtimeResponseCreateParams::Conversation }

        # @!attribute input
        #   Input items to include in the prompt for the model. Using this field creates a
        #   new context for this Response instead of using the default conversation. An
        #   empty array `[]` will clear the context for this Response. Note that this can
        #   include references to items that previously appeared in the session using their
        #   id.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest>, nil]
        optional :input, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Realtime::ConversationItem] }

        # @!attribute instructions
        #   The default system instructions (i.e. system message) prepended to model calls.
        #   This field allows the client to guide the model on desired responses. The model
        #   can be instructed on response content and format, (e.g. "be extremely succinct",
        #   "act friendly", "here are examples of good responses") and on audio behavior
        #   (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
        #   instructions are not guaranteed to be followed by the model, but they provide
        #   guidance to the model on the desired behavior. Note that the server sets default
        #   instructions which will be used if this field is not set and are visible in the
        #   `session.created` event at the start of the session.
        #
        #   @return [String, nil]
        optional :instructions, String

        # @!attribute max_output_tokens
        #   Maximum number of output tokens for a single assistant response, inclusive of
        #   tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        #   `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        #   @return [Integer, Symbol, :inf, nil]
        optional :max_output_tokens, union: -> { OpenAI::Realtime::RealtimeResponseCreateParams::MaxOutputTokens }

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

        # @!attribute output_modalities
        #   The set of modalities the model used to respond, currently the only possible
        #   values are `[\"audio\"]`, `[\"text\"]`. Audio output always include a text
        #   transcript. Setting the output to mode `text` will disable audio output from the
        #   model.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateParams::OutputModality>, nil]
        optional :output_modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality] }

        # @!attribute prompt
        #   Reference to a prompt template and its variables.
        #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        #
        #   @return [OpenAI::Models::Responses::ResponsePrompt, nil]
        optional :prompt, -> { OpenAI::Responses::ResponsePrompt }, nil?: true

        # @!attribute tool_choice
        #   How the model chooses tools. Provide one of the string modes or force a specific
        #   function/MCP tool.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, nil]
        optional :tool_choice, union: -> { OpenAI::Realtime::RealtimeResponseCreateParams::ToolChoice }

        # @!attribute tools
        #   Tools available to the model.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeResponseCreateMcpTool>, nil]
        optional :tools,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Realtime::RealtimeResponseCreateParams::Tool] }

        # @!method initialize(audio: nil, conversation: nil, input: nil, instructions: nil, max_output_tokens: nil, metadata: nil, output_modalities: nil, prompt: nil, tool_choice: nil, tools: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeResponseCreateParams} for more details.
        #
        #   Create a new Realtime response with these parameters
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeResponseCreateAudioOutput] Configuration for audio input and output.
        #
        #   @param conversation [String, Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateParams::Conversation] Controls which conversation the response is added to. Currently supports
        #
        #   @param input [Array<OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest>] Input items to include in the prompt for the model. Using this field
        #
        #   @param instructions [String] The default system instructions (i.e. system message) prepended to model calls.
        #
        #   @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param output_modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeResponseCreateParams::OutputModality>] The set of modalities the model used to respond, currently the only possible val
        #
        #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
        #
        #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeResponseCreateMcpTool>] Tools available to the model.

        # Controls which conversation the response is added to. Currently supports `auto`
        # and `none`, with `auto` as the default value. The `auto` value means that the
        # contents of the response will be added to the default conversation. Set this to
        # `none` to create an out-of-band response which will not add items to default
        # conversation.
        #
        # @see OpenAI::Models::Realtime::RealtimeResponseCreateParams#conversation
        module Conversation
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateParams::Conversation::AUTO }

          variant const: -> { OpenAI::Models::Realtime::RealtimeResponseCreateParams::Conversation::NONE }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::TaggedSymbol) }
          end

          # @!group

          AUTO = :auto
          NONE = :none

          # @!endgroup
        end

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        #
        # @see OpenAI::Models::Realtime::RealtimeResponseCreateParams#max_output_tokens
        module MaxOutputTokens
          extend OpenAI::Internal::Type::Union

          variant Integer

          variant const: :inf

          # @!method self.variants
          #   @return [Array(Integer, Symbol, :inf)]
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # How the model chooses tools. Provide one of the string modes or force a specific
        # function/MCP tool.
        #
        # @see OpenAI::Models::Realtime::RealtimeResponseCreateParams#tool_choice
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

          # Use this option to force the model to call a specific function.
          variant -> { OpenAI::Responses::ToolChoiceFunction }

          # Use this option to force the model to call a specific tool on a remote MCP server.
          variant -> { OpenAI::Responses::ToolChoiceMcp }

          # @!method self.variants
          #   @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp)]
        end

        # Give the model access to additional tools via remote Model Context Protocol
        # (MCP) servers.
        # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
        module Tool
          extend OpenAI::Internal::Type::Union

          variant -> { OpenAI::Realtime::RealtimeFunctionTool }

          # Give the model access to additional tools via remote Model Context Protocol
          # (MCP) servers. [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          variant -> { OpenAI::Realtime::RealtimeResponseCreateMcpTool }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeFunctionTool, OpenAI::Models::Realtime::RealtimeResponseCreateMcpTool)]
        end
      end
    end
  end
end

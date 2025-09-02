# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `response.create`.
        #
        #   @return [Symbol, :"response.create"]
        required :type, const: :"response.create"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!attribute response
        #   Create a new Realtime response with these parameters
        #
        #   @return [OpenAI::Models::Realtime::ResponseCreateEvent::Response, nil]
        optional :response, -> { OpenAI::Realtime::ResponseCreateEvent::Response }

        # @!method initialize(event_id: nil, response: nil, type: :"response.create")
        #   This event instructs the server to create a Response, which means triggering
        #   model inference. When in Server VAD mode, the server will create Responses
        #   automatically.
        #
        #   A Response will include at least one Item, and may have two, in which case the
        #   second will be a function call. These Items will be appended to the conversation
        #   history.
        #
        #   The server will respond with a `response.created` event, events for Items and
        #   content created, and finally a `response.done` event to indicate the Response is
        #   complete.
        #
        #   The `response.create` event includes inference configuration like
        #   `instructions`, and `temperature`. These fields will override the Session's
        #   configuration for this Response only.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param response [OpenAI::Models::Realtime::ResponseCreateEvent::Response] Create a new Realtime response with these parameters
        #
        #   @param type [Symbol, :"response.create"] The event type, must be `response.create`.

        # @see OpenAI::Models::Realtime::ResponseCreateEvent#response
        class Response < OpenAI::Internal::Type::BaseModel
          # @!attribute conversation
          #   Controls which conversation the response is added to. Currently supports `auto`
          #   and `none`, with `auto` as the default value. The `auto` value means that the
          #   contents of the response will be added to the default conversation. Set this to
          #   `none` to create an out-of-band response which will not add items to default
          #   conversation.
          #
          #   @return [String, Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Conversation, nil]
          optional :conversation, union: -> { OpenAI::Realtime::ResponseCreateEvent::Response::Conversation }

          # @!attribute input
          #   Input items to include in the prompt for the model. Using this field creates a
          #   new context for this Response instead of using the default conversation. An
          #   empty array `[]` will clear the context for this Response. Note that this can
          #   include references to items from the default conversation.
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
          #   guidance to the model on the desired behavior.
          #
          #   Note that the server sets default instructions which will be used if this field
          #   is not set and are visible in the `session.created` event at the start of the
          #   session.
          #
          #   @return [String, nil]
          optional :instructions, String

          # @!attribute max_output_tokens
          #   Maximum number of output tokens for a single assistant response, inclusive of
          #   tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
          #   `inf` for the maximum available tokens for a given model. Defaults to `inf`.
          #
          #   @return [Integer, Symbol, :inf, nil]
          optional :max_output_tokens,
                   union: -> { OpenAI::Realtime::ResponseCreateEvent::Response::MaxOutputTokens }

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

          # @!attribute modalities
          #   The set of modalities the model can respond with. To disable audio, set this to
          #   ["text"].
          #
          #   @return [Array<Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Modality>, nil]
          optional :modalities,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::ResponseCreateEvent::Response::Modality] }

          # @!attribute output_audio_format
          #   The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::OutputAudioFormat, nil]
          optional :output_audio_format,
                   enum: -> { OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat }

          # @!attribute prompt
          #   Reference to a prompt template and its variables.
          #   [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          #
          #   @return [OpenAI::Models::Responses::ResponsePrompt, nil]
          optional :prompt, -> { OpenAI::Responses::ResponsePrompt }, nil?: true

          # @!attribute temperature
          #   Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8.
          #
          #   @return [Float, nil]
          optional :temperature, Float

          # @!attribute tool_choice
          #   How the model chooses tools. Provide one of the string modes or force a specific
          #   function/MCP tool.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp, nil]
          optional :tool_choice, union: -> { OpenAI::Realtime::ResponseCreateEvent::Response::ToolChoice }

          # @!attribute tools
          #   Tools (functions) available to the model.
          #
          #   @return [Array<OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool>, nil]
          optional :tools,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::ResponseCreateEvent::Response::Tool] }

          # @!attribute voice
          #   The voice the model uses to respond. Voice cannot be changed during the session
          #   once the model has responded with audio at least once. Current voice options are
          #   `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
          #
          #   @return [String, Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice, nil]
          optional :voice, union: -> { OpenAI::Realtime::ResponseCreateEvent::Response::Voice }

          # @!method initialize(conversation: nil, input: nil, instructions: nil, max_output_tokens: nil, metadata: nil, modalities: nil, output_audio_format: nil, prompt: nil, temperature: nil, tool_choice: nil, tools: nil, voice: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::ResponseCreateEvent::Response} for more details.
          #
          #   Create a new Realtime response with these parameters
          #
          #   @param conversation [String, Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Conversation] Controls which conversation the response is added to. Currently supports
          #
          #   @param input [Array<OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest>] Input items to include in the prompt for the model. Using this field
          #
          #   @param instructions [String] The default system instructions (i.e. system message) prepended to model
          #
          #   @param max_output_tokens [Integer, Symbol, :inf] Maximum number of output tokens for a single assistant response,
          #
          #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param modalities [Array<Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Modality>] The set of modalities the model can respond with. To disable audio,
          #
          #   @param output_audio_format [Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::OutputAudioFormat] The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @param prompt [OpenAI::Models::Responses::ResponsePrompt, nil] Reference to a prompt template and its variables.
          #
          #   @param temperature [Float] Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8.
          #
          #   @param tool_choice [Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp] How the model chooses tools. Provide one of the string modes or force a specific
          #
          #   @param tools [Array<OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool>] Tools (functions) available to the model.
          #
          #   @param voice [String, Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice] The voice the model uses to respond. Voice cannot be changed during the

          # Controls which conversation the response is added to. Currently supports `auto`
          # and `none`, with `auto` as the default value. The `auto` value means that the
          # contents of the response will be added to the default conversation. Set this to
          # `none` to create an out-of-band response which will not add items to default
          # conversation.
          #
          # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response#conversation
          module Conversation
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Conversation::AUTO }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Conversation::NONE }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::TaggedSymbol) }
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
          # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response#max_output_tokens
          module MaxOutputTokens
            extend OpenAI::Internal::Type::Union

            variant Integer

            variant const: :inf

            # @!method self.variants
            #   @return [Array(Integer, Symbol, :inf)]
          end

          module Modality
            extend OpenAI::Internal::Type::Enum

            TEXT = :text
            AUDIO = :audio

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response#output_audio_format
          module OutputAudioFormat
            extend OpenAI::Internal::Type::Enum

            PCM16 = :pcm16
            G711_ULAW = :g711_ulaw
            G711_ALAW = :g711_alaw

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # How the model chooses tools. Provide one of the string modes or force a specific
          # function/MCP tool.
          #
          # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response#tool_choice
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

          class Tool < OpenAI::Internal::Type::BaseModel
            # @!attribute description
            #   The description of the function, including guidance on when and how to call it,
            #   and guidance about what to tell the user when calling (if anything).
            #
            #   @return [String, nil]
            optional :description, String

            # @!attribute name
            #   The name of the function.
            #
            #   @return [String, nil]
            optional :name, String

            # @!attribute parameters
            #   Parameters of the function in JSON Schema.
            #
            #   @return [Object, nil]
            optional :parameters, OpenAI::Internal::Type::Unknown

            # @!attribute type
            #   The type of the tool, i.e. `function`.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool::Type, nil]
            optional :type, enum: -> { OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type }

            # @!method initialize(description: nil, name: nil, parameters: nil, type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool} for more
            #   details.
            #
            #   @param description [String] The description of the function, including guidance on when and how
            #
            #   @param name [String] The name of the function.
            #
            #   @param parameters [Object] Parameters of the function in JSON Schema.
            #
            #   @param type [Symbol, OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool::Type] The type of the tool, i.e. `function`.

            # The type of the tool, i.e. `function`.
            #
            # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response::Tool#type
            module Type
              extend OpenAI::Internal::Type::Enum

              FUNCTION = :function

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
          #
          # @see OpenAI::Models::Realtime::ResponseCreateEvent::Response#voice
          module Voice
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::ALLOY }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::ASH }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::BALLAD }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::CORAL }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::ECHO }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::SAGE }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::SHIMMER }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::VERSE }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::MARIN }

            variant const: -> { OpenAI::Models::Realtime::ResponseCreateEvent::Response::Voice::CEDAR }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol) }
            end

            # @!group

            ALLOY = :alloy
            ASH = :ash
            BALLAD = :ballad
            CORAL = :coral
            ECHO = :echo
            SAGE = :sage
            SHIMMER = :shimmer
            VERSE = :verse
            MARIN = :marin
            CEDAR = :cedar

            # @!endgroup
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseCreateParams < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Configuration for audio input and output.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeResponseCreateAudioOutput)
          )
        end
        attr_reader :audio

        sig do
          params(
            audio: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::OrHash
          ).void
        end
        attr_writer :audio

        # Controls which conversation the response is added to. Currently supports `auto`
        # and `none`, with `auto` as the default value. The `auto` value means that the
        # contents of the response will be added to the default conversation. Set this to
        # `none` to create an out-of-band response which will not add items to default
        # conversation.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::OrSymbol
              )
            )
          )
        end
        attr_reader :conversation

        sig do
          params(
            conversation:
              T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::OrSymbol
              )
          ).void
        end
        attr_writer :conversation

        # Input items to include in the prompt for the model. Using this field creates a
        # new context for this Response instead of using the default conversation. An
        # empty array `[]` will clear the context for this Response. Note that this can
        # include references to items that previously appeared in the session using their
        # id.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage,
                  OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCall,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
                  OpenAI::Realtime::RealtimeMcpApprovalResponse,
                  OpenAI::Realtime::RealtimeMcpListTools,
                  OpenAI::Realtime::RealtimeMcpToolCall,
                  OpenAI::Realtime::RealtimeMcpApprovalRequest
                )
              ]
            )
          )
        end
        attr_reader :input

        sig do
          params(
            input:
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemAssistantMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCall::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalResponse::OrHash,
                  OpenAI::Realtime::RealtimeMcpListTools::OrHash,
                  OpenAI::Realtime::RealtimeMcpToolCall::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalRequest::OrHash
                )
              ]
          ).void
        end
        attr_writer :input

        # The default system instructions (i.e. system message) prepended to model calls.
        # This field allows the client to guide the model on desired responses. The model
        # can be instructed on response content and format, (e.g. "be extremely succinct",
        # "act friendly", "here are examples of good responses") and on audio behavior
        # (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
        # instructions are not guaranteed to be followed by the model, but they provide
        # guidance to the model on the desired behavior. Note that the server sets default
        # instructions which will be used if this field is not set and are visible in the
        # `session.created` event at the start of the session.
        sig { returns(T.nilable(String)) }
        attr_reader :instructions

        sig { params(instructions: String).void }
        attr_writer :instructions

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        sig { returns(T.nilable(T.any(Integer, Symbol))) }
        attr_reader :max_output_tokens

        sig { params(max_output_tokens: T.any(Integer, Symbol)).void }
        attr_writer :max_output_tokens

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The set of modalities the model used to respond, currently the only possible
        # values are `[\"audio\"]`, `[\"text\"]`. Audio output always include a text
        # transcript. Setting the output to mode `text` will disable audio output from the
        # model.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::OrSymbol
              ]
            )
          )
        end
        attr_reader :output_modalities

        sig do
          params(
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::OrSymbol
              ]
          ).void
        end
        attr_writer :output_modalities

        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        sig { returns(T.nilable(OpenAI::Responses::ResponsePrompt)) }
        attr_reader :prompt

        sig do
          params(
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash)
          ).void
        end
        attr_writer :prompt

        # How the model chooses tools. Provide one of the string modes or force a specific
        # function/MCP tool.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp
              )
            )
          )
        end
        attr_reader :tool_choice

        sig do
          params(
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash
              )
          ).void
        end
        attr_writer :tool_choice

        # Tools available to the model.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeFunctionTool,
                  OpenAI::Realtime::RealtimeResponseCreateMcpTool
                )
              ]
            )
          )
        end
        attr_reader :tools

        sig do
          params(
            tools:
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeFunctionTool::OrHash,
                  OpenAI::Realtime::RealtimeResponseCreateMcpTool::OrHash
                )
              ]
          ).void
        end
        attr_writer :tools

        # Create a new Realtime response with these parameters
        sig do
          params(
            audio: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::OrHash,
            conversation:
              T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::OrSymbol
              ),
            input:
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemAssistantMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCall::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalResponse::OrHash,
                  OpenAI::Realtime::RealtimeMcpListTools::OrHash,
                  OpenAI::Realtime::RealtimeMcpToolCall::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalRequest::OrHash
                )
              ],
            instructions: String,
            max_output_tokens: T.any(Integer, Symbol),
            metadata: T.nilable(T::Hash[Symbol, String]),
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::OrSymbol
              ],
            prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Realtime::RealtimeFunctionTool::OrHash,
                  OpenAI::Realtime::RealtimeResponseCreateMcpTool::OrHash
                )
              ]
          ).returns(T.attached_class)
        end
        def self.new(
          # Configuration for audio input and output.
          audio: nil,
          # Controls which conversation the response is added to. Currently supports `auto`
          # and `none`, with `auto` as the default value. The `auto` value means that the
          # contents of the response will be added to the default conversation. Set this to
          # `none` to create an out-of-band response which will not add items to default
          # conversation.
          conversation: nil,
          # Input items to include in the prompt for the model. Using this field creates a
          # new context for this Response instead of using the default conversation. An
          # empty array `[]` will clear the context for this Response. Note that this can
          # include references to items that previously appeared in the session using their
          # id.
          input: nil,
          # The default system instructions (i.e. system message) prepended to model calls.
          # This field allows the client to guide the model on desired responses. The model
          # can be instructed on response content and format, (e.g. "be extremely succinct",
          # "act friendly", "here are examples of good responses") and on audio behavior
          # (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
          # instructions are not guaranteed to be followed by the model, but they provide
          # guidance to the model on the desired behavior. Note that the server sets default
          # instructions which will be used if this field is not set and are visible in the
          # `session.created` event at the start of the session.
          instructions: nil,
          # Maximum number of output tokens for a single assistant response, inclusive of
          # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
          # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
          max_output_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The set of modalities the model used to respond, currently the only possible
          # values are `[\"audio\"]`, `[\"text\"]`. Audio output always include a text
          # transcript. Setting the output to mode `text` will disable audio output from the
          # model.
          output_modalities: nil,
          # Reference to a prompt template and its variables.
          # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          prompt: nil,
          # How the model chooses tools. Provide one of the string modes or force a specific
          # function/MCP tool.
          tool_choice: nil,
          # Tools available to the model.
          tools: nil
        )
        end

        sig do
          override.returns(
            {
              audio: OpenAI::Realtime::RealtimeResponseCreateAudioOutput,
              conversation:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::OrSymbol
                ),
              input:
                T::Array[
                  T.any(
                    OpenAI::Realtime::RealtimeConversationItemSystemMessage,
                    OpenAI::Realtime::RealtimeConversationItemUserMessage,
                    OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCall,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
                    OpenAI::Realtime::RealtimeMcpApprovalResponse,
                    OpenAI::Realtime::RealtimeMcpListTools,
                    OpenAI::Realtime::RealtimeMcpToolCall,
                    OpenAI::Realtime::RealtimeMcpApprovalRequest
                  )
                ],
              instructions: String,
              max_output_tokens: T.any(Integer, Symbol),
              metadata: T.nilable(T::Hash[Symbol, String]),
              output_modalities:
                T::Array[
                  OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::OrSymbol
                ],
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt),
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceFunction,
                  OpenAI::Responses::ToolChoiceMcp
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Realtime::RealtimeFunctionTool,
                    OpenAI::Realtime::RealtimeResponseCreateMcpTool
                  )
                ]
            }
          )
        end
        def to_hash
        end

        # Controls which conversation the response is added to. Currently supports `auto`
        # and `none`, with `auto` as the default value. The `auto` value means that the
        # contents of the response will be added to the default conversation. Set this to
        # `none` to create an out-of-band response which will not add items to default
        # conversation.
        module Conversation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeResponseCreateParams::Conversation
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::TaggedSymbol
            )
          NONE =
            T.let(
              :none,
              OpenAI::Realtime::RealtimeResponseCreateParams::Conversation::TaggedSymbol
            )
        end

        # Maximum number of output tokens for a single assistant response, inclusive of
        # tool calls. Provide an integer between 1 and 4096 to limit output tokens, or
        # `inf` for the maximum available tokens for a given model. Defaults to `inf`.
        module MaxOutputTokens
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(Integer, Symbol) }

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::MaxOutputTokens::Variants
              ]
            )
          end
          def self.variants
          end
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::TaggedSymbol
            )
          AUDIO =
            T.let(
              :audio,
              OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::OutputModality::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # How the model chooses tools. Provide one of the string modes or force a specific
        # function/MCP tool.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ToolChoiceOptions::TaggedSymbol,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::ToolChoice::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Give the model access to additional tools via remote Model Context Protocol
        # (MCP) servers.
        # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
        module Tool
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeFunctionTool,
                OpenAI::Realtime::RealtimeResponseCreateMcpTool
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeResponseCreateParams::Tool::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end

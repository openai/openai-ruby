# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseCreateEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseCreateEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `response.create`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Create a new Realtime response with these parameters
        sig do
          returns(T.nilable(OpenAI::Realtime::ResponseCreateEvent::Response))
        end
        attr_reader :response

        sig do
          params(
            response: OpenAI::Realtime::ResponseCreateEvent::Response::OrHash
          ).void
        end
        attr_writer :response

        # This event instructs the server to create a Response, which means triggering
        # model inference. When in Server VAD mode, the server will create Responses
        # automatically.
        #
        # A Response will include at least one Item, and may have two, in which case the
        # second will be a function call. These Items will be appended to the conversation
        # history.
        #
        # The server will respond with a `response.created` event, events for Items and
        # content created, and finally a `response.done` event to indicate the Response is
        # complete.
        #
        # The `response.create` event includes inference configuration like
        # `instructions`, and `temperature`. These fields will override the Session's
        # configuration for this Response only.
        sig do
          params(
            event_id: String,
            response: OpenAI::Realtime::ResponseCreateEvent::Response::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # Create a new Realtime response with these parameters
          response: nil,
          # The event type, must be `response.create`.
          type: :"response.create"
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              event_id: String,
              response: OpenAI::Realtime::ResponseCreateEvent::Response
            }
          )
        end
        def to_hash
        end

        class Response < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ResponseCreateEvent::Response,
                OpenAI::Internal::AnyHash
              )
            end

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
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::OrSymbol
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
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::OrSymbol
                )
            ).void
          end
          attr_writer :conversation

          # Input items to include in the prompt for the model. Using this field creates a
          # new context for this Response instead of using the default conversation. An
          # empty array `[]` will clear the context for this Response. Note that this can
          # include references to items from the default conversation.
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
          # guidance to the model on the desired behavior.
          #
          # Note that the server sets default instructions which will be used if this field
          # is not set and are visible in the `session.created` event at the start of the
          # session.
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

          # The set of modalities the model can respond with. To disable audio, set this to
          # ["text"].
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Modality::OrSymbol
                ]
              )
            )
          end
          attr_reader :modalities

          sig do
            params(
              modalities:
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Modality::OrSymbol
                ]
            ).void
          end
          attr_writer :modalities

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::OrSymbol
              )
            )
          end
          attr_reader :output_audio_format

          sig do
            params(
              output_audio_format:
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::OrSymbol
            ).void
          end
          attr_writer :output_audio_format

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

          # Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8.
          sig { returns(T.nilable(Float)) }
          attr_reader :temperature

          sig { params(temperature: Float).void }
          attr_writer :temperature

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

          # Tools (functions) available to the model.
          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Realtime::ResponseCreateEvent::Response::Tool]
              )
            )
          end
          attr_reader :tools

          sig do
            params(
              tools:
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::OrHash
                ]
            ).void
          end
          attr_writer :tools

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
          sig do
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice::OrSymbol
                )
              )
            )
          end
          attr_reader :voice

          sig do
            params(
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice::OrSymbol
                )
            ).void
          end
          attr_writer :voice

          # Create a new Realtime response with these parameters
          sig do
            params(
              conversation:
                T.any(
                  String,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::OrSymbol
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
              modalities:
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Modality::OrSymbol
                ],
              output_audio_format:
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::OrSymbol,
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
              temperature: Float,
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceFunction::OrHash,
                  OpenAI::Responses::ToolChoiceMcp::OrHash
                ),
              tools:
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::OrHash
                ],
              voice:
                T.any(
                  String,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice::OrSymbol
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # Controls which conversation the response is added to. Currently supports `auto`
            # and `none`, with `auto` as the default value. The `auto` value means that the
            # contents of the response will be added to the default conversation. Set this to
            # `none` to create an out-of-band response which will not add items to default
            # conversation.
            conversation: nil,
            # Input items to include in the prompt for the model. Using this field creates a
            # new context for this Response instead of using the default conversation. An
            # empty array `[]` will clear the context for this Response. Note that this can
            # include references to items from the default conversation.
            input: nil,
            # The default system instructions (i.e. system message) prepended to model calls.
            # This field allows the client to guide the model on desired responses. The model
            # can be instructed on response content and format, (e.g. "be extremely succinct",
            # "act friendly", "here are examples of good responses") and on audio behavior
            # (e.g. "talk quickly", "inject emotion into your voice", "laugh frequently"). The
            # instructions are not guaranteed to be followed by the model, but they provide
            # guidance to the model on the desired behavior.
            #
            # Note that the server sets default instructions which will be used if this field
            # is not set and are visible in the `session.created` event at the start of the
            # session.
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
            # The set of modalities the model can respond with. To disable audio, set this to
            # ["text"].
            modalities: nil,
            # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            output_audio_format: nil,
            # Reference to a prompt template and its variables.
            # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
            prompt: nil,
            # Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8.
            temperature: nil,
            # How the model chooses tools. Provide one of the string modes or force a specific
            # function/MCP tool.
            tool_choice: nil,
            # Tools (functions) available to the model.
            tools: nil,
            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
            voice: nil
          )
          end

          sig do
            override.returns(
              {
                conversation:
                  T.any(
                    String,
                    OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::OrSymbol
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
                modalities:
                  T::Array[
                    OpenAI::Realtime::ResponseCreateEvent::Response::Modality::OrSymbol
                  ],
                output_audio_format:
                  OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::OrSymbol,
                prompt: T.nilable(OpenAI::Responses::ResponsePrompt),
                temperature: Float,
                tool_choice:
                  T.any(
                    OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                    OpenAI::Responses::ToolChoiceFunction,
                    OpenAI::Responses::ToolChoiceMcp
                  ),
                tools:
                  T::Array[
                    OpenAI::Realtime::ResponseCreateEvent::Response::Tool
                  ],
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::ResponseCreateEvent::Response::Voice::OrSymbol
                  )
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
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Conversation
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::TaggedSymbol
              )
            NONE =
              T.let(
                :none,
                OpenAI::Realtime::ResponseCreateEvent::Response::Conversation::TaggedSymbol
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
                  OpenAI::Realtime::ResponseCreateEvent::Response::MaxOutputTokens::Variants
                ]
              )
            end
            def self.variants
            end
          end

          module Modality
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Modality
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TEXT =
              T.let(
                :text,
                OpenAI::Realtime::ResponseCreateEvent::Response::Modality::TaggedSymbol
              )
            AUDIO =
              T.let(
                :audio,
                OpenAI::Realtime::ResponseCreateEvent::Response::Modality::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Modality::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          module OutputAudioFormat
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PCM16 =
              T.let(
                :pcm16,
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::TaggedSymbol
              )
            G711_ULAW =
              T.let(
                :g711_ulaw,
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::TaggedSymbol
              )
            G711_ALAW =
              T.let(
                :g711_alaw,
                OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::OutputAudioFormat::TaggedSymbol
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
                  OpenAI::Realtime::ResponseCreateEvent::Response::ToolChoice::Variants
                ]
              )
            end
            def self.variants
            end
          end

          class Tool < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool,
                  OpenAI::Internal::AnyHash
                )
              end

            # The description of the function, including guidance on when and how to call it,
            # and guidance about what to tell the user when calling (if anything).
            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            # The name of the function.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # Parameters of the function in JSON Schema.
            sig { returns(T.nilable(T.anything)) }
            attr_reader :parameters

            sig { params(parameters: T.anything).void }
            attr_writer :parameters

            # The type of the tool, i.e. `function`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::OrSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::OrSymbol
              ).void
            end
            attr_writer :type

            sig do
              params(
                description: String,
                name: String,
                parameters: T.anything,
                type:
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The description of the function, including guidance on when and how to call it,
              # and guidance about what to tell the user when calling (if anything).
              description: nil,
              # The name of the function.
              name: nil,
              # Parameters of the function in JSON Schema.
              parameters: nil,
              # The type of the tool, i.e. `function`.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  description: String,
                  name: String,
                  parameters: T.anything,
                  type:
                    OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # The type of the tool, i.e. `function`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              FUNCTION =
                T.let(
                  :function,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::ResponseCreateEvent::Response::Tool::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          # The voice the model uses to respond. Voice cannot be changed during the session
          # once the model has responded with audio at least once. Current voice options are
          # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, and `verse`.
          module Voice
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ResponseCreateEvent::Response::Voice
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ALLOY =
              T.let(
                :alloy,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            ASH =
              T.let(
                :ash,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            BALLAD =
              T.let(
                :ballad,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            CORAL =
              T.let(
                :coral,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            ECHO =
              T.let(
                :echo,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            SAGE =
              T.let(
                :sage,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            SHIMMER =
              T.let(
                :shimmer,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            VERSE =
              T.let(
                :verse,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            MARIN =
              T.let(
                :marin,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
            CEDAR =
              T.let(
                :cedar,
                OpenAI::Realtime::ResponseCreateEvent::Response::Voice::TaggedSymbol
              )
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeSessionCreateRequest,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of session to create. Always `realtime` for the Realtime API.
        sig { returns(Symbol) }
        attr_accessor :type

        # Configuration for input and output audio.
        sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioConfig)) }
        attr_reader :audio

        sig do
          params(audio: OpenAI::Realtime::RealtimeAudioConfig::OrHash).void
        end
        attr_writer :audio

        # Additional fields to include in server outputs.
        #
        # `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        # transcription.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include::OrSymbol
              ]
            )
          )
        end
        attr_reader :include

        sig do
          params(
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include::OrSymbol
              ]
          ).void
        end
        attr_writer :include

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

        # The Realtime model used for this session.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::OrSymbol
              )
            )
          )
        end
        attr_reader :model

        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::OrSymbol
              )
          ).void
        end
        attr_writer :model

        # The set of modalities the model can respond with. It defaults to `["audio"]`,
        # indicating that the model will respond with audio plus a transcript. `["text"]`
        # can be used to make the model respond with text only. It is not possible to
        # request both `text` and `audio` at the same time.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::OrSymbol
              ]
            )
          )
        end
        attr_reader :output_modalities

        sig do
          params(
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::OrSymbol
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
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp
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
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::OrHash
                )
              ]
          ).void
        end
        attr_writer :tools

        # Realtime API can write session traces to the
        # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
        # tracing is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration
              )
            )
          )
        end
        attr_accessor :tracing

        # When the number of tokens in a conversation exceeds the model's input token
        # limit, the conversation be truncated, meaning messages (starting from the
        # oldest) will not be included in the model's context. A 32k context model with
        # 4,096 max output tokens can only include 28,224 tokens in the context before
        # truncation occurs. Clients can configure truncation behavior to truncate with a
        # lower max token limit, which is an effective way to control token usage and
        # cost. Truncation will reduce the number of cached tokens on the next turn
        # (busting the cache), since messages are dropped from the beginning of the
        # context. However, clients can also configure truncation to retain messages up to
        # a fraction of the maximum context size, which will reduce the need for future
        # truncations and thus improve the cache rate. Truncation can be disabled
        # entirely, which means the server will never truncate but would instead return an
        # error if the conversation exceeds the model's input token limit.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                OpenAI::Realtime::RealtimeTruncationRetentionRatio
              )
            )
          )
        end
        attr_reader :truncation

        sig do
          params(
            truncation:
              T.any(
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                OpenAI::Realtime::RealtimeTruncationRetentionRatio::OrHash
              )
          ).void
        end
        attr_writer :truncation

        # Realtime session object configuration.
        sig do
          params(
            audio: OpenAI::Realtime::RealtimeAudioConfig::OrHash,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include::OrSymbol
              ],
            instructions: String,
            max_output_tokens: T.any(Integer, Symbol),
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::OrSymbol
              ),
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::OrSymbol
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
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::OrHash
                )
              ],
            tracing:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration::OrHash
                )
              ),
            truncation:
              T.any(
                OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                OpenAI::Realtime::RealtimeTruncationRetentionRatio::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Configuration for input and output audio.
          audio: nil,
          # Additional fields to include in server outputs.
          #
          # `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          # transcription.
          include: nil,
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
          # The Realtime model used for this session.
          model: nil,
          # The set of modalities the model can respond with. It defaults to `["audio"]`,
          # indicating that the model will respond with audio plus a transcript. `["text"]`
          # can be used to make the model respond with text only. It is not possible to
          # request both `text` and `audio` at the same time.
          output_modalities: nil,
          # Reference to a prompt template and its variables.
          # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
          prompt: nil,
          # How the model chooses tools. Provide one of the string modes or force a specific
          # function/MCP tool.
          tool_choice: nil,
          # Tools available to the model.
          tools: nil,
          # Realtime API can write session traces to the
          # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
          # tracing is enabled for a session, the configuration cannot be modified.
          #
          # `auto` will create a trace for the session with default values for the workflow
          # name, group id, and metadata.
          tracing: nil,
          # When the number of tokens in a conversation exceeds the model's input token
          # limit, the conversation be truncated, meaning messages (starting from the
          # oldest) will not be included in the model's context. A 32k context model with
          # 4,096 max output tokens can only include 28,224 tokens in the context before
          # truncation occurs. Clients can configure truncation behavior to truncate with a
          # lower max token limit, which is an effective way to control token usage and
          # cost. Truncation will reduce the number of cached tokens on the next turn
          # (busting the cache), since messages are dropped from the beginning of the
          # context. However, clients can also configure truncation to retain messages up to
          # a fraction of the maximum context size, which will reduce the need for future
          # truncations and thus improve the cache rate. Truncation can be disabled
          # entirely, which means the server will never truncate but would instead return an
          # error if the conversation exceeds the model's input token limit.
          truncation: nil,
          # The type of session to create. Always `realtime` for the Realtime API.
          type: :realtime
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              audio: OpenAI::Realtime::RealtimeAudioConfig,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateRequest::Include::OrSymbol
                ],
              instructions: String,
              max_output_tokens: T.any(Integer, Symbol),
              model:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeSessionCreateRequest::Model::OrSymbol
                ),
              output_modalities:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::OrSymbol
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
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp
                  )
                ],
              tracing:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration
                  )
                ),
              truncation:
                T.any(
                  OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                  OpenAI::Realtime::RealtimeTruncationRetentionRatio
                )
            }
          )
        end
        def to_hash
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Include::TaggedSymbol
              ]
            )
          end
          def self.values
          end
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
                OpenAI::Realtime::RealtimeSessionCreateRequest::MaxOutputTokens::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # The Realtime model used for this session.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateRequest::Model
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_REALTIME =
            T.let(
              :"gpt-realtime",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_REALTIME_2025_08_28 =
            T.let(
              :"gpt-realtime-2025-08-28",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-realtime-preview",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-realtime-preview-2024-10-01",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-realtime-preview-2025-06-03",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-mini-realtime-preview",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_REALTIME_MINI =
            T.let(
              :"gpt-realtime-mini",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_REALTIME_MINI_2025_10_06 =
            T.let(
              :"gpt-realtime-mini-2025-10-06",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_AUDIO_MINI =
            T.let(
              :"gpt-audio-mini",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_AUDIO_MINI_2025_10_06 =
            T.let(
              :"gpt-audio-mini-2025-10-06",
              OpenAI::Realtime::RealtimeSessionCreateRequest::Model::TaggedSymbol
            )
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::TaggedSymbol
            )
          AUDIO =
            T.let(
              :audio,
              OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateRequest::OutputModality::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end

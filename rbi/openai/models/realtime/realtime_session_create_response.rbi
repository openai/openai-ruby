# typed: strong

module OpenAI
  module Models
    RealtimeSessionCreateResponse = Realtime::RealtimeSessionCreateResponse

    module Realtime
      class RealtimeSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeSessionCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Ephemeral key returned by the API.
        sig { returns(OpenAI::Realtime::RealtimeSessionClientSecret) }
        attr_reader :client_secret

        sig do
          params(
            client_secret: OpenAI::Realtime::RealtimeSessionClientSecret::OrHash
          ).void
        end
        attr_writer :client_secret

        # The type of session to create. Always `realtime` for the Realtime API.
        sig { returns(Symbol) }
        attr_accessor :type

        # Configuration for input and output audio.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeSessionCreateResponse::Audio)
          )
        end
        attr_reader :audio

        sig do
          params(
            audio:
              OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::OrHash
          ).void
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include::TaggedSymbol
              ]
            )
          )
        end
        attr_reader :include

        sig do
          params(
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include::OrSymbol
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
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSessionCreateResponse::MaxOutputTokens::Variants
            )
          )
        end
        attr_reader :max_output_tokens

        sig { params(max_output_tokens: T.any(Integer, Symbol)).void }
        attr_writer :max_output_tokens

        # The Realtime model used for this session.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::Variants
            )
          )
        end
        attr_reader :model

        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model::OrSymbol
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
              ]
            )
          )
        end
        attr_reader :output_modalities

        sig do
          params(
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::OrSymbol
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
              OpenAI::Realtime::RealtimeSessionCreateResponse::ToolChoice::Variants
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Variants
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
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::OrHash
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
              OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::Variants
            )
          )
        end
        attr_accessor :tracing

        # When the number of tokens in a conversation exceeds the model's input token
        # limit, the conversation be truncated, meaning messages (starting from the
        # oldest) will not be included in the model's context. A 32k context model with
        # 4,096 max output tokens can only include 28,224 tokens in the context before
        # truncation occurs.
        #
        # Clients can configure truncation behavior to truncate with a lower max token
        # limit, which is an effective way to control token usage and cost.
        #
        # Truncation will reduce the number of cached tokens on the next turn (busting the
        # cache), since messages are dropped from the beginning of the context. However,
        # clients can also configure truncation to retain messages up to a fraction of the
        # maximum context size, which will reduce the need for future truncations and thus
        # improve the cache rate.
        #
        # Truncation can be disabled entirely, which means the server will never truncate
        # but would instead return an error if the conversation exceeds the model's input
        # token limit.
        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeTruncation::Variants))
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

        # A new Realtime session configuration, with an ephemeral key. Default TTL for
        # keys is one minute.
        sig do
          params(
            client_secret:
              OpenAI::Realtime::RealtimeSessionClientSecret::OrHash,
            audio:
              OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::OrHash,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include::OrSymbol
              ],
            instructions: String,
            max_output_tokens: T.any(Integer, Symbol),
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model::OrSymbol
              ),
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::OrSymbol
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
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::OrHash
                )
              ],
            tracing:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration::OrHash
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
          # Ephemeral key returned by the API.
          client_secret:,
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
          # truncation occurs.
          #
          # Clients can configure truncation behavior to truncate with a lower max token
          # limit, which is an effective way to control token usage and cost.
          #
          # Truncation will reduce the number of cached tokens on the next turn (busting the
          # cache), since messages are dropped from the beginning of the context. However,
          # clients can also configure truncation to retain messages up to a fraction of the
          # maximum context size, which will reduce the need for future truncations and thus
          # improve the cache rate.
          #
          # Truncation can be disabled entirely, which means the server will never truncate
          # but would instead return an error if the conversation exceeds the model's input
          # token limit.
          truncation: nil,
          # The type of session to create. Always `realtime` for the Realtime API.
          type: :realtime
        )
        end

        sig do
          override.returns(
            {
              client_secret: OpenAI::Realtime::RealtimeSessionClientSecret,
              type: Symbol,
              audio: OpenAI::Realtime::RealtimeSessionCreateResponse::Audio,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Include::TaggedSymbol
                ],
              instructions: String,
              max_output_tokens:
                OpenAI::Realtime::RealtimeSessionCreateResponse::MaxOutputTokens::Variants,
              model:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model::Variants,
              output_modalities:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
                ],
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt),
              tool_choice:
                OpenAI::Realtime::RealtimeSessionCreateResponse::ToolChoice::Variants,
              tools:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Variants
                ],
              tracing:
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::Variants
                ),
              truncation: OpenAI::Realtime::RealtimeTruncation::Variants
            }
          )
        end
        def to_hash
        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input
              )
            )
          end
          attr_reader :input

          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::OrHash
            ).void
          end
          attr_writer :input

          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output
              )
            )
          end
          attr_reader :output

          sig do
            params(
              output:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::OrHash
            ).void
          end
          attr_writer :output

          # Configuration for input and output audio.
          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::OrHash,
              output:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::OrHash
            ).returns(T.attached_class)
          end
          def self.new(input: nil, output: nil)
          end

          sig do
            override.returns(
              {
                input:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input,
                output:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output
              }
            )
          end
          def to_hash
          end

          class Input < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input,
                  OpenAI::Internal::AnyHash
                )
              end

            # The format of the input audio.
            sig do
              returns(
                T.nilable(OpenAI::Realtime::RealtimeAudioFormats::Variants)
              )
            end
            attr_reader :format_

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
                  )
              ).void
            end
            attr_writer :format_

            # Configuration for input audio noise reduction. This can be set to `null` to turn
            # off. Noise reduction filters audio added to the input audio buffer before it is
            # sent to VAD and the model. Filtering the audio can improve VAD and turn
            # detection accuracy (reducing false positives) and model performance by improving
            # perception of the input audio.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction
                )
              )
            end
            attr_reader :noise_reduction

            sig do
              params(
                noise_reduction:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::OrHash
              ).void
            end
            attr_writer :noise_reduction

            # Configuration for input audio transcription, defaults to off and can be set to
            # `null` to turn off once on. Input audio transcription is not native to the
            # model, since the model consumes audio directly. Transcription runs
            # asynchronously through
            # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
            # and should be treated as guidance of input audio content rather than precisely
            # what the model heard. The client can optionally set the language and prompt for
            # transcription, these offer additional guidance to the transcription service.
            sig { returns(T.nilable(OpenAI::Realtime::AudioTranscription)) }
            attr_reader :transcription

            sig do
              params(
                transcription: OpenAI::Realtime::AudioTranscription::OrHash
              ).void
            end
            attr_writer :transcription

            # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            # set to `null` to turn off, in which case the client must manually trigger model
            # response.
            #
            # Server VAD means that the model will detect the start and end of speech based on
            # audio volume and respond at the end of user speech.
            #
            # Semantic VAD is more advanced and uses a turn detection model (in conjunction
            # with VAD) to semantically estimate whether the user has finished speaking, then
            # dynamically sets a timeout based on this probability. For example, if user audio
            # trails off with "uhhm", the model will score a low probability of turn end and
            # wait longer for the user to continue speaking. This can be useful for more
            # natural conversations, but may have a higher latency.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::Variants
                )
              )
            end
            attr_accessor :turn_detection

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
                  ),
                noise_reduction:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::OrHash,
                transcription: OpenAI::Realtime::AudioTranscription::OrHash,
                turn_detection:
                  T.nilable(
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad::OrHash,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::OrHash
                    )
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # The format of the input audio.
              format_: nil,
              # Configuration for input audio noise reduction. This can be set to `null` to turn
              # off. Noise reduction filters audio added to the input audio buffer before it is
              # sent to VAD and the model. Filtering the audio can improve VAD and turn
              # detection accuracy (reducing false positives) and model performance by improving
              # perception of the input audio.
              noise_reduction: nil,
              # Configuration for input audio transcription, defaults to off and can be set to
              # `null` to turn off once on. Input audio transcription is not native to the
              # model, since the model consumes audio directly. Transcription runs
              # asynchronously through
              # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
              # and should be treated as guidance of input audio content rather than precisely
              # what the model heard. The client can optionally set the language and prompt for
              # transcription, these offer additional guidance to the transcription service.
              transcription: nil,
              # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
              # set to `null` to turn off, in which case the client must manually trigger model
              # response.
              #
              # Server VAD means that the model will detect the start and end of speech based on
              # audio volume and respond at the end of user speech.
              #
              # Semantic VAD is more advanced and uses a turn detection model (in conjunction
              # with VAD) to semantically estimate whether the user has finished speaking, then
              # dynamically sets a timeout based on this probability. For example, if user audio
              # trails off with "uhhm", the model will score a low probability of turn end and
              # wait longer for the user to continue speaking. This can be useful for more
              # natural conversations, but may have a higher latency.
              turn_detection: nil
            )
            end

            sig do
              override.returns(
                {
                  format_: OpenAI::Realtime::RealtimeAudioFormats::Variants,
                  noise_reduction:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction,
                  transcription: OpenAI::Realtime::AudioTranscription,
                  turn_detection:
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::Variants
                    )
                }
              )
            end
            def to_hash
            end

            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Type of noise reduction. `near_field` is for close-talking microphones such as
              # headphones, `far_field` is for far-field microphones such as laptop or
              # conference room microphones.
              sig do
                returns(
                  T.nilable(OpenAI::Realtime::NoiseReductionType::TaggedSymbol)
                )
              end
              attr_reader :type

              sig do
                params(
                  type: OpenAI::Realtime::NoiseReductionType::OrSymbol
                ).void
              end
              attr_writer :type

              # Configuration for input audio noise reduction. This can be set to `null` to turn
              # off. Noise reduction filters audio added to the input audio buffer before it is
              # sent to VAD and the model. Filtering the audio can improve VAD and turn
              # detection accuracy (reducing false positives) and model performance by improving
              # perception of the input audio.
              sig do
                params(
                  type: OpenAI::Realtime::NoiseReductionType::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Type of noise reduction. `near_field` is for close-talking microphones such as
                # headphones, `far_field` is for far-field microphones such as laptop or
                # conference room microphones.
                type: nil
              )
              end

              sig do
                override.returns(
                  { type: OpenAI::Realtime::NoiseReductionType::TaggedSymbol }
                )
              end
              def to_hash
              end
            end

            # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
            # set to `null` to turn off, in which case the client must manually trigger model
            # response.
            #
            # Server VAD means that the model will detect the start and end of speech based on
            # audio volume and respond at the end of user speech.
            #
            # Semantic VAD is more advanced and uses a turn detection model (in conjunction
            # with VAD) to semantically estimate whether the user has finished speaking, then
            # dynamically sets a timeout based on this probability. For example, if user audio
            # trails off with "uhhm", the model will score a low probability of turn end and
            # wait longer for the user to continue speaking. This can be useful for more
            # natural conversations, but may have a higher latency.
            module TurnDetection
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad
                  )
                end

              class ServerVad < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::ServerVad,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Type of turn detection, `server_vad` to turn on simple Server VAD.
                sig { returns(Symbol) }
                attr_accessor :type

                # Whether or not to automatically generate a response when a VAD stop event
                # occurs. If `interrupt_response` is set to `false` this may fail to create a
                # response if the model is already responding.
                #
                # If both `create_response` and `interrupt_response` are set to `false`, the model
                # will never respond automatically but VAD events will still be emitted.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :create_response

                sig { params(create_response: T::Boolean).void }
                attr_writer :create_response

                # Optional timeout after which a model response will be triggered automatically.
                # This is useful for situations in which a long pause from the user is unexpected,
                # such as a phone call. The model will effectively prompt the user to continue the
                # conversation based on the current context.
                #
                # The timeout value will be applied after the last model response's audio has
                # finished playing, i.e. it's set to the `response.done` time plus audio playback
                # duration.
                #
                # An `input_audio_buffer.timeout_triggered` event (plus events associated with the
                # Response) will be emitted when the timeout is reached. Idle timeout is currently
                # only supported for `server_vad` mode.
                sig { returns(T.nilable(Integer)) }
                attr_accessor :idle_timeout_ms

                # Whether or not to automatically interrupt (cancel) any ongoing response with
                # output to the default conversation (i.e. `conversation` of `auto`) when a VAD
                # start event occurs. If `true` then the response will be cancelled, otherwise it
                # will continue until complete.
                #
                # If both `create_response` and `interrupt_response` are set to `false`, the model
                # will never respond automatically but VAD events will still be emitted.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :interrupt_response

                sig { params(interrupt_response: T::Boolean).void }
                attr_writer :interrupt_response

                # Used only for `server_vad` mode. Amount of audio to include before the VAD
                # detected speech (in milliseconds). Defaults to 300ms.
                sig { returns(T.nilable(Integer)) }
                attr_reader :prefix_padding_ms

                sig { params(prefix_padding_ms: Integer).void }
                attr_writer :prefix_padding_ms

                # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
                # milliseconds). Defaults to 500ms. With shorter values the model will respond
                # more quickly, but may jump in on short pauses from the user.
                sig { returns(T.nilable(Integer)) }
                attr_reader :silence_duration_ms

                sig { params(silence_duration_ms: Integer).void }
                attr_writer :silence_duration_ms

                # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
                # defaults to 0.5. A higher threshold will require louder audio to activate the
                # model, and thus might perform better in noisy environments.
                sig { returns(T.nilable(Float)) }
                attr_reader :threshold

                sig { params(threshold: Float).void }
                attr_writer :threshold

                # Server-side voice activity detection (VAD) which flips on when user speech is
                # detected and off after a period of silence.
                sig do
                  params(
                    create_response: T::Boolean,
                    idle_timeout_ms: T.nilable(Integer),
                    interrupt_response: T::Boolean,
                    prefix_padding_ms: Integer,
                    silence_duration_ms: Integer,
                    threshold: Float,
                    type: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Whether or not to automatically generate a response when a VAD stop event
                  # occurs. If `interrupt_response` is set to `false` this may fail to create a
                  # response if the model is already responding.
                  #
                  # If both `create_response` and `interrupt_response` are set to `false`, the model
                  # will never respond automatically but VAD events will still be emitted.
                  create_response: nil,
                  # Optional timeout after which a model response will be triggered automatically.
                  # This is useful for situations in which a long pause from the user is unexpected,
                  # such as a phone call. The model will effectively prompt the user to continue the
                  # conversation based on the current context.
                  #
                  # The timeout value will be applied after the last model response's audio has
                  # finished playing, i.e. it's set to the `response.done` time plus audio playback
                  # duration.
                  #
                  # An `input_audio_buffer.timeout_triggered` event (plus events associated with the
                  # Response) will be emitted when the timeout is reached. Idle timeout is currently
                  # only supported for `server_vad` mode.
                  idle_timeout_ms: nil,
                  # Whether or not to automatically interrupt (cancel) any ongoing response with
                  # output to the default conversation (i.e. `conversation` of `auto`) when a VAD
                  # start event occurs. If `true` then the response will be cancelled, otherwise it
                  # will continue until complete.
                  #
                  # If both `create_response` and `interrupt_response` are set to `false`, the model
                  # will never respond automatically but VAD events will still be emitted.
                  interrupt_response: nil,
                  # Used only for `server_vad` mode. Amount of audio to include before the VAD
                  # detected speech (in milliseconds). Defaults to 300ms.
                  prefix_padding_ms: nil,
                  # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
                  # milliseconds). Defaults to 500ms. With shorter values the model will respond
                  # more quickly, but may jump in on short pauses from the user.
                  silence_duration_ms: nil,
                  # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
                  # defaults to 0.5. A higher threshold will require louder audio to activate the
                  # model, and thus might perform better in noisy environments.
                  threshold: nil,
                  # Type of turn detection, `server_vad` to turn on simple Server VAD.
                  type: :server_vad
                )
                end

                sig do
                  override.returns(
                    {
                      type: Symbol,
                      create_response: T::Boolean,
                      idle_timeout_ms: T.nilable(Integer),
                      interrupt_response: T::Boolean,
                      prefix_padding_ms: Integer,
                      silence_duration_ms: Integer,
                      threshold: Float
                    }
                  )
                end
                def to_hash
                end
              end

              class SemanticVad < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Type of turn detection, `semantic_vad` to turn on Semantic VAD.
                sig { returns(Symbol) }
                attr_accessor :type

                # Whether or not to automatically generate a response when a VAD stop event
                # occurs.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :create_response

                sig { params(create_response: T::Boolean).void }
                attr_writer :create_response

                # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                # will wait longer for the user to continue speaking, `high` will respond more
                # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
                # and `high` have max timeouts of 8s, 4s, and 2s respectively.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                    )
                  )
                end
                attr_reader :eagerness

                sig do
                  params(
                    eagerness:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::OrSymbol
                  ).void
                end
                attr_writer :eagerness

                # Whether or not to automatically interrupt any ongoing response with output to
                # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
                # occurs.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :interrupt_response

                sig { params(interrupt_response: T::Boolean).void }
                attr_writer :interrupt_response

                # Server-side semantic turn detection which uses a model to determine when the
                # user has finished speaking.
                sig do
                  params(
                    create_response: T::Boolean,
                    eagerness:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::OrSymbol,
                    interrupt_response: T::Boolean,
                    type: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Whether or not to automatically generate a response when a VAD stop event
                  # occurs.
                  create_response: nil,
                  # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                  # will wait longer for the user to continue speaking, `high` will respond more
                  # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
                  # and `high` have max timeouts of 8s, 4s, and 2s respectively.
                  eagerness: nil,
                  # Whether or not to automatically interrupt any ongoing response with output to
                  # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
                  # occurs.
                  interrupt_response: nil,
                  # Type of turn detection, `semantic_vad` to turn on Semantic VAD.
                  type: :semantic_vad
                )
                end

                sig do
                  override.returns(
                    {
                      type: Symbol,
                      create_response: T::Boolean,
                      eagerness:
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol,
                      interrupt_response: T::Boolean
                    }
                  )
                end
                def to_hash
                end

                # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
                # will wait longer for the user to continue speaking, `high` will respond more
                # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
                # and `high` have max timeouts of 8s, 4s, and 2s respectively.
                module Eagerness
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  LOW =
                    T.let(
                      :low,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                    )
                  MEDIUM =
                    T.let(
                      :medium,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                    )
                  HIGH =
                    T.let(
                      :high,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                    )
                  AUTO =
                    T.let(
                      :auto,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::SemanticVad::Eagerness::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end

          class Output < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output,
                  OpenAI::Internal::AnyHash
                )
              end

            # The format of the output audio.
            sig do
              returns(
                T.nilable(OpenAI::Realtime::RealtimeAudioFormats::Variants)
              )
            end
            attr_reader :format_

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
                  )
              ).void
            end
            attr_writer :format_

            # The speed of the model's spoken response as a multiple of the original speed.
            # 1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
            # This value can only be changed in between model turns, not while a response is
            # in progress.
            #
            # This parameter is a post-processing adjustment to the audio after it is
            # generated, it's also possible to prompt the model to speak faster or slower.
            sig { returns(T.nilable(Float)) }
            attr_reader :speed

            sig { params(speed: Float).void }
            attr_writer :speed

            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            # and `cedar`. We recommend `marin` and `cedar` for best quality.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::Variants
                )
              )
            end
            attr_reader :voice

            sig do
              params(
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::OrSymbol
                  )
              ).void
            end
            attr_writer :voice

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
                  ),
                speed: Float,
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::OrSymbol
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # The format of the output audio.
              format_: nil,
              # The speed of the model's spoken response as a multiple of the original speed.
              # 1.0 is the default speed. 0.25 is the minimum speed. 1.5 is the maximum speed.
              # This value can only be changed in between model turns, not while a response is
              # in progress.
              #
              # This parameter is a post-processing adjustment to the audio after it is
              # generated, it's also possible to prompt the model to speak faster or slower.
              speed: nil,
              # The voice the model uses to respond. Voice cannot be changed during the session
              # once the model has responded with audio at least once. Current voice options are
              # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
              # and `cedar`. We recommend `marin` and `cedar` for best quality.
              voice: nil
            )
            end

            sig do
              override.returns(
                {
                  format_: OpenAI::Realtime::RealtimeAudioFormats::Variants,
                  speed: Float,
                  voice:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::Variants
                }
              )
            end
            def to_hash
            end

            # The voice the model uses to respond. Voice cannot be changed during the session
            # once the model has responded with audio at least once. Current voice options are
            # `alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`, `marin`,
            # and `cedar`. We recommend `marin` and `cedar` for best quality.
            module Voice
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::Variants
                  ]
                )
              end
              def self.variants
              end

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ALLOY =
                T.let(
                  :alloy,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              ASH =
                T.let(
                  :ash,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              BALLAD =
                T.let(
                  :ballad,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              CORAL =
                T.let(
                  :coral,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              ECHO =
                T.let(
                  :echo,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              SAGE =
                T.let(
                  :sage,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              SHIMMER =
                T.let(
                  :shimmer,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              VERSE =
                T.let(
                  :verse,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              MARIN =
                T.let(
                  :marin,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
              CEDAR =
                T.let(
                  :cedar,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::TaggedSymbol
                )
            end
          end
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include::TaggedSymbol
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::MaxOutputTokens::Variants
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Model
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_REALTIME =
            T.let(
              :"gpt-realtime",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_REALTIME_2025_08_28 =
            T.let(
              :"gpt-realtime-2025-08-28",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-realtime-preview",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-realtime-preview-2024-10-01",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_REALTIME_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-realtime-preview-2025-06-03",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW =
            T.let(
              :"gpt-4o-mini-realtime-preview",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_4O_MINI_REALTIME_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-realtime-preview-2024-12-17",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_REALTIME_MINI =
            T.let(
              :"gpt-realtime-mini",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_REALTIME_MINI_2025_10_06 =
            T.let(
              :"gpt-realtime-mini-2025-10-06",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_REALTIME_MINI_2025_12_15 =
            T.let(
              :"gpt-realtime-mini-2025-12-15",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_AUDIO_MINI =
            T.let(
              :"gpt-audio-mini",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_AUDIO_MINI_2025_10_06 =
            T.let(
              :"gpt-audio-mini-2025-10-06",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
          GPT_AUDIO_MINI_2025_12_15 =
            T.let(
              :"gpt-audio-mini-2025-12-15",
              OpenAI::Realtime::RealtimeSessionCreateResponse::Model::TaggedSymbol
            )
        end

        module OutputModality
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
            )
          AUDIO =
            T.let(
              :audio,
              OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::ToolChoice::Variants
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool
              )
            end

          class McpTool < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool,
                  OpenAI::Internal::AnyHash
                )
              end

            # A label for this MCP server, used to identify it in tool calls.
            sig { returns(String) }
            attr_accessor :server_label

            # The type of the MCP tool. Always `mcp`.
            sig { returns(Symbol) }
            attr_accessor :type

            # List of allowed tool names or a filter object.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::Variants
                )
              )
            end
            attr_accessor :allowed_tools

            # An OAuth access token that can be used with a remote MCP server, either with a
            # custom MCP server URL or a service connector. Your application must handle the
            # OAuth authorization flow and provide the token here.
            sig { returns(T.nilable(String)) }
            attr_reader :authorization

            sig { params(authorization: String).void }
            attr_writer :authorization

            # Identifier for service connectors, like those available in ChatGPT. One of
            # `server_url` or `connector_id` must be provided. Learn more about service
            # connectors
            # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            # Currently supported `connector_id` values are:
            #
            # - Dropbox: `connector_dropbox`
            # - Gmail: `connector_gmail`
            # - Google Calendar: `connector_googlecalendar`
            # - Google Drive: `connector_googledrive`
            # - Microsoft Teams: `connector_microsoftteams`
            # - Outlook Calendar: `connector_outlookcalendar`
            # - Outlook Email: `connector_outlookemail`
            # - SharePoint: `connector_sharepoint`
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              )
            end
            attr_reader :connector_id

            sig do
              params(
                connector_id:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::OrSymbol
              ).void
            end
            attr_writer :connector_id

            # Optional HTTP headers to send to the MCP server. Use for authentication or other
            # purposes.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :headers

            # Specify which of the MCP server's tools require approval.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::Variants
                )
              )
            end
            attr_accessor :require_approval

            # Optional description of the MCP server, used to provide more context.
            sig { returns(T.nilable(String)) }
            attr_reader :server_description

            sig { params(server_description: String).void }
            attr_writer :server_description

            # The URL for the MCP server. One of `server_url` or `connector_id` must be
            # provided.
            sig { returns(T.nilable(String)) }
            attr_reader :server_url

            sig { params(server_url: String).void }
            attr_writer :server_url

            # Give the model access to additional tools via remote Model Context Protocol
            # (MCP) servers.
            # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
            sig do
              params(
                server_label: String,
                allowed_tools:
                  T.nilable(
                    T.any(
                      T::Array[String],
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter::OrHash
                    )
                  ),
                authorization: String,
                connector_id:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::OrSymbol,
                headers: T.nilable(T::Hash[Symbol, String]),
                require_approval:
                  T.nilable(
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::OrHash,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting::OrSymbol
                    )
                  ),
                server_description: String,
                server_url: String,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # A label for this MCP server, used to identify it in tool calls.
              server_label:,
              # List of allowed tool names or a filter object.
              allowed_tools: nil,
              # An OAuth access token that can be used with a remote MCP server, either with a
              # custom MCP server URL or a service connector. Your application must handle the
              # OAuth authorization flow and provide the token here.
              authorization: nil,
              # Identifier for service connectors, like those available in ChatGPT. One of
              # `server_url` or `connector_id` must be provided. Learn more about service
              # connectors
              # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
              #
              # Currently supported `connector_id` values are:
              #
              # - Dropbox: `connector_dropbox`
              # - Gmail: `connector_gmail`
              # - Google Calendar: `connector_googlecalendar`
              # - Google Drive: `connector_googledrive`
              # - Microsoft Teams: `connector_microsoftteams`
              # - Outlook Calendar: `connector_outlookcalendar`
              # - Outlook Email: `connector_outlookemail`
              # - SharePoint: `connector_sharepoint`
              connector_id: nil,
              # Optional HTTP headers to send to the MCP server. Use for authentication or other
              # purposes.
              headers: nil,
              # Specify which of the MCP server's tools require approval.
              require_approval: nil,
              # Optional description of the MCP server, used to provide more context.
              server_description: nil,
              # The URL for the MCP server. One of `server_url` or `connector_id` must be
              # provided.
              server_url: nil,
              # The type of the MCP tool. Always `mcp`.
              type: :mcp
            )
            end

            sig do
              override.returns(
                {
                  server_label: String,
                  type: Symbol,
                  allowed_tools:
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::Variants
                    ),
                  authorization: String,
                  connector_id:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol,
                  headers: T.nilable(T::Hash[Symbol, String]),
                  require_approval:
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::Variants
                    ),
                  server_description: String,
                  server_url: String
                }
              )
            end
            def to_hash
            end

            # List of allowed tool names or a filter object.
            module AllowedTools
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    T::Array[String],
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter
                  )
                end

              class McpToolFilter < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::McpToolFilter,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :read_only

                sig { params(read_only: T::Boolean).void }
                attr_writer :read_only

                # List of allowed tool names.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :tool_names

                sig { params(tool_names: T::Array[String]).void }
                attr_writer :tool_names

                # A filter object to specify which tools are allowed.
                sig do
                  params(
                    read_only: T::Boolean,
                    tool_names: T::Array[String]
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  read_only: nil,
                  # List of allowed tool names.
                  tool_names: nil
                )
                end

                sig do
                  override.returns(
                    { read_only: T::Boolean, tool_names: T::Array[String] }
                  )
                end
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::AllowedTools::Variants
                  ]
                )
              end
              def self.variants
              end

              StringArray =
                T.let(
                  OpenAI::Internal::Type::ArrayOf[String],
                  OpenAI::Internal::Type::Converter
                )
            end

            # Identifier for service connectors, like those available in ChatGPT. One of
            # `server_url` or `connector_id` must be provided. Learn more about service
            # connectors
            # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            # Currently supported `connector_id` values are:
            #
            # - Dropbox: `connector_dropbox`
            # - Gmail: `connector_gmail`
            # - Google Calendar: `connector_googlecalendar`
            # - Google Drive: `connector_googledrive`
            # - Microsoft Teams: `connector_microsoftteams`
            # - Outlook Calendar: `connector_outlookcalendar`
            # - Outlook Email: `connector_outlookemail`
            # - SharePoint: `connector_sharepoint`
            module ConnectorID
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              CONNECTOR_DROPBOX =
                T.let(
                  :connector_dropbox,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_GMAIL =
                T.let(
                  :connector_gmail,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_GOOGLECALENDAR =
                T.let(
                  :connector_googlecalendar,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_GOOGLEDRIVE =
                T.let(
                  :connector_googledrive,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_MICROSOFTTEAMS =
                T.let(
                  :connector_microsoftteams,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_OUTLOOKCALENDAR =
                T.let(
                  :connector_outlookcalendar,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_OUTLOOKEMAIL =
                T.let(
                  :connector_outlookemail,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )
              CONNECTOR_SHAREPOINT =
                T.let(
                  :connector_sharepoint,
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::ConnectorID::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # Specify which of the MCP server's tools require approval.
            module RequireApproval
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                  )
                end

              class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # A filter object to specify which tools are allowed.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always
                    )
                  )
                end
                attr_reader :always

                sig do
                  params(
                    always:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always::OrHash
                  ).void
                end
                attr_writer :always

                # A filter object to specify which tools are allowed.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never
                    )
                  )
                end
                attr_reader :never

                sig do
                  params(
                    never:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never::OrHash
                  ).void
                end
                attr_writer :never

                # Specify which of the MCP server's tools require approval. Can be `always`,
                # `never`, or a filter object associated with tools that require approval.
                sig do
                  params(
                    always:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always::OrHash,
                    never:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never::OrHash
                  ).returns(T.attached_class)
                end
                def self.new(
                  # A filter object to specify which tools are allowed.
                  always: nil,
                  # A filter object to specify which tools are allowed.
                  never: nil
                )
                end

                sig do
                  override.returns(
                    {
                      always:
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always,
                      never:
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never
                    }
                  )
                end
                def to_hash
                end

                class Always < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Always,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  sig { returns(T.nilable(T::Boolean)) }
                  attr_reader :read_only

                  sig { params(read_only: T::Boolean).void }
                  attr_writer :read_only

                  # List of allowed tool names.
                  sig { returns(T.nilable(T::Array[String])) }
                  attr_reader :tool_names

                  sig { params(tool_names: T::Array[String]).void }
                  attr_writer :tool_names

                  # A filter object to specify which tools are allowed.
                  sig do
                    params(
                      read_only: T::Boolean,
                      tool_names: T::Array[String]
                    ).returns(T.attached_class)
                  end
                  def self.new(
                    # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                    # is
                    # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                    # it will match this filter.
                    read_only: nil,
                    # List of allowed tool names.
                    tool_names: nil
                  )
                  end

                  sig do
                    override.returns(
                      { read_only: T::Boolean, tool_names: T::Array[String] }
                    )
                  end
                  def to_hash
                  end
                end

                class Never < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalFilter::Never,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  sig { returns(T.nilable(T::Boolean)) }
                  attr_reader :read_only

                  sig { params(read_only: T::Boolean).void }
                  attr_writer :read_only

                  # List of allowed tool names.
                  sig { returns(T.nilable(T::Array[String])) }
                  attr_reader :tool_names

                  sig { params(tool_names: T::Array[String]).void }
                  attr_writer :tool_names

                  # A filter object to specify which tools are allowed.
                  sig do
                    params(
                      read_only: T::Boolean,
                      tool_names: T::Array[String]
                    ).returns(T.attached_class)
                  end
                  def self.new(
                    # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                    # is
                    # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                    # it will match this filter.
                    read_only: nil,
                    # List of allowed tool names.
                    tool_names: nil
                  )
                  end

                  sig do
                    override.returns(
                      { read_only: T::Boolean, tool_names: T::Array[String] }
                    )
                  end
                  def to_hash
                  end
                end
              end

              # Specify a single approval policy for all tools. One of `always` or `never`. When
              # set to `always`, all tools will require approval. When set to `never`, all tools
              # will not require approval.
              module McpToolApprovalSetting
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                ALWAYS =
                  T.let(
                    :always,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                  )
                NEVER =
                  T.let(
                    :never,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::McpTool::RequireApproval::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Realtime API can write session traces to the
        # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
        # tracing is enabled for a session, the configuration cannot be modified.
        #
        # `auto` will create a trace for the session with default values for the workflow
        # name, group id, and metadata.
        module Tracing
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration
              )
            end

          class TracingConfiguration < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration,
                  OpenAI::Internal::AnyHash
                )
              end

            # The group id to attach to this trace to enable filtering and grouping in the
            # Traces Dashboard.
            sig { returns(T.nilable(String)) }
            attr_reader :group_id

            sig { params(group_id: String).void }
            attr_writer :group_id

            # The arbitrary metadata to attach to this trace to enable filtering in the Traces
            # Dashboard.
            sig { returns(T.nilable(T.anything)) }
            attr_reader :metadata

            sig { params(metadata: T.anything).void }
            attr_writer :metadata

            # The name of the workflow to attach to this trace. This is used to name the trace
            # in the Traces Dashboard.
            sig { returns(T.nilable(String)) }
            attr_reader :workflow_name

            sig { params(workflow_name: String).void }
            attr_writer :workflow_name

            # Granular configuration for tracing.
            sig do
              params(
                group_id: String,
                metadata: T.anything,
                workflow_name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The group id to attach to this trace to enable filtering and grouping in the
              # Traces Dashboard.
              group_id: nil,
              # The arbitrary metadata to attach to this trace to enable filtering in the Traces
              # Dashboard.
              metadata: nil,
              # The name of the workflow to attach to this trace. This is used to name the trace
              # in the Traces Dashboard.
              workflow_name: nil
            )
            end

            sig do
              override.returns(
                {
                  group_id: String,
                  metadata: T.anything,
                  workflow_name: String
                }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::Variants
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

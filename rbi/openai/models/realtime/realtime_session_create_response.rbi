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

        # Unique identifier for the session that looks like `sess_1234567890abcdef`.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # Configuration for input and output audio for the session.
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

        # Expiration timestamp for the session, in seconds since epoch.
        sig { returns(T.nilable(Integer)) }
        attr_reader :expires_at

        sig { params(expires_at: Integer).void }
        attr_writer :expires_at

        # Additional fields to include in server outputs.
        #
        # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #   transcription.
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
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # The object type. Always `realtime.session`.
        sig { returns(T.nilable(String)) }
        attr_reader :object

        sig { params(object: String).void }
        attr_writer :object

        # The set of modalities the model can respond with. To disable audio, set this to
        # ["text"].
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

        # How the model chooses tools. Options are `auto`, `none`, `required`, or specify
        # a function.
        sig { returns(T.nilable(String)) }
        attr_reader :tool_choice

        sig { params(tool_choice: String).void }
        attr_writer :tool_choice

        # Tools (functions) available to the model.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Realtime::RealtimeSessionCreateResponse::Tool]
            )
          )
        end
        attr_reader :tools

        sig do
          params(
            tools:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::OrHash
              ]
          ).void
        end
        attr_writer :tools

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
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
        attr_reader :tracing

        sig do
          params(
            tracing:
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration::OrHash
              )
          ).void
        end
        attr_writer :tracing

        # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
        # means that the model will detect the start and end of speech based on audio
        # volume and respond at the end of user speech.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection
            )
          )
        end
        attr_reader :turn_detection

        sig do
          params(
            turn_detection:
              OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection::OrHash
          ).void
        end
        attr_writer :turn_detection

        # A Realtime session configuration object.
        sig do
          params(
            id: String,
            audio:
              OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::OrHash,
            expires_at: Integer,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Include::OrSymbol
              ],
            instructions: String,
            max_output_tokens: T.any(Integer, Symbol),
            model: String,
            object: String,
            output_modalities:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::OrSymbol
              ],
            tool_choice: String,
            tools:
              T::Array[
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::OrHash
              ],
            tracing:
              T.any(
                Symbol,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::TracingConfiguration::OrHash
              ),
            turn_detection:
              OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the session that looks like `sess_1234567890abcdef`.
          id: nil,
          # Configuration for input and output audio for the session.
          audio: nil,
          # Expiration timestamp for the session, in seconds since epoch.
          expires_at: nil,
          # Additional fields to include in server outputs.
          #
          # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          #   transcription.
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
          # The object type. Always `realtime.session`.
          object: nil,
          # The set of modalities the model can respond with. To disable audio, set this to
          # ["text"].
          output_modalities: nil,
          # How the model chooses tools. Options are `auto`, `none`, `required`, or specify
          # a function.
          tool_choice: nil,
          # Tools (functions) available to the model.
          tools: nil,
          # Configuration options for tracing. Set to null to disable tracing. Once tracing
          # is enabled for a session, the configuration cannot be modified.
          #
          # `auto` will create a trace for the session with default values for the workflow
          # name, group id, and metadata.
          tracing: nil,
          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          turn_detection: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              audio: OpenAI::Realtime::RealtimeSessionCreateResponse::Audio,
              expires_at: Integer,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Include::TaggedSymbol
                ],
              instructions: String,
              max_output_tokens:
                OpenAI::Realtime::RealtimeSessionCreateResponse::MaxOutputTokens::Variants,
              model: String,
              object: String,
              output_modalities:
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::OutputModality::TaggedSymbol
                ],
              tool_choice: String,
              tools:
                T::Array[OpenAI::Realtime::RealtimeSessionCreateResponse::Tool],
              tracing:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tracing::Variants,
              turn_detection:
                OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection
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

          # Configuration for input and output audio for the session.
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

            # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            sig { returns(T.nilable(String)) }
            attr_reader :format_

            sig { params(format_: String).void }
            attr_writer :format_

            # Configuration for input audio noise reduction.
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

            # Configuration for input audio transcription.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription
                )
              )
            end
            attr_reader :transcription

            sig do
              params(
                transcription:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription::OrHash
              ).void
            end
            attr_writer :transcription

            # Configuration for turn detection.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection
                )
              )
            end
            attr_reader :turn_detection

            sig do
              params(
                turn_detection:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::OrHash
              ).void
            end
            attr_writer :turn_detection

            sig do
              params(
                format_: String,
                noise_reduction:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::OrHash,
                transcription:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription::OrHash,
                turn_detection:
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
              format_: nil,
              # Configuration for input audio noise reduction.
              noise_reduction: nil,
              # Configuration for input audio transcription.
              transcription: nil,
              # Configuration for turn detection.
              turn_detection: nil
            )
            end

            sig do
              override.returns(
                {
                  format_: String,
                  noise_reduction:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction,
                  transcription:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription,
                  turn_detection:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection
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

              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::TaggedSymbol
                  )
                )
              end
              attr_reader :type

              sig do
                params(
                  type:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::OrSymbol
                ).void
              end
              attr_writer :type

              # Configuration for input audio noise reduction.
              sig do
                params(
                  type:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(type: nil)
              end

              sig do
                override.returns(
                  {
                    type:
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::TaggedSymbol
                  }
                )
              end
              def to_hash
              end

              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                NEAR_FIELD =
                  T.let(
                    :near_field,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::TaggedSymbol
                  )
                FAR_FIELD =
                  T.let(
                    :far_field,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::NoiseReduction::Type::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            class Transcription < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::Transcription,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The language of the input audio.
              sig { returns(T.nilable(String)) }
              attr_reader :language

              sig { params(language: String).void }
              attr_writer :language

              # The model to use for transcription.
              sig { returns(T.nilable(String)) }
              attr_reader :model

              sig { params(model: String).void }
              attr_writer :model

              # Optional text to guide the model's style or continue a previous audio segment.
              sig { returns(T.nilable(String)) }
              attr_reader :prompt

              sig { params(prompt: String).void }
              attr_writer :prompt

              # Configuration for input audio transcription.
              sig do
                params(language: String, model: String, prompt: String).returns(
                  T.attached_class
                )
              end
              def self.new(
                # The language of the input audio.
                language: nil,
                # The model to use for transcription.
                model: nil,
                # Optional text to guide the model's style or continue a previous audio segment.
                prompt: nil
              )
              end

              sig do
                override.returns(
                  { language: String, model: String, prompt: String }
                )
              end
              def to_hash
              end
            end

            class TurnDetection < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Input::TurnDetection,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(T.nilable(Integer)) }
              attr_reader :prefix_padding_ms

              sig { params(prefix_padding_ms: Integer).void }
              attr_writer :prefix_padding_ms

              sig { returns(T.nilable(Integer)) }
              attr_reader :silence_duration_ms

              sig { params(silence_duration_ms: Integer).void }
              attr_writer :silence_duration_ms

              sig { returns(T.nilable(Float)) }
              attr_reader :threshold

              sig { params(threshold: Float).void }
              attr_writer :threshold

              # Type of turn detection, only `server_vad` is currently supported.
              sig { returns(T.nilable(String)) }
              attr_reader :type

              sig { params(type: String).void }
              attr_writer :type

              # Configuration for turn detection.
              sig do
                params(
                  prefix_padding_ms: Integer,
                  silence_duration_ms: Integer,
                  threshold: Float,
                  type: String
                ).returns(T.attached_class)
              end
              def self.new(
                prefix_padding_ms: nil,
                silence_duration_ms: nil,
                threshold: nil,
                # Type of turn detection, only `server_vad` is currently supported.
                type: nil
              )
              end

              sig do
                override.returns(
                  {
                    prefix_padding_ms: Integer,
                    silence_duration_ms: Integer,
                    threshold: Float,
                    type: String
                  }
                )
              end
              def to_hash
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

            # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            sig { returns(T.nilable(String)) }
            attr_reader :format_

            sig { params(format_: String).void }
            attr_writer :format_

            sig { returns(T.nilable(Float)) }
            attr_reader :speed

            sig { params(speed: Float).void }
            attr_writer :speed

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
                format_: String,
                speed: Float,
                voice:
                  T.any(
                    String,
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::OrSymbol
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
              format_: nil,
              speed: nil,
              voice: nil
            )
            end

            sig do
              override.returns(
                {
                  format_: String,
                  speed: Float,
                  voice:
                    OpenAI::Realtime::RealtimeSessionCreateResponse::Audio::Output::Voice::Variants
                }
              )
            end
            def to_hash
            end

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

        class Tool < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool,
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
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::TaggedSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              description: String,
              name: String,
              parameters: T.anything,
              type:
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::OrSymbol
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
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::TaggedSymbol
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
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FUNCTION =
              T.let(
                :function,
                OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeSessionCreateResponse::Tool::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # Configuration options for tracing. Set to null to disable tracing. Once tracing
        # is enabled for a session, the configuration cannot be modified.
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
            # traces dashboard.
            sig { returns(T.nilable(String)) }
            attr_reader :group_id

            sig { params(group_id: String).void }
            attr_writer :group_id

            # The arbitrary metadata to attach to this trace to enable filtering in the traces
            # dashboard.
            sig { returns(T.nilable(T.anything)) }
            attr_reader :metadata

            sig { params(metadata: T.anything).void }
            attr_writer :metadata

            # The name of the workflow to attach to this trace. This is used to name the trace
            # in the traces dashboard.
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
              # traces dashboard.
              group_id: nil,
              # The arbitrary metadata to attach to this trace to enable filtering in the traces
              # dashboard.
              metadata: nil,
              # The name of the workflow to attach to this trace. This is used to name the trace
              # in the traces dashboard.
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

        class TurnDetection < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateResponse::TurnDetection,
                OpenAI::Internal::AnyHash
              )
            end

          # Amount of audio to include before the VAD detected speech (in milliseconds).
          # Defaults to 300ms.
          sig { returns(T.nilable(Integer)) }
          attr_reader :prefix_padding_ms

          sig { params(prefix_padding_ms: Integer).void }
          attr_writer :prefix_padding_ms

          # Duration of silence to detect speech stop (in milliseconds). Defaults to 500ms.
          # With shorter values the model will respond more quickly, but may jump in on
          # short pauses from the user.
          sig { returns(T.nilable(Integer)) }
          attr_reader :silence_duration_ms

          sig { params(silence_duration_ms: Integer).void }
          attr_writer :silence_duration_ms

          # Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A higher
          # threshold will require louder audio to activate the model, and thus might
          # perform better in noisy environments.
          sig { returns(T.nilable(Float)) }
          attr_reader :threshold

          sig { params(threshold: Float).void }
          attr_writer :threshold

          # Type of turn detection, only `server_vad` is currently supported.
          sig { returns(T.nilable(String)) }
          attr_reader :type

          sig { params(type: String).void }
          attr_writer :type

          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          sig do
            params(
              prefix_padding_ms: Integer,
              silence_duration_ms: Integer,
              threshold: Float,
              type: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Amount of audio to include before the VAD detected speech (in milliseconds).
            # Defaults to 300ms.
            prefix_padding_ms: nil,
            # Duration of silence to detect speech stop (in milliseconds). Defaults to 500ms.
            # With shorter values the model will respond more quickly, but may jump in on
            # short pauses from the user.
            silence_duration_ms: nil,
            # Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A higher
            # threshold will require louder audio to activate the model, and thus might
            # perform better in noisy environments.
            threshold: nil,
            # Type of turn detection, only `server_vad` is currently supported.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float,
                type: String
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end

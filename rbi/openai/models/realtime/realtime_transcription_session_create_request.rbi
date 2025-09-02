# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest,
              OpenAI::Internal::AnyHash
            )
          end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        sig do
          returns(
            T.any(
              String,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::OrSymbol
            )
          )
        end
        attr_accessor :model

        # The type of session to create. Always `transcription` for transcription
        # sessions.
        sig { returns(Symbol) }
        attr_accessor :type

        # The set of items to include in the transcription. Current available items are:
        #
        # - `item.input_audio_transcription.logprobs`
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ]
            )
          )
        end
        attr_reader :include

        sig do
          params(
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ]
          ).void
        end
        attr_writer :include

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        # (mono), and little-endian byte order.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::OrSymbol
            )
          )
        end
        attr_reader :input_audio_format

        sig do
          params(
            input_audio_format:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::OrSymbol
          ).void
        end
        attr_writer :input_audio_format

        # Configuration for input audio noise reduction. This can be set to `null` to turn
        # off. Noise reduction filters audio added to the input audio buffer before it is
        # sent to VAD and the model. Filtering the audio can improve VAD and turn
        # detection accuracy (reducing false positives) and model performance by improving
        # perception of the input audio.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction
            )
          )
        end
        attr_reader :input_audio_noise_reduction

        sig do
          params(
            input_audio_noise_reduction:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::OrHash
          ).void
        end
        attr_writer :input_audio_noise_reduction

        # Configuration for input audio transcription. The client can optionally set the
        # language and prompt for transcription, these offer additional guidance to the
        # transcription service.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription
            )
          )
        end
        attr_reader :input_audio_transcription

        sig do
          params(
            input_audio_transcription:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::OrHash
          ).void
        end
        attr_writer :input_audio_transcription

        # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
        # means that the model will detect the start and end of speech based on audio
        # volume and respond at the end of user speech.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection
            )
          )
        end
        attr_reader :turn_detection

        sig do
          params(
            turn_detection:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::OrHash
          ).void
        end
        attr_writer :turn_detection

        # Realtime transcription session object configuration.
        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::OrSymbol
              ),
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ],
            input_audio_format:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::OrSymbol,
            input_audio_noise_reduction:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::OrHash,
            input_audio_transcription:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::OrHash,
            turn_detection:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # ID of the model to use. The options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
          # Whisper V2 model).
          model:,
          # The set of items to include in the transcription. Current available items are:
          #
          # - `item.input_audio_transcription.logprobs`
          include: nil,
          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          input_audio_format: nil,
          # Configuration for input audio noise reduction. This can be set to `null` to turn
          # off. Noise reduction filters audio added to the input audio buffer before it is
          # sent to VAD and the model. Filtering the audio can improve VAD and turn
          # detection accuracy (reducing false positives) and model performance by improving
          # perception of the input audio.
          input_audio_noise_reduction: nil,
          # Configuration for input audio transcription. The client can optionally set the
          # language and prompt for transcription, these offer additional guidance to the
          # transcription service.
          input_audio_transcription: nil,
          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          turn_detection: nil,
          # The type of session to create. Always `transcription` for transcription
          # sessions.
          type: :transcription
        )
        end

        sig do
          override.returns(
            {
              model:
                T.any(
                  String,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::OrSymbol
                ),
              type: Symbol,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
                ],
              input_audio_format:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::OrSymbol,
              input_audio_noise_reduction:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction,
              input_audio_transcription:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription,
              turn_detection:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection
            }
          )
        end
        def to_hash
        end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WHISPER_1 =
            T.let(
              :"whisper-1",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_TRANSCRIBE =
            T.let(
              :"gpt-4o-transcribe",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::TaggedSymbol
            )
          GPT_4O_MINI_TRANSCRIBE =
            T.let(
              :"gpt-4o-mini-transcribe",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Model::TaggedSymbol
            )
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
        # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
        # (mono), and little-endian byte order.
        module InputAudioFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          PCM16 =
            T.let(
              :pcm16,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::TaggedSymbol
            )
          G711_ULAW =
            T.let(
              :g711_ulaw,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::TaggedSymbol
            )
          G711_ALAW =
            T.let(
              :g711_alaw,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioFormat::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class InputAudioNoiseReduction < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction,
                OpenAI::Internal::AnyHash
              )
            end

          # Type of noise reduction. `near_field` is for close-talking microphones such as
          # headphones, `far_field` is for far-field microphones such as laptop or
          # conference room microphones.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::OrSymbol
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
              type:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::OrSymbol
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
              {
                type:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Type of noise reduction. `near_field` is for close-talking microphones such as
          # headphones, `far_field` is for far-field microphones such as laptop or
          # conference room microphones.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NEAR_FIELD =
              T.let(
                :near_field,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::TaggedSymbol
              )
            FAR_FIELD =
              T.let(
                :far_field,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioNoiseReduction::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class InputAudioTranscription < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription,
                OpenAI::Internal::AnyHash
              )
            end

          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          sig { returns(T.nilable(String)) }
          attr_reader :language

          sig { params(language: String).void }
          attr_writer :language

          # The model to use for transcription, current options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::OrSymbol
              )
            )
          end
          attr_reader :model

          sig do
            params(
              model:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::OrSymbol
            ).void
          end
          attr_writer :model

          # An optional text to guide the model's style or continue a previous audio
          # segment. For `whisper-1`, the
          # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
          # For `gpt-4o-transcribe` models, the prompt is a free text string, for example
          # "expect words related to technology".
          sig { returns(T.nilable(String)) }
          attr_reader :prompt

          sig { params(prompt: String).void }
          attr_writer :prompt

          # Configuration for input audio transcription. The client can optionally set the
          # language and prompt for transcription, these offer additional guidance to the
          # transcription service.
          sig do
            params(
              language: String,
              model:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::OrSymbol,
              prompt: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The language of the input audio. Supplying the input language in
            # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
            # format will improve accuracy and latency.
            language: nil,
            # The model to use for transcription, current options are `gpt-4o-transcribe`,
            # `gpt-4o-mini-transcribe`, and `whisper-1`.
            model: nil,
            # An optional text to guide the model's style or continue a previous audio
            # segment. For `whisper-1`, the
            # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
            # For `gpt-4o-transcribe` models, the prompt is a free text string, for example
            # "expect words related to technology".
            prompt: nil
          )
          end

          sig do
            override.returns(
              {
                language: String,
                model:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::OrSymbol,
                prompt: String
              }
            )
          end
          def to_hash
          end

          # The model to use for transcription, current options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, and `whisper-1`.
          module Model
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            GPT_4O_TRANSCRIBE =
              T.let(
                :"gpt-4o-transcribe",
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::TaggedSymbol
              )
            GPT_4O_MINI_TRANSCRIBE =
              T.let(
                :"gpt-4o-mini-transcribe",
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::TaggedSymbol
              )
            WHISPER_1 =
              T.let(
                :"whisper-1",
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::InputAudioTranscription::Model::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class TurnDetection < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection,
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

          # Type of turn detection. Only `server_vad` is currently supported for
          # transcription sessions.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::OrSymbol
            ).void
          end
          attr_writer :type

          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          sig do
            params(
              prefix_padding_ms: Integer,
              silence_duration_ms: Integer,
              threshold: Float,
              type:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::OrSymbol
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
            # Type of turn detection. Only `server_vad` is currently supported for
            # transcription sessions.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float,
                type:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Type of turn detection. Only `server_vad` is currently supported for
          # transcription sessions.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SERVER_VAD =
              T.let(
                :server_vad,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::TurnDetection::Type::TaggedSymbol
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
end

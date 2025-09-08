# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdate < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::TranscriptionSessionUpdate,
              OpenAI::Internal::AnyHash
            )
          end

        # Realtime transcription session object configuration.
        sig { returns(OpenAI::Realtime::TranscriptionSessionUpdate::Session) }
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::TranscriptionSessionUpdate::Session::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `transcription_session.update`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to update a transcription session.
        sig do
          params(
            session:
              OpenAI::Realtime::TranscriptionSessionUpdate::Session::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Realtime transcription session object configuration.
          session:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `transcription_session.update`.
          type: :"transcription_session.update"
        )
        end

        sig do
          override.returns(
            {
              session: OpenAI::Realtime::TranscriptionSessionUpdate::Session,
              type: Symbol,
              event_id: String
            }
          )
        end
        def to_hash
        end

        class Session < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::TranscriptionSessionUpdate::Session,
                OpenAI::Internal::AnyHash
              )
            end

          # The set of items to include in the transcription. Current available items are:
          # `item.input_audio_transcription.logprobs`
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::OrSymbol
                ]
              )
            )
          end
          attr_reader :include

          sig do
            params(
              include:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::OrSymbol
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
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::OrSymbol
              )
            )
          end
          attr_reader :input_audio_format

          sig do
            params(
              input_audio_format:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::OrSymbol
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
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction
              )
            )
          end
          attr_reader :input_audio_noise_reduction

          sig do
            params(
              input_audio_noise_reduction:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction::OrHash
            ).void
          end
          attr_writer :input_audio_noise_reduction

          # Configuration for input audio transcription. The client can optionally set the
          # language and prompt for transcription, these offer additional guidance to the
          # transcription service.
          sig { returns(T.nilable(OpenAI::Realtime::AudioTranscription)) }
          attr_reader :input_audio_transcription

          sig do
            params(
              input_audio_transcription:
                OpenAI::Realtime::AudioTranscription::OrHash
            ).void
          end
          attr_writer :input_audio_transcription

          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection
              )
            )
          end
          attr_reader :turn_detection

          sig do
            params(
              turn_detection:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::OrHash
            ).void
          end
          attr_writer :turn_detection

          # Realtime transcription session object configuration.
          sig do
            params(
              include:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::OrSymbol
                ],
              input_audio_format:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::OrSymbol,
              input_audio_noise_reduction:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction::OrHash,
              input_audio_transcription:
                OpenAI::Realtime::AudioTranscription::OrHash,
              turn_detection:
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The set of items to include in the transcription. Current available items are:
            # `item.input_audio_transcription.logprobs`
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
            turn_detection: nil
          )
          end

          sig do
            override.returns(
              {
                include:
                  T::Array[
                    OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::OrSymbol
                  ],
                input_audio_format:
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::OrSymbol,
                input_audio_noise_reduction:
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction,
                input_audio_transcription: OpenAI::Realtime::AudioTranscription,
                turn_detection:
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection
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
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
              T.let(
                :"item.input_audio_transcription.logprobs",
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include::TaggedSymbol
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
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PCM16 =
              T.let(
                :pcm16,
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::TaggedSymbol
              )
            G711_ULAW =
              T.let(
                :g711_ulaw,
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::TaggedSymbol
              )
            G711_ALAW =
              T.let(
                :g711_alaw,
                OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat::TaggedSymbol
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
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction,
                  OpenAI::Internal::AnyHash
                )
              end

            # Type of noise reduction. `near_field` is for close-talking microphones such as
            # headphones, `far_field` is for far-field microphones such as laptop or
            # conference room microphones.
            sig do
              returns(T.nilable(OpenAI::Realtime::NoiseReductionType::OrSymbol))
            end
            attr_reader :type

            sig do
              params(type: OpenAI::Realtime::NoiseReductionType::OrSymbol).void
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
                { type: OpenAI::Realtime::NoiseReductionType::OrSymbol }
              )
            end
            def to_hash
            end
          end

          class TurnDetection < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection,
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
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::OrSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::OrSymbol
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
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::OrSymbol
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
                    OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::OrSymbol
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
                    OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              SERVER_VAD =
                T.let(
                  :server_vad,
                  OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type::TaggedSymbol
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
end

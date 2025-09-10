# typed: strong

module OpenAI
  module Models
    RealtimeTranscriptionSessionCreateResponse =
      Realtime::RealtimeTranscriptionSessionCreateResponse

    module Realtime
      class RealtimeTranscriptionSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique identifier for the session that looks like `sess_1234567890abcdef`.
        sig { returns(String) }
        attr_accessor :id

        # The object type. Always `realtime.transcription_session`.
        sig { returns(String) }
        attr_accessor :object

        # The type of session. Always `transcription` for transcription sessions.
        sig { returns(Symbol) }
        attr_accessor :type

        # Configuration for input audio for the session.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio
            )
          )
        end
        attr_reader :audio

        sig do
          params(
            audio:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::OrHash
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
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::TaggedSymbol
              ]
            )
          )
        end
        attr_reader :include

        sig do
          params(
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::OrSymbol
              ]
          ).void
        end
        attr_writer :include

        # A Realtime transcription session configuration object.
        sig do
          params(
            id: String,
            object: String,
            audio:
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::OrHash,
            expires_at: Integer,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::OrSymbol
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the session that looks like `sess_1234567890abcdef`.
          id:,
          # The object type. Always `realtime.transcription_session`.
          object:,
          # Configuration for input audio for the session.
          audio: nil,
          # Expiration timestamp for the session, in seconds since epoch.
          expires_at: nil,
          # Additional fields to include in server outputs.
          #
          # - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          #   transcription.
          include: nil,
          # The type of session. Always `transcription` for transcription sessions.
          type: :transcription
        )
        end

        sig do
          override.returns(
            {
              id: String,
              object: String,
              type: Symbol,
              audio:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio,
              expires_at: Integer,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::TaggedSymbol
                ]
            }
          )
        end
        def to_hash
        end

        class Audio < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input
              )
            )
          end
          attr_reader :input

          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::OrHash
            ).void
          end
          attr_writer :input

          # Configuration for input audio for the session.
          sig do
            params(
              input:
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::OrHash
            ).returns(T.attached_class)
          end
          def self.new(input: nil)
          end

          sig do
            override.returns(
              {
                input:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input
              }
            )
          end
          def to_hash
          end

          class Input < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input,
                  OpenAI::Internal::AnyHash
                )
              end

            # The PCM audio format. Only a 24kHz sample rate is supported.
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

            # Configuration for input audio noise reduction.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction
                )
              )
            end
            attr_reader :noise_reduction

            sig do
              params(
                noise_reduction:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction::OrHash
              ).void
            end
            attr_writer :noise_reduction

            # Configuration of the transcription model.
            sig { returns(T.nilable(OpenAI::Realtime::AudioTranscription)) }
            attr_reader :transcription

            sig do
              params(
                transcription: OpenAI::Realtime::AudioTranscription::OrHash
              ).void
            end
            attr_writer :transcription

            # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
            # means that the model will detect the start and end of speech based on audio
            # volume and respond at the end of user speech.
            sig do
              returns(
                T.nilable(
                  OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection
                )
              )
            end
            attr_reader :turn_detection

            sig do
              params(
                turn_detection:
                  OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection::OrHash
              ).void
            end
            attr_writer :turn_detection

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                    OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
                  ),
                noise_reduction:
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction::OrHash,
                transcription: OpenAI::Realtime::AudioTranscription::OrHash,
                turn_detection:
                  OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The PCM audio format. Only a 24kHz sample rate is supported.
              format_: nil,
              # Configuration for input audio noise reduction.
              noise_reduction: nil,
              # Configuration of the transcription model.
              transcription: nil,
              # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
              # means that the model will detect the start and end of speech based on audio
              # volume and respond at the end of user speech.
              turn_detection: nil
            )
            end

            sig do
              override.returns(
                {
                  format_: OpenAI::Realtime::RealtimeAudioFormats::Variants,
                  noise_reduction:
                    OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction,
                  transcription: OpenAI::Realtime::AudioTranscription,
                  turn_detection:
                    OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection
                }
              )
            end
            def to_hash
            end

            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction,
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

              # Configuration for input audio noise reduction.
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
          end
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include::TaggedSymbol
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

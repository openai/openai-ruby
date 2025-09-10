# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # A new Realtime transcription session configuration.
        #
        # When a session is created on the server via REST API, the session object also
        # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        # not present when a session is updated via the WebSocket API.
        sig do
          returns(OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::OrHash
          ).void
        end
        attr_writer :session

        # The event type, must be `transcription_session.updated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a transcription session is updated with a
        # `transcription_session.update` event, unless there is an error.
        sig do
          params(
            event_id: String,
            session:
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # A new Realtime transcription session configuration.
          #
          # When a session is created on the server via REST API, the session object also
          # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
          # not present when a session is updated via the WebSocket API.
          session:,
          # The event type, must be `transcription_session.updated`.
          type: :"transcription_session.updated"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              session:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Session < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session,
                OpenAI::Internal::AnyHash
              )
            end

          # Ephemeral key returned by the API. Only present when the session is created on
          # the server via REST API.
          sig do
            returns(
              OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret
            )
          end
          attr_reader :client_secret

          sig do
            params(
              client_secret:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret::OrHash
            ).void
          end
          attr_writer :client_secret

          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          sig { returns(T.nilable(String)) }
          attr_reader :input_audio_format

          sig { params(input_audio_format: String).void }
          attr_writer :input_audio_format

          # Configuration of the transcription model.
          sig { returns(T.nilable(OpenAI::Realtime::AudioTranscription)) }
          attr_reader :input_audio_transcription

          sig do
            params(
              input_audio_transcription:
                OpenAI::Realtime::AudioTranscription::OrHash
            ).void
          end
          attr_writer :input_audio_transcription

          # The set of modalities the model can respond with. To disable audio, set this to
          # ["text"].
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::OrSymbol
                ]
              )
            )
          end
          attr_reader :modalities

          sig do
            params(
              modalities:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::OrSymbol
                ]
            ).void
          end
          attr_writer :modalities

          # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          # means that the model will detect the start and end of speech based on audio
          # volume and respond at the end of user speech.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection
              )
            )
          end
          attr_reader :turn_detection

          sig do
            params(
              turn_detection:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection::OrHash
            ).void
          end
          attr_writer :turn_detection

          # A new Realtime transcription session configuration.
          #
          # When a session is created on the server via REST API, the session object also
          # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
          # not present when a session is updated via the WebSocket API.
          sig do
            params(
              client_secret:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret::OrHash,
              input_audio_format: String,
              input_audio_transcription:
                OpenAI::Realtime::AudioTranscription::OrHash,
              modalities:
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::OrSymbol
                ],
              turn_detection:
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Ephemeral key returned by the API. Only present when the session is created on
            # the server via REST API.
            client_secret:,
            # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
            input_audio_format: nil,
            # Configuration of the transcription model.
            input_audio_transcription: nil,
            # The set of modalities the model can respond with. To disable audio, set this to
            # ["text"].
            modalities: nil,
            # Configuration for turn detection. Can be set to `null` to turn off. Server VAD
            # means that the model will detect the start and end of speech based on audio
            # volume and respond at the end of user speech.
            turn_detection: nil
          )
          end

          sig do
            override.returns(
              {
                client_secret:
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret,
                input_audio_format: String,
                input_audio_transcription: OpenAI::Realtime::AudioTranscription,
                modalities:
                  T::Array[
                    OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::OrSymbol
                  ],
                turn_detection:
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection
              }
            )
          end
          def to_hash
          end

          class ClientSecret < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret,
                  OpenAI::Internal::AnyHash
                )
              end

            # Timestamp for when the token expires. Currently, all tokens expire after one
            # minute.
            sig { returns(Integer) }
            attr_accessor :expires_at

            # Ephemeral key usable in client environments to authenticate connections to the
            # Realtime API. Use this in client-side environments rather than a standard API
            # token, which should only be used server-side.
            sig { returns(String) }
            attr_accessor :value

            # Ephemeral key returned by the API. Only present when the session is created on
            # the server via REST API.
            sig do
              params(expires_at: Integer, value: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # Timestamp for when the token expires. Currently, all tokens expire after one
              # minute.
              expires_at:,
              # Ephemeral key usable in client environments to authenticate connections to the
              # Realtime API. Use this in client-side environments rather than a standard API
              # token, which should only be used server-side.
              value:
            )
            end

            sig { override.returns({ expires_at: Integer, value: String }) }
            def to_hash
            end
          end

          module Modality
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TEXT =
              T.let(
                :text,
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::TaggedSymbol
              )
            AUDIO =
              T.let(
                :audio,
                OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class TurnDetection < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection,
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
end

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

        # Ephemeral key returned by the API. Only present when the session is created on
        # the server via REST API.
        sig do
          returns(OpenAI::Realtime::RealtimeTranscriptionSessionClientSecret)
        end
        attr_reader :client_secret

        sig do
          params(
            client_secret:
              OpenAI::Realtime::RealtimeTranscriptionSessionClientSecret::OrHash
          ).void
        end
        attr_writer :client_secret

        # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        sig { returns(T.nilable(String)) }
        attr_reader :input_audio_format

        sig { params(input_audio_format: String).void }
        attr_writer :input_audio_format

        # Configuration of the transcription model.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranscriptionSessionInputAudioTranscription
            )
          )
        end
        attr_reader :input_audio_transcription

        sig do
          params(
            input_audio_transcription:
              OpenAI::Realtime::RealtimeTranscriptionSessionInputAudioTranscription::OrHash
          ).void
        end
        attr_writer :input_audio_transcription

        # The set of modalities the model can respond with. To disable audio, set this to
        # ["text"].
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::TaggedSymbol
              ]
            )
          )
        end
        attr_reader :modalities

        sig do
          params(
            modalities:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::OrSymbol
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

        # A new Realtime transcription session configuration.
        #
        # When a session is created on the server via REST API, the session object also
        # contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        # not present when a session is updated via the WebSocket API.
        sig do
          params(
            client_secret:
              OpenAI::Realtime::RealtimeTranscriptionSessionClientSecret::OrHash,
            input_audio_format: String,
            input_audio_transcription:
              OpenAI::Realtime::RealtimeTranscriptionSessionInputAudioTranscription::OrHash,
            modalities:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::OrSymbol
              ],
            turn_detection:
              OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection::OrHash
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
                OpenAI::Realtime::RealtimeTranscriptionSessionClientSecret,
              input_audio_format: String,
              input_audio_transcription:
                OpenAI::Realtime::RealtimeTranscriptionSessionInputAudioTranscription,
              modalities:
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::TaggedSymbol
                ],
              turn_detection:
                OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection
            }
          )
        end
        def to_hash
        end

        module Modality
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::TaggedSymbol
            )
          AUDIO =
            T.let(
              :audio,
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality::TaggedSymbol
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

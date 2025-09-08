# typed: strong

module OpenAI
  module Models
    RealtimeTranscriptionSessionTurnDetection =
      Realtime::RealtimeTranscriptionSessionTurnDetection

    module Realtime
      class RealtimeTranscriptionSessionTurnDetection < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection,
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

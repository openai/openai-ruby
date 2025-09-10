# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   A new Realtime transcription session configuration.
        #
        #   When a session is created on the server via REST API, the session object also
        #   contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        #   not present when a session is updated via the WebSocket API.
        #
        #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session]
        required :session, -> { OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session }

        # @!attribute type
        #   The event type, must be `transcription_session.updated`.
        #
        #   @return [Symbol, :"transcription_session.updated"]
        required :type, const: :"transcription_session.updated"

        # @!method initialize(event_id:, session:, type: :"transcription_session.updated")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent} for more details.
        #
        #   Returned when a transcription session is updated with a
        #   `transcription_session.update` event, unless there is an error.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session] A new Realtime transcription session configuration.
        #
        #   @param type [Symbol, :"transcription_session.updated"] The event type, must be `transcription_session.updated`.

        # @see OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent#session
        class Session < OpenAI::Internal::Type::BaseModel
          # @!attribute client_secret
          #   Ephemeral key returned by the API. Only present when the session is created on
          #   the server via REST API.
          #
          #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret]
          required :client_secret, -> { OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret }

          # @!attribute input_audio_format
          #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @return [String, nil]
          optional :input_audio_format, String

          # @!attribute input_audio_transcription
          #   Configuration of the transcription model.
          #
          #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
          optional :input_audio_transcription, -> { OpenAI::Realtime::AudioTranscription }

          # @!attribute modalities
          #   The set of modalities the model can respond with. To disable audio, set this to
          #   ["text"].
          #
          #   @return [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality>, nil]
          optional :modalities,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality] }

          # @!attribute turn_detection
          #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          #   means that the model will detect the start and end of speech based on audio
          #   volume and respond at the end of user speech.
          #
          #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection, nil]
          optional :turn_detection,
                   -> { OpenAI::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection }

          # @!method initialize(client_secret:, input_audio_format: nil, input_audio_transcription: nil, modalities: nil, turn_detection: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session} for more
          #   details.
          #
          #   A new Realtime transcription session configuration.
          #
          #   When a session is created on the server via REST API, the session object also
          #   contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
          #   not present when a session is updated via the WebSocket API.
          #
          #   @param client_secret [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret] Ephemeral key returned by the API. Only present when the session is
          #
          #   @param input_audio_format [String] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @param input_audio_transcription [OpenAI::Models::Realtime::AudioTranscription] Configuration of the transcription model.
          #
          #   @param modalities [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::Modality>] The set of modalities the model can respond with. To disable audio,
          #
          #   @param turn_detection [OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server

          # @see OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session#client_secret
          class ClientSecret < OpenAI::Internal::Type::BaseModel
            # @!attribute expires_at
            #   Timestamp for when the token expires. Currently, all tokens expire after one
            #   minute.
            #
            #   @return [Integer]
            required :expires_at, Integer

            # @!attribute value
            #   Ephemeral key usable in client environments to authenticate connections to the
            #   Realtime API. Use this in client-side environments rather than a standard API
            #   token, which should only be used server-side.
            #
            #   @return [String]
            required :value, String

            # @!method initialize(expires_at:, value:)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::ClientSecret}
            #   for more details.
            #
            #   Ephemeral key returned by the API. Only present when the session is created on
            #   the server via REST API.
            #
            #   @param expires_at [Integer] Timestamp for when the token expires. Currently, all tokens expire
            #
            #   @param value [String] Ephemeral key usable in client environments to authenticate connections
          end

          module Modality
            extend OpenAI::Internal::Type::Enum

            TEXT = :text
            AUDIO = :audio

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session#turn_detection
          class TurnDetection < OpenAI::Internal::Type::BaseModel
            # @!attribute prefix_padding_ms
            #   Amount of audio to include before the VAD detected speech (in milliseconds).
            #   Defaults to 300ms.
            #
            #   @return [Integer, nil]
            optional :prefix_padding_ms, Integer

            # @!attribute silence_duration_ms
            #   Duration of silence to detect speech stop (in milliseconds). Defaults to 500ms.
            #   With shorter values the model will respond more quickly, but may jump in on
            #   short pauses from the user.
            #
            #   @return [Integer, nil]
            optional :silence_duration_ms, Integer

            # @!attribute threshold
            #   Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A higher
            #   threshold will require louder audio to activate the model, and thus might
            #   perform better in noisy environments.
            #
            #   @return [Float, nil]
            optional :threshold, Float

            # @!attribute type
            #   Type of turn detection, only `server_vad` is currently supported.
            #
            #   @return [String, nil]
            optional :type, String

            # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::TranscriptionSessionUpdatedEvent::Session::TurnDetection}
            #   for more details.
            #
            #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
            #   means that the model will detect the start and end of speech based on audio
            #   volume and respond at the end of user speech.
            #
            #   @param prefix_padding_ms [Integer] Amount of audio to include before the VAD detected speech (in
            #
            #   @param silence_duration_ms [Integer] Duration of silence to detect speech stop (in milliseconds). Defaults
            #
            #   @param threshold [Float] Activation threshold for VAD (0.0 to 1.0), this defaults to 0.5. A
            #
            #   @param type [String] Type of turn detection, only `server_vad` is currently supported.
          end
        end
      end
    end
  end
end

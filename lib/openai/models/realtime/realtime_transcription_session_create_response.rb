# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute client_secret
        #   Ephemeral key returned by the API. Only present when the session is created on
        #   the server via REST API.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionClientSecret]
        required :client_secret, -> { OpenAI::Realtime::RealtimeTranscriptionSessionClientSecret }

        # @!attribute input_audio_format
        #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #
        #   @return [String, nil]
        optional :input_audio_format, String

        # @!attribute input_audio_transcription
        #   Configuration of the transcription model.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionInputAudioTranscription, nil]
        optional :input_audio_transcription,
                 -> { OpenAI::Realtime::RealtimeTranscriptionSessionInputAudioTranscription }

        # @!attribute modalities
        #   The set of modalities the model can respond with. To disable audio, set this to
        #   ["text"].
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality>, nil]
        optional :modalities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality] }

        # @!attribute turn_detection
        #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
        #   means that the model will detect the start and end of speech based on audio
        #   volume and respond at the end of user speech.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionTurnDetection, nil]
        optional :turn_detection, -> { OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection }

        # @!method initialize(client_secret:, input_audio_format: nil, input_audio_transcription: nil, modalities: nil, turn_detection: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse} for more
        #   details.
        #
        #   A new Realtime transcription session configuration.
        #
        #   When a session is created on the server via REST API, the session object also
        #   contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        #   not present when a session is updated via the WebSocket API.
        #
        #   @param client_secret [OpenAI::Models::Realtime::RealtimeTranscriptionSessionClientSecret] Ephemeral key returned by the API. Only present when the session is
        #
        #   @param input_audio_format [String] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
        #
        #   @param input_audio_transcription [OpenAI::Models::Realtime::RealtimeTranscriptionSessionInputAudioTranscription] Configuration of the transcription model.
        #
        #   @param modalities [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Modality>] The set of modalities the model can respond with. To disable audio,
        #
        #   @param turn_detection [OpenAI::Models::Realtime::RealtimeTranscriptionSessionTurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server

        module Modality
          extend OpenAI::Internal::Type::Enum

          TEXT = :text
          AUDIO = :audio

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    RealtimeTranscriptionSessionCreateResponse = Realtime::RealtimeTranscriptionSessionCreateResponse
  end
end

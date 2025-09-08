# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionTurnDetection < OpenAI::Internal::Type::BaseModel
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
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionTurnDetection} for more
        #   details.
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

    RealtimeTranscriptionSessionTurnDetection = Realtime::RealtimeTranscriptionSessionTurnDetection
  end
end

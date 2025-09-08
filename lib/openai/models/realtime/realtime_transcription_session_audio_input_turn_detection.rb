# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionAudioInputTurnDetection < OpenAI::Internal::Type::BaseModel
        # @!attribute create_response
        #   Whether or not to automatically generate a response when a VAD stop event
        #   occurs.
        #
        #   @return [Boolean, nil]
        optional :create_response, OpenAI::Internal::Type::Boolean

        # @!attribute eagerness
        #   Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
        #   will wait longer for the user to continue speaking, `high` will respond more
        #   quickly. `auto` is the default and is equivalent to `medium`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Eagerness, nil]
        optional :eagerness,
                 enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Eagerness }

        # @!attribute idle_timeout_ms
        #   Optional idle timeout after which turn detection will auto-timeout when no
        #   additional audio is received.
        #
        #   @return [Integer, nil]
        optional :idle_timeout_ms, Integer, nil?: true

        # @!attribute interrupt_response
        #   Whether or not to automatically interrupt any ongoing response with output to
        #   the default conversation (i.e. `conversation` of `auto`) when a VAD start event
        #   occurs.
        #
        #   @return [Boolean, nil]
        optional :interrupt_response, OpenAI::Internal::Type::Boolean

        # @!attribute prefix_padding_ms
        #   Used only for `server_vad` mode. Amount of audio to include before the VAD
        #   detected speech (in milliseconds). Defaults to 300ms.
        #
        #   @return [Integer, nil]
        optional :prefix_padding_ms, Integer

        # @!attribute silence_duration_ms
        #   Used only for `server_vad` mode. Duration of silence to detect speech stop (in
        #   milliseconds). Defaults to 500ms. With shorter values the model will respond
        #   more quickly, but may jump in on short pauses from the user.
        #
        #   @return [Integer, nil]
        optional :silence_duration_ms, Integer

        # @!attribute threshold
        #   Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
        #   defaults to 0.5. A higher threshold will require louder audio to activate the
        #   model, and thus might perform better in noisy environments.
        #
        #   @return [Float, nil]
        optional :threshold, Float

        # @!attribute type
        #   Type of turn detection.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Type, nil]
        optional :type, enum: -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Type }

        # @!method initialize(create_response: nil, eagerness: nil, idle_timeout_ms: nil, interrupt_response: nil, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection}
        #   for more details.
        #
        #   Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
        #   set to `null` to turn off, in which case the client must manually trigger model
        #   response. Server VAD means that the model will detect the start and end of
        #   speech based on audio volume and respond at the end of user speech. Semantic VAD
        #   is more advanced and uses a turn detection model (in conjunction with VAD) to
        #   semantically estimate whether the user has finished speaking, then dynamically
        #   sets a timeout based on this probability. For example, if user audio trails off
        #   with "uhhm", the model will score a low probability of turn end and wait longer
        #   for the user to continue speaking. This can be useful for more natural
        #   conversations, but may have a higher latency.
        #
        #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
        #
        #   @param eagerness [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Eagerness] Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
        #
        #   @param idle_timeout_ms [Integer, nil] Optional idle timeout after which turn detection will auto-timeout when
        #
        #   @param interrupt_response [Boolean] Whether or not to automatically interrupt any ongoing response with output to th
        #
        #   @param prefix_padding_ms [Integer] Used only for `server_vad` mode. Amount of audio to include before the VAD detec
        #
        #   @param silence_duration_ms [Integer] Used only for `server_vad` mode. Duration of silence to detect speech stop (in m
        #
        #   @param threshold [Float] Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
        #
        #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Type] Type of turn detection.

        # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
        # will wait longer for the user to continue speaking, `high` will respond more
        # quickly. `auto` is the default and is equivalent to `medium`.
        #
        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection#eagerness
        module Eagerness
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high
          AUTO = :auto

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Type of turn detection.
        #
        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection#type
        module Type
          extend OpenAI::Internal::Type::Enum

          SERVER_VAD = :server_vad
          SEMANTIC_VAD = :semantic_vad

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

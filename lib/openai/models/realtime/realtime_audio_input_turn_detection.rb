# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
      # set to `null` to turn off, in which case the client must manually trigger model
      # response.
      #
      # Server VAD means that the model will detect the start and end of speech based on
      # audio volume and respond at the end of user speech.
      #
      # Semantic VAD is more advanced and uses a turn detection model (in conjunction
      # with VAD) to semantically estimate whether the user has finished speaking, then
      # dynamically sets a timeout based on this probability. For example, if user audio
      # trails off with "uhhm", the model will score a low probability of turn end and
      # wait longer for the user to continue speaking. This can be useful for more
      # natural conversations, but may have a higher latency.
      module RealtimeAudioInputTurnDetection
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Server-side voice activity detection (VAD) which flips on when user speech is detected and off after a period of silence.
        variant :server_vad, -> { OpenAI::Realtime::RealtimeAudioInputTurnDetection::ServerVad }

        # Server-side semantic turn detection which uses a model to determine when the user has finished speaking.
        variant :semantic_vad, -> { OpenAI::Realtime::RealtimeAudioInputTurnDetection::SemanticVad }

        class ServerVad < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Type of turn detection, `server_vad` to turn on simple Server VAD.
          #
          #   @return [Symbol, :server_vad]
          required :type, const: :server_vad

          # @!attribute create_response
          #   Whether or not to automatically generate a response when a VAD stop event
          #   occurs. If `interrupt_response` is set to `false` this may fail to create a
          #   response if the model is already responding.
          #
          #   If both `create_response` and `interrupt_response` are set to `false`, the model
          #   will never respond automatically but VAD events will still be emitted.
          #
          #   @return [Boolean, nil]
          optional :create_response, OpenAI::Internal::Type::Boolean

          # @!attribute idle_timeout_ms
          #   Optional timeout after which a model response will be triggered automatically.
          #   This is useful for situations in which a long pause from the user is unexpected,
          #   such as a phone call. The model will effectively prompt the user to continue the
          #   conversation based on the current context.
          #
          #   The timeout value will be applied after the last model response's audio has
          #   finished playing, i.e. it's set to the `response.done` time plus audio playback
          #   duration.
          #
          #   An `input_audio_buffer.timeout_triggered` event (plus events associated with the
          #   Response) will be emitted when the timeout is reached. Idle timeout is currently
          #   only supported for `server_vad` mode.
          #
          #   @return [Integer, nil]
          optional :idle_timeout_ms, Integer, nil?: true

          # @!attribute interrupt_response
          #   Whether or not to automatically interrupt (cancel) any ongoing response with
          #   output to the default conversation (i.e. `conversation` of `auto`) when a VAD
          #   start event occurs. If `true` then the response will be cancelled, otherwise it
          #   will continue until complete.
          #
          #   If both `create_response` and `interrupt_response` are set to `false`, the model
          #   will never respond automatically but VAD events will still be emitted.
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

          # @!method initialize(create_response: nil, idle_timeout_ms: nil, interrupt_response: nil, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: :server_vad)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::ServerVad} for more
          #   details.
          #
          #   Server-side voice activity detection (VAD) which flips on when user speech is
          #   detected and off after a period of silence.
          #
          #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
          #
          #   @param idle_timeout_ms [Integer, nil] Optional timeout after which a model response will be triggered automatically. T
          #
          #   @param interrupt_response [Boolean] Whether or not to automatically interrupt (cancel) any ongoing response with out
          #
          #   @param prefix_padding_ms [Integer] Used only for `server_vad` mode. Amount of audio to include before the VAD detec
          #
          #   @param silence_duration_ms [Integer] Used only for `server_vad` mode. Duration of silence to detect speech stop (in m
          #
          #   @param threshold [Float] Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
          #
          #   @param type [Symbol, :server_vad] Type of turn detection, `server_vad` to turn on simple Server VAD.
        end

        class SemanticVad < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Type of turn detection, `semantic_vad` to turn on Semantic VAD.
          #
          #   @return [Symbol, :semantic_vad]
          required :type, const: :semantic_vad

          # @!attribute create_response
          #   Whether or not to automatically generate a response when a VAD stop event
          #   occurs.
          #
          #   @return [Boolean, nil]
          optional :create_response, OpenAI::Internal::Type::Boolean

          # @!attribute eagerness
          #   Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
          #   will wait longer for the user to continue speaking, `high` will respond more
          #   quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
          #   and `high` have max timeouts of 8s, 4s, and 2s respectively.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::SemanticVad::Eagerness, nil]
          optional :eagerness,
                   enum: -> { OpenAI::Realtime::RealtimeAudioInputTurnDetection::SemanticVad::Eagerness }

          # @!attribute interrupt_response
          #   Whether or not to automatically interrupt any ongoing response with output to
          #   the default conversation (i.e. `conversation` of `auto`) when a VAD start event
          #   occurs.
          #
          #   @return [Boolean, nil]
          optional :interrupt_response, OpenAI::Internal::Type::Boolean

          # @!method initialize(create_response: nil, eagerness: nil, interrupt_response: nil, type: :semantic_vad)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::SemanticVad} for
          #   more details.
          #
          #   Server-side semantic turn detection which uses a model to determine when the
          #   user has finished speaking.
          #
          #   @param create_response [Boolean] Whether or not to automatically generate a response when a VAD stop event occurs
          #
          #   @param eagerness [Symbol, OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::SemanticVad::Eagerness] Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
          #
          #   @param interrupt_response [Boolean] Whether or not to automatically interrupt any ongoing response with output to th
          #
          #   @param type [Symbol, :semantic_vad] Type of turn detection, `semantic_vad` to turn on Semantic VAD.

          # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
          # will wait longer for the user to continue speaking, `high` will respond more
          # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
          # and `high` have max timeouts of 8s, 4s, and 2s respectively.
          #
          # @see OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::SemanticVad#eagerness
          module Eagerness
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::ServerVad, OpenAI::Models::Realtime::RealtimeAudioInputTurnDetection::SemanticVad)]
      end
    end
  end
end

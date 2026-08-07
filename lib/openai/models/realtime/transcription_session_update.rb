# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdate < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Realtime transcription session object configuration.
        #
        #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session]
        required :session, -> { OpenAI::Realtime::TranscriptionSessionUpdate::Session }

        # @!attribute type
        #   The event type, must be `transcription_session.update`.
        #
        #   @return [Symbol, :"transcription_session.update"]
        required :type, const: :"transcription_session.update"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(session:, event_id: nil, type: :"transcription_session.update")
        #   Send this event to update a transcription session.
        #
        #   @param session [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session] Realtime transcription session object configuration.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"transcription_session.update"] The event type, must be `transcription_session.update`.

        # @see OpenAI::Models::Realtime::TranscriptionSessionUpdate#session
        class Session < OpenAI::Internal::Type::BaseModel
          # @!attribute include
          #   The set of items to include in the transcription. Current available items are:
          #   `item.input_audio_transcription.logprobs`
          #
          #   @return [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::Include>, nil]
          optional :include,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::TranscriptionSessionUpdate::Session::Include] }

          # @!attribute input_audio_format
          #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          #   `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          #   (mono), and little-endian byte order.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat, nil]
          optional :input_audio_format,
                   enum: -> { OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat }

          # @!attribute input_audio_noise_reduction
          #   Configuration for input audio noise reduction. This can be set to `null` to turn
          #   off. Noise reduction filters audio added to the input audio buffer before it is
          #   sent to VAD and the model. Filtering the audio can improve VAD and turn
          #   detection accuracy (reducing false positives) and model performance by improving
          #   perception of the input audio.
          #
          #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction, nil]
          optional :input_audio_noise_reduction,
                   -> { OpenAI::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction }

          # @!attribute input_audio_transcription
          #   Configuration for input audio transcription. The client can optionally set the
          #   language and prompt for transcription, these offer additional guidance to the
          #   transcription service.
          #
          #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
          optional :input_audio_transcription, -> { OpenAI::Realtime::AudioTranscription }

          # @!attribute turn_detection
          #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
          #   means that the model will detect the start and end of speech based on audio
          #   volume and respond at the end of user speech.
          #
          #   @return [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection, nil]
          optional :turn_detection, -> { OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection }

          # @!method initialize(include: nil, input_audio_format: nil, input_audio_noise_reduction: nil, input_audio_transcription: nil, turn_detection: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session} for more
          #   details.
          #
          #   Realtime transcription session object configuration.
          #
          #   @param include [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::Include>] The set of items to include in the transcription. Current available items are:
          #
          #   @param input_audio_format [Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::InputAudioFormat] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
          #
          #   @param input_audio_noise_reduction [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
          #
          #   @param input_audio_transcription [OpenAI::Models::Realtime::AudioTranscription] Configuration for input audio transcription. The client can optionally set the l
          #
          #   @param turn_detection [OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server VAD m

          module Include
            extend OpenAI::Internal::Type::Enum

            ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. For
          # `pcm16`, input audio must be 16-bit PCM at a 24kHz sample rate, single channel
          # (mono), and little-endian byte order.
          #
          # @see OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session#input_audio_format
          module InputAudioFormat
            extend OpenAI::Internal::Type::Enum

            PCM16 = :pcm16
            G711_ULAW = :g711_ulaw
            G711_ALAW = :g711_alaw

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session#input_audio_noise_reduction
          class InputAudioNoiseReduction < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Type of noise reduction. `near_field` is for close-talking microphones such as
            #   headphones, `far_field` is for far-field microphones such as laptop or
            #   conference room microphones.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::NoiseReductionType, nil]
            optional :type, enum: -> { OpenAI::Realtime::NoiseReductionType }

            # @!method initialize(type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::InputAudioNoiseReduction}
            #   for more details.
            #
            #   Configuration for input audio noise reduction. This can be set to `null` to turn
            #   off. Noise reduction filters audio added to the input audio buffer before it is
            #   sent to VAD and the model. Filtering the audio can improve VAD and turn
            #   detection accuracy (reducing false positives) and model performance by improving
            #   perception of the input audio.
            #
            #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
          end

          # @see OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session#turn_detection
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
            #   Type of turn detection. Only `server_vad` is currently supported for
            #   transcription sessions.
            #
            #   @return [Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type, nil]
            optional :type, enum: -> { OpenAI::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type }

            # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection}
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
            #   @param type [Symbol, OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection::Type] Type of turn detection. Only `server_vad` is currently supported for transcripti

            # Type of turn detection. Only `server_vad` is currently supported for
            # transcription sessions.
            #
            # @see OpenAI::Models::Realtime::TranscriptionSessionUpdate::Session::TurnDetection#type
            module Type
              extend OpenAI::Internal::Type::Enum

              SERVER_VAD = :server_vad

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionAudioInput < OpenAI::Internal::Type::BaseModel
        # @!attribute format_
        #   The PCM audio format. Only a 24kHz sample rate is supported.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
        optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

        # @!attribute noise_reduction
        #   Configuration for input audio noise reduction. This can be set to `null` to turn
        #   off. Noise reduction filters audio added to the input audio buffer before it is
        #   sent to VAD and the model. Filtering the audio can improve VAD and turn
        #   detection accuracy (reducing false positives) and model performance by improving
        #   perception of the input audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput::NoiseReduction, nil]
        optional :noise_reduction, -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput::NoiseReduction }

        # @!attribute transcription
        #   Configuration for input audio transcription, defaults to off and can be set to
        #   `null` to turn off once on. Input audio transcription is not native to the
        #   model, since the model consumes audio directly. Transcription runs
        #   asynchronously through
        #   [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
        #   and should be treated as guidance of input audio content rather than precisely
        #   what the model heard. The client can optionally set the language and prompt for
        #   transcription, these offer additional guidance to the transcription service.
        #
        #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
        optional :transcription, -> { OpenAI::Realtime::AudioTranscription }

        # @!attribute turn_detection
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
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection, nil]
        optional :turn_detection, -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection }

        # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput} for more
        #   details.
        #
        #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The PCM audio format. Only a 24kHz sample rate is supported.
        #
        #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput::NoiseReduction] Configuration for input audio noise reduction. This can be set to `null` to turn
        #
        #   @param transcription [OpenAI::Models::Realtime::AudioTranscription] Configuration for input audio transcription, defaults to off and can be set to `
        #
        #   @param turn_detection [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection] Configuration for turn detection, ether Server VAD or Semantic VAD. This can be

        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput#noise_reduction
        class NoiseReduction < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Type of noise reduction. `near_field` is for close-talking microphones such as
          #   headphones, `far_field` is for far-field microphones such as laptop or
          #   conference room microphones.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::NoiseReductionType, nil]
          optional :type, enum: -> { OpenAI::Realtime::NoiseReductionType }

          # @!method initialize(type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput::NoiseReduction}
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
      end
    end
  end
end

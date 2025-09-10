# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @return [String]
        required :id, String

        # @!attribute object
        #   The object type. Always `realtime.transcription_session`.
        #
        #   @return [String]
        required :object, String

        # @!attribute type
        #   The type of session. Always `transcription` for transcription sessions.
        #
        #   @return [Symbol, :transcription]
        required :type, const: :transcription

        # @!attribute audio
        #   Configuration for input audio for the session.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio }

        # @!attribute expires_at
        #   Expiration timestamp for the session, in seconds since epoch.
        #
        #   @return [Integer, nil]
        optional :expires_at, Integer

        # @!attribute include
        #   Additional fields to include in server outputs.
        #
        #   - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #     transcription.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Include] }

        # @!method initialize(id:, object:, audio: nil, expires_at: nil, include: nil, type: :transcription)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse} for more
        #   details.
        #
        #   A Realtime transcription session configuration object.
        #
        #   @param id [String] Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @param object [String] The object type. Always `realtime.transcription_session`.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio] Configuration for input audio for the session.
        #
        #   @param expires_at [Integer] Expiration timestamp for the session, in seconds since epoch.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Include>] Additional fields to include in server outputs.
        #
        #   @param type [Symbol, :transcription] The type of session. Always `transcription` for transcription sessions.

        # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #
          #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input, nil]
          optional :input, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input }

          # @!method initialize(input: nil)
          #   Configuration for input audio for the session.
          #
          #   @param input [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input]

          # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio#input
          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute format_
            #   The PCM audio format. Only a 24kHz sample rate is supported.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA, nil]
            optional :format_, union: -> { OpenAI::Realtime::RealtimeAudioFormats }, api_name: :format

            # @!attribute noise_reduction
            #   Configuration for input audio noise reduction.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction, nil]
            optional :noise_reduction,
                     -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction }

            # @!attribute transcription
            #   Configuration of the transcription model.
            #
            #   @return [OpenAI::Models::Realtime::AudioTranscription, nil]
            optional :transcription, -> { OpenAI::Realtime::AudioTranscription }

            # @!attribute turn_detection
            #   Configuration for turn detection. Can be set to `null` to turn off. Server VAD
            #   means that the model will detect the start and end of speech based on audio
            #   volume and respond at the end of user speech.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionTurnDetection, nil]
            optional :turn_detection, -> { OpenAI::Realtime::RealtimeTranscriptionSessionTurnDetection }

            # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input}
            #   for more details.
            #
            #   @param format_ [OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCM, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMU, OpenAI::Models::Realtime::RealtimeAudioFormats::AudioPCMA] The PCM audio format. Only a 24kHz sample rate is supported.
            #
            #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction] Configuration for input audio noise reduction.
            #
            #   @param transcription [OpenAI::Models::Realtime::AudioTranscription] Configuration of the transcription model.
            #
            #   @param turn_detection [OpenAI::Models::Realtime::RealtimeTranscriptionSessionTurnDetection] Configuration for turn detection. Can be set to `null` to turn off. Server

            # @see OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input#noise_reduction
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
              #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse::Audio::Input::NoiseReduction}
              #   for more details.
              #
              #   Configuration for input audio noise reduction.
              #
              #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
            end
          end
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    RealtimeTranscriptionSessionCreateResponse = Realtime::RealtimeTranscriptionSessionCreateResponse
  end
end

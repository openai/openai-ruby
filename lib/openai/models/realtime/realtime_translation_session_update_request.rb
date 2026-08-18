# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionUpdateRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Configuration for translation input and output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio }

        # @!method initialize(audio: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest} for more
        #   details.
        #
        #   Realtime translation session fields that can be updated with `session.update`.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio] Configuration for translation input and output audio.

        # @see OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #
          #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input, nil]
          optional :input, -> { OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input }

          # @!attribute output
          #
          #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Output, nil]
          optional :output, -> { OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Output }

          # @!method initialize(input: nil, output: nil)
          #   Configuration for translation input and output audio.
          #
          #   @param input [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input]
          #   @param output [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Output]

          # @see OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio#input
          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute noise_reduction
            #   Optional input noise reduction. Set to `null` to disable it.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::NoiseReduction, nil]
            optional :noise_reduction,
                     -> {
                       OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::NoiseReduction
                     },
                     nil?: true

            # @!attribute transcription
            #   Optional source-language transcription. When configured, the server emits
            #   `session.input_transcript.delta` events. Translation itself still runs from the
            #   input audio stream.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::Transcription, nil]
            optional :transcription,
                     -> {
                       OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::Transcription
                     },
                     nil?: true

            # @!method initialize(noise_reduction: nil, transcription: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input}
            #   for more details.
            #
            #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::NoiseReduction, nil] Optional input noise reduction. Set to `null` to disable it.
            #
            #   @param transcription [OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::Transcription, nil] Optional source-language transcription. When configured, the server emits

            # @see OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input#noise_reduction
            class NoiseReduction < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   Type of noise reduction. `near_field` is for close-talking microphones such as
              #   headphones, `far_field` is for far-field microphones such as laptop or
              #   conference room microphones.
              #
              #   @return [Symbol, OpenAI::Models::Realtime::NoiseReductionType]
              required :type, enum: -> { OpenAI::Realtime::NoiseReductionType }

              # @!method initialize(type:)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input::NoiseReduction}
              #   for more details.
              #
              #   Optional input noise reduction. Set to `null` to disable it.
              #
              #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
            end

            # @see OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Input#transcription
            class Transcription < OpenAI::Internal::Type::BaseModel
              # @!attribute model
              #   The transcription model to use for source transcript deltas.
              #
              #   @return [String]
              required :model, String

              # @!method initialize(model:)
              #   Optional source-language transcription. When configured, the server emits
              #   `session.input_transcript.delta` events. Translation itself still runs from the
              #   input audio stream.
              #
              #   @param model [String] The transcription model to use for source transcript deltas.
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute language
            #   Target language for translated output audio and transcript deltas.
            #
            #   @return [String, nil]
            optional :language, String

            # @!method initialize(language: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::Output}
            #   for more details.
            #
            #   @param language [String] Target language for translated output audio and transcript deltas.
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSession < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @return [String]
        required :id, String

        # @!attribute audio
        #   Configuration for translation input and output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio]
        required :audio, -> { OpenAI::Realtime::RealtimeTranslationSession::Audio }

        # @!attribute expires_at
        #   Expiration timestamp for the session, in seconds since epoch.
        #
        #   @return [Integer]
        required :expires_at, Integer

        # @!attribute model
        #   The Realtime translation model used for this session. This field is set at
        #   session creation and cannot be changed with `session.update`.
        #
        #   @return [String]
        required :model, String

        # @!attribute type
        #   The session type. Always `translation` for Realtime translation sessions.
        #
        #   @return [Symbol, :translation]
        required :type, const: :translation

        # @!method initialize(id:, audio:, expires_at:, model:, type: :translation)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationSession} for more details.
        #
        #   A Realtime translation session. Translation sessions continuously translate
        #   input audio into the configured output language.
        #
        #   @param id [String] Unique identifier for the session that looks like `sess_1234567890abcdef`.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio] Configuration for translation input and output audio.
        #
        #   @param expires_at [Integer] Expiration timestamp for the session, in seconds since epoch.
        #
        #   @param model [String] The Realtime translation model used for this session. This field is set at
        #
        #   @param type [Symbol, :translation] The session type. Always `translation` for Realtime translation sessions.

        # @see OpenAI::Models::Realtime::RealtimeTranslationSession#audio
        class Audio < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #
          #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input, nil]
          optional :input, -> { OpenAI::Realtime::RealtimeTranslationSession::Audio::Input }

          # @!attribute output
          #
          #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Output, nil]
          optional :output, -> { OpenAI::Realtime::RealtimeTranslationSession::Audio::Output }

          # @!method initialize(input: nil, output: nil)
          #   Configuration for translation input and output audio.
          #
          #   @param input [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input]
          #   @param output [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Output]

          # @see OpenAI::Models::Realtime::RealtimeTranslationSession::Audio#input
          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute noise_reduction
            #   Optional input noise reduction.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction, nil]
            optional :noise_reduction,
                     -> { OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction },
                     nil?: true

            # @!attribute transcription
            #   Optional source-language transcription. When configured, the server emits
            #   `session.input_transcript.delta` events. Translation itself still runs from the
            #   input audio stream.
            #
            #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input::Transcription, nil]
            optional :transcription,
                     -> { OpenAI::Realtime::RealtimeTranslationSession::Audio::Input::Transcription },
                     nil?: true

            # @!method initialize(noise_reduction: nil, transcription: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input} for more
            #   details.
            #
            #   @param noise_reduction [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction, nil] Optional input noise reduction.
            #
            #   @param transcription [OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input::Transcription, nil] Optional source-language transcription. When configured, the server emits

            # @see OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input#noise_reduction
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
              #   {OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input::NoiseReduction}
              #   for more details.
              #
              #   Optional input noise reduction.
              #
              #   @param type [Symbol, OpenAI::Models::Realtime::NoiseReductionType] Type of noise reduction. `near_field` is for close-talking microphones such as h
            end

            # @see OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Input#transcription
            class Transcription < OpenAI::Internal::Type::BaseModel
              # @!attribute model
              #   The transcription model used for source transcript deltas.
              #
              #   @return [String]
              required :model, String

              # @!method initialize(model:)
              #   Optional source-language transcription. When configured, the server emits
              #   `session.input_transcript.delta` events. Translation itself still runs from the
              #   input audio stream.
              #
              #   @param model [String] The transcription model used for source transcript deltas.
            end
          end

          # @see OpenAI::Models::Realtime::RealtimeTranslationSession::Audio#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute language
            #   Target language for translated output audio and transcript deltas.
            #
            #   @return [String, nil]
            optional :language, String

            # @!method initialize(language: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Realtime::RealtimeTranslationSession::Audio::Output} for more
            #   details.
            #
            #   @param language [String] Target language for translated output audio and transcript deltas.
          end
        end
      end
    end
  end
end

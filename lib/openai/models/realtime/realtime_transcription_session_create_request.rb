# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of session to create. Always `transcription` for transcription
        #   sessions.
        #
        #   @return [Symbol, :transcription]
        required :type, const: :transcription

        # @!attribute audio
        #   Configuration for input and output audio.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudio, nil]
        optional :audio, -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudio }

        # @!attribute include
        #   Additional fields to include in server outputs.
        #
        #   `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        #   transcription.
        #
        #   @return [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Include>, nil]
        optional :include,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include] }

        # @!method initialize(audio: nil, include: nil, type: :transcription)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest} for more
        #   details.
        #
        #   Realtime transcription session object configuration.
        #
        #   @param audio [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudio] Configuration for input and output audio.
        #
        #   @param include [Array<Symbol, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest::Include>] Additional fields to include in server outputs.
        #
        #   @param type [Symbol, :transcription] The type of session to create. Always `transcription` for transcription sessions

        module Include
          extend OpenAI::Internal::Type::Enum

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

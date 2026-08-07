# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionAudio < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput, nil]
        optional :input, -> { OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput }

        # @!method initialize(input: nil)
        #   Configuration for input and output audio.
        #
        #   @param input [OpenAI::Models::Realtime::RealtimeTranscriptionSessionAudioInput]
      end
    end
  end
end

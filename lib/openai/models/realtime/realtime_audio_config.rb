# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioConfigInput, nil]
        optional :input, -> { OpenAI::Realtime::RealtimeAudioConfigInput }

        # @!attribute output
        #
        #   @return [OpenAI::Models::Realtime::RealtimeAudioConfigOutput, nil]
        optional :output, -> { OpenAI::Realtime::RealtimeAudioConfigOutput }

        # @!method initialize(input: nil, output: nil)
        #   Configuration for input and output audio.
        #
        #   @param input [OpenAI::Models::Realtime::RealtimeAudioConfigInput]
        #   @param output [OpenAI::Models::Realtime::RealtimeAudioConfigOutput]
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # The SDP answer and response metadata returned when a WebRTC call is created.
      class CallCreateResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute sdp
        #   The WebRTC Session Description Protocol answer.
        #
        #   @return [String]
        required :sdp, String

        # @!attribute call_id
        #   The call ID parsed from the response Location header, when present.
        #
        #   @return [String, nil]
        optional :call_id, String

        # @!attribute headers
        #   The response headers, normalized to lowercase names.
        #
        #   @return [Hash{String=>String}]
        required :headers, -> { OpenAI::Internal::Type::HashOf[String] }

        # @!method initialize(sdp:, headers:, call_id: nil)
        #   @param sdp [String] The WebRTC Session Description Protocol answer.
        #   @param headers [Hash{Symbol,String=>String}] The normalized response headers.
        #   @param call_id [String, nil] The call ID parsed from the Location header.
      end
    end
  end
end

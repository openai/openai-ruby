# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @see OpenAI::Resources::Realtime::Calls#create
      class CallCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute sdp
        #   The WebRTC Session Description Protocol offer.
        #
        #   @return [String]
        required :sdp, String

        # @!attribute session
        #   Optional session configuration sent with the SDP offer.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, nil]
        optional :session, -> { OpenAI::Realtime::RealtimeSessionCreateRequest }

        # @!method initialize(sdp:, session: nil, request_options: {})
        #   @param sdp [String] The WebRTC Session Description Protocol offer.
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest] Optional session configuration.
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end

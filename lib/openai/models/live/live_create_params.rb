# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live#create
      class LiveCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session
        #   Startup configuration for the Live session.
        #
        #   @return [OpenAI::Models::Live::MediaSessionConfig]
        required :session, -> { OpenAI::Live::MediaSessionConfig }

        # @!attribute transport
        #   WebRTC transport with the browser's SDP offer.
        #
        #   @return [OpenAI::Models::Live::LiveCreateParams::Transport]
        required :transport, -> { OpenAI::Live::LiveCreateParams::Transport }

        # @!method initialize(session:, transport:, request_options: {})
        #   @param session [OpenAI::Models::Live::MediaSessionConfig]
        #     Startup configuration for the Live session.
        #
        #   @param transport [OpenAI::Models::Live::LiveCreateParams::Transport]
        #     WebRTC transport with the browser's SDP offer.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class Transport < OpenAI::Internal::Type::BaseModel
          # @!attribute sdp
          #   Session Description Protocol message for the WebRTC connection.
          #
          #   @return [String]
          required :sdp, String

          # @!attribute type
          #   The transport used for the Live session. Always `webrtc`.
          #
          #   @return [Symbol, :webrtc]
          required :type, const: :webrtc

          # @!method initialize(sdp:, type: :webrtc)
          #   WebRTC transport with the browser's SDP offer.
          #
          #   @param sdp [String]
          #     Session Description Protocol message for the WebRTC connection.
          #
          #   @param type [Symbol, :webrtc]
          #     The transport used for the Live session. Always `webrtc`.
        end
      end
    end
  end
end

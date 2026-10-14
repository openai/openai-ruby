# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#fork
      class SessionForkParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute session_id
        #
        #   @return [String]
        required :session_id, String

        # @!attribute transport
        #   WebRTC transport with an SDP offer for the new connection to the forked session.
        #
        #   @return [OpenAI::Models::Live::SessionForkParams::Transport]
        required :transport, -> { OpenAI::Live::SessionForkParams::Transport }

        # @!attribute session
        #   Optional configuration overrides for the new Live session. Omit this object or
        #   send an empty object to inherit the stored session's settings.
        #
        #   @return [OpenAI::Models::Live::MediaSessionForkConfig, nil]
        optional :session, -> { OpenAI::Live::MediaSessionForkConfig }

        # @!method initialize(session_id:, transport:, session: nil, request_options: {})
        #   @param session_id [String]
        #
        #   @param transport [OpenAI::Models::Live::SessionForkParams::Transport]
        #     WebRTC transport with an SDP offer for the new connection to the forked session.
        #
        #   @param session [OpenAI::Models::Live::MediaSessionForkConfig]
        #     Optional configuration overrides for the new Live session. Omit this object or
        #     send an empty object to inherit the stored session's settings.
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
          #   WebRTC transport with an SDP offer for the new connection to the forked session.
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

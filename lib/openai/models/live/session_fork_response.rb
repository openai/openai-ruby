# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # @see OpenAI::Resources::Live::Sessions#fork
      class SessionForkResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   The newly created Live session. Use its ID for session controls and sideband
        #   connections.
        #
        #   @return [OpenAI::Models::Live::SessionForkResponse::Session]
        required :session, -> { OpenAI::Models::Live::SessionForkResponse::Session }

        # @!attribute transport
        #   WebRTC transport with the SDP answer.
        #
        #   @return [OpenAI::Models::Live::SessionForkResponse::Transport]
        required :transport, -> { OpenAI::Models::Live::SessionForkResponse::Transport }

        # @!method initialize(session:, transport:)
        #   The created Live session identifier and WebRTC answer. Apply transport.sdp as
        #   the peer's remote answer and wait for session.started on the data channel before
        #   sending commands.
        #
        #   @param session [OpenAI::Models::Live::SessionForkResponse::Session]
        #     The newly created Live session. Use its ID for session controls and sideband
        #     connections.
        #
        #   @param transport [OpenAI::Models::Live::SessionForkResponse::Transport]
        #     WebRTC transport with the SDP answer.

        # @see OpenAI::Models::Live::SessionForkResponse#session
        class Session < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Opaque session identifier. Preserve the returned value unchanged, including its
          #   prefix.
          #
          #   @return [String]
          required :id, String

          # @!method initialize(id:)
          #   The newly created Live session. Use its ID for session controls and sideband
          #   connections.
          #
          #   @param id [String]
          #     Opaque session identifier. Preserve the returned value unchanged, including its
          #     prefix.
        end

        # @see OpenAI::Models::Live::SessionForkResponse#transport
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
          #   WebRTC transport with the SDP answer.
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

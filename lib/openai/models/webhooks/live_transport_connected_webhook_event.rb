# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class LiveTransportConnectedWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The webhook event ID.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix time in seconds when the event was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #
        #   @return [OpenAI::Models::Webhooks::LiveTransportConnectedWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data }

        # @!attribute object
        #
        #   @return [Symbol, :event]
        required :object, const: :event

        # @!attribute type
        #
        #   @return [Symbol, :"live.transport.connected"]
        required :type, const: :"live.transport.connected"

        # @!method initialize(id:, created_at:, data:, object: :event, type: :"live.transport.connected")
        #   Sent when a direct Live WebRTC session is created or an Instant Connect session
        #   activates. Use its session ID to attach a sideband observer.
        #
        #   @param id [String]
        #     The webhook event ID.
        #
        #   @param created_at [Integer]
        #     Unix time in seconds when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::LiveTransportConnectedWebhookEvent::Data]
        #
        #   @param object [Symbol, :event]
        #
        #   @param type [Symbol, :"live.transport.connected"]

        # @see OpenAI::Models::Webhooks::LiveTransportConnectedWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute session_id
          #   The Live session ID to use with the sideband attach endpoint.
          #
          #   @return [String]
          required :session_id, String

          # @!attribute type
          #   The session transport.
          #
          #   @return [Symbol, :webrtc]
          required :type, const: :webrtc

          # @!method initialize(session_id:, type: :webrtc)
          #   @param session_id [String]
          #     The Live session ID to use with the sideband attach endpoint.
          #
          #   @param type [Symbol, :webrtc]
          #     The session transport.
        end
      end
    end
  end
end

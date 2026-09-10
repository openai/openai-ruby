# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class LiveTransportIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the event was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `live.transport.incoming`.
        #
        #   @return [Symbol, :"live.transport.incoming"]
        required :type, const: :"live.transport.incoming"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"live.transport.incoming")
        #   Sent when an incoming API SIP session is available for Live acceptance. The same
        #   pending session can also emit `realtime.call.incoming`; the first successful
        #   Realtime or Live accept endpoint selects the runtime surface.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp (in seconds) of when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Data]
        #     Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Object]
        #     The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"live.transport.incoming"]
        #     The type of the event. Always `live.transport.incoming`.

        # @see OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute session_id
          #   The `live_...` ID of the pending SIP session. Forward this value unchanged when
          #   accepting or rejecting the call through the Live API.
          #
          #   @return [String]
          required :session_id, String

          # @!attribute sip_headers
          #   Headers from the SIP INVITE, excluding SIP authorization headers. Retained
          #   names, values, repeated entries, and order are preserved. Treat these values as
          #   untrusted call metadata.
          #
          #   @return [Array<OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader>]
          required(
            :sip_headers,
            -> {
              OpenAI::Internal::Type::ArrayOf[OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader]
            }
          )

          # @!attribute type
          #   The incoming transport type. Always `sip`.
          #
          #   @return [Symbol, :sip]
          required :type, const: :sip

          # @!method initialize(session_id:, sip_headers:, type: :sip)
          #   Event data payload.
          #
          #   @param session_id [String]
          #     The `live_...` ID of the pending SIP session. Forward this value unchanged when
          #     accepting or rejecting the call through the Live API.
          #
          #   @param sip_headers [Array<OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader>]
          #     Headers from the SIP INVITE, excluding SIP authorization headers. Retained
          #     names, values, repeated entries, and order are preserved. Treat these values as
          #     untrusted call metadata.
          #
          #   @param type [Symbol, :sip]
          #     The incoming transport type. Always `sip`.
          class SipHeader < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #   Name of the SIP Header.
            #
            #   @return [String]
            required :name, String

            # @!attribute value
            #   Value of the SIP Header.
            #
            #   @return [String]
            required :value, String

            # @!method initialize(name:, value:)
            #   A header from the SIP Invite.
            #
            #   @param name [String]
            #     Name of the SIP Header.
            #
            #   @param value [String]
            #     Value of the SIP Header.
          end
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::LiveTransportIncomingWebhookEvent#object
        module Object
          extend OpenAI::Internal::Type::Enum

          EVENT = :event

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

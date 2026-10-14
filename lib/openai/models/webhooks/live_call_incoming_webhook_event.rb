# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class LiveCallIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `live.call.incoming`.
        #
        #   @return [Symbol, :"live.call.incoming"]
        required :type, const: :"live.call.incoming"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"live.call.incoming")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent} for more details.
        #
        #   Sent when an incoming API SIP session is available for Live acceptance. The same
        #   pending session can also emit `realtime.call.incoming`; the first successful
        #   Realtime or Live accept endpoint selects the runtime surface.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the event was created.
        #
        #   @param data [OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"live.call.incoming"] The type of the event. Always `live.call.incoming`.

        # @see OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute session_id
          #   The Transceiver `rtc_...` ID of the pending SIP session. The same value appears
          #   as `call_id` in `realtime.call.incoming`.
          #
          #   @return [String]
          required :session_id, String

          # @!attribute sip_headers
          #   Headers from the SIP Invite.
          #
          #   @return [Array<OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader>]
          required :sip_headers,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader] }

          # @!method initialize(session_id:, sip_headers:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data} for more details.
          #
          #   Event data payload.
          #
          #   @param session_id [String] The Transceiver `rtc_...` ID of the pending SIP session. The same
          #
          #   @param sip_headers [Array<OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader>] Headers from the SIP Invite.

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
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader} for
            #   more details.
            #
            #   A header from the SIP Invite.
            #
            #   @param name [String] Name of the SIP Header.
            #
            #   @param value [String] Value of the SIP Header.
          end
        end

        # The object of the event. Always `event`.
        #
        # @see OpenAI::Models::Webhooks::LiveCallIncomingWebhookEvent#object
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

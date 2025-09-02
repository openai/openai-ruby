# frozen_string_literal: true

module OpenAI
  module Models
    module Webhooks
      class RealtimeCallIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) of when the model response was completed.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data
        #   Event data payload.
        #
        #   @return [OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data]
        required :data, -> { OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data }

        # @!attribute type
        #   The type of the event. Always `realtime.call.incoming`.
        #
        #   @return [Symbol, :"realtime.call.incoming"]
        required :type, const: :"realtime.call.incoming"

        # @!attribute object
        #   The object of the event. Always `event`.
        #
        #   @return [Symbol, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Object, nil]
        optional :object, enum: -> { OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object }

        # @!method initialize(id:, created_at:, data:, object: nil, type: :"realtime.call.incoming")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent} for more details.
        #
        #   Sent when Realtime API Receives a incoming SIP call.
        #
        #   @param id [String] The unique ID of the event.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) of when the model response was completed.
        #
        #   @param data [OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data] Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Object] The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"realtime.call.incoming"] The type of the event. Always `realtime.call.incoming`.

        # @see OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #   The unique ID of this call.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute sip_headers
          #   Headers from the SIP Invite.
          #
          #   @return [Array<OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader>]
          required :sip_headers,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader] }

          # @!method initialize(call_id:, sip_headers:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data} for more
          #   details.
          #
          #   Event data payload.
          #
          #   @param call_id [String] The unique ID of this call.
          #
          #   @param sip_headers [Array<OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader>] Headers from the SIP Invite.

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
            #   {OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader}
            #   for more details.
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
        # @see OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent#object
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

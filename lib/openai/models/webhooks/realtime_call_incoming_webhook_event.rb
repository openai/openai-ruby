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
        #   Sent when an incoming API SIP session is available for Realtime acceptance. The
        #   same pending session can also emit `live.transport.incoming`; the first
        #   successful Realtime or Live accept endpoint selects the runtime surface.
        #
        #   @param id [String]
        #     The unique ID of the event.
        #
        #   @param created_at [Integer]
        #     The Unix timestamp (in seconds) of when the model response was completed.
        #
        #   @param data [OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data]
        #     Event data payload.
        #
        #   @param object [Symbol, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Object]
        #     The object of the event. Always `event`.
        #
        #   @param type [Symbol, :"realtime.call.incoming"]
        #     The type of the event. Always `realtime.call.incoming`.

        # @see OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent#data
        class Data < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #   The ID of the pending SIP call. Pass this value unchanged when accepting or
          #   rejecting the call through the Realtime API. For the Live API, use the
          #   `session_id` from `live.transport.incoming` instead.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute sip_headers
          #   Headers from the SIP INVITE, excluding SIP authorization headers. Retained
          #   names, values, repeated entries, and order are preserved. Treat these values as
          #   untrusted call metadata.
          #
          #   @return [Array<OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader>]
          required(
            :sip_headers,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader] }
          )

          # @!attribute sip_media_security
          #   Media protection selected on the SIP leg during SDP negotiation. `srtp`
          #   indicates SRTP; `rtp` indicates unencrypted RTP. Omitted when unknown. This does
          #   not describe SIP signaling security or confirm that media has flowed. Clients
          #   should handle unrecognized values as unknown.
          #
          #   @return [Symbol, String, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity, nil]
          optional(
            :sip_media_security,
            union: -> { OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity }
          )

          # @!method initialize(call_id:, sip_headers:, sip_media_security: nil)
          #   Event data payload.
          #
          #   @param call_id [String]
          #     The ID of the pending SIP call. Pass this value unchanged when accepting or
          #     rejecting the call through the Realtime API. For the Live API, use the
          #     `session_id` from `live.transport.incoming` instead.
          #
          #   @param sip_headers [Array<OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader>]
          #     Headers from the SIP INVITE, excluding SIP authorization headers. Retained
          #     names, values, repeated entries, and order are preserved. Treat these values as
          #     untrusted call metadata.
          #
          #   @param sip_media_security [Symbol, String, OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity]
          #     Media protection selected on the SIP leg during SDP negotiation. `srtp`
          #     indicates SRTP; `rtp` indicates unencrypted RTP. Omitted when unknown. This does
          #     not describe SIP signaling security or confirm that media has flowed. Clients
          #     should handle unrecognized values as unknown.
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

          # Media protection selected on the SIP leg during SDP negotiation. `srtp`
          # indicates SRTP; `rtp` indicates unencrypted RTP. Omitted when unknown. This does
          # not describe SIP signaling security or confirm that media has flowed. Clients
          # should handle unrecognized values as unknown.
          #
          # @see OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data#sip_media_security
          module SipMediaSecurity
            extend OpenAI::Internal::Type::Union

            variant(
              const: -> { OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity::RTP }
            )

            variant(
              const: -> { OpenAI::Models::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity::SRTP }
            )

            variant String

            # @!method self.variants
            #   @return [Array(Symbol, String)]

            define_sorbet_constant!(:Variants) do
              T.type_alias {
                T.any(OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipMediaSecurity::TaggedSymbol, String)
              }
            end

            # @!group

            RTP = :rtp
            SRTP = :srtp

            # @!endgroup
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

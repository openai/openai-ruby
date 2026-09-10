# typed: strong

module OpenAI
  module Models

    module Webhooks

      class LiveTransportIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::LiveTransportIncomingWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The type of the event. Always `live.transport.incoming`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig { returns(T.nilable(OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::TaggedSymbol)) }
        attr_reader :object

        sig { params(object: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::OrSymbol).void }
        attr_writer :object

        # Sent when an incoming API SIP session is available for Live acceptance. The same
        # pending session can also emit `realtime.call.incoming`; the first successful
        # Realtime or Live accept endpoint selects the runtime surface.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::OrHash,

            object: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          id:,

          # The Unix timestamp (in seconds) of when the event was created.
          created_at:,

          # Event data payload.
          data:,

          # The object of the event. Always `event`.
          object: nil,

          # The type of the event. Always `live.transport.incoming`.

          type: :"live.transport.incoming"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data,
              type: Symbol,
              object: OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The `live_...` ID of the pending SIP session. Forward this value unchanged when
          # accepting or rejecting the call through the Live API.
          sig { returns(String) }
          attr_accessor :session_id

          # Headers from the SIP INVITE, excluding SIP authorization headers. Retained
          # names, values, repeated entries, and order are preserved. Treat these values as
          # untrusted call metadata.
          sig { returns(T::Array[OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader]) }
          attr_accessor :sip_headers

          # The incoming transport type. Always `sip`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Event data payload.
          sig do
            params(

              session_id: String,

              sip_headers: T::Array[OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader::OrHash],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The `live_...` ID of the pending SIP session. Forward this value unchanged when
            # accepting or rejecting the call through the Live API.
            session_id:,

            # Headers from the SIP INVITE, excluding SIP authorization headers. Retained
            # names, values, repeated entries, and order are preserved. Treat these values as
            # untrusted call metadata.
            sip_headers:,

            # The incoming transport type. Always `sip`.

            type: :sip
          )
          end

          sig do
            override.returns(
              {
                session_id: String,
                sip_headers: T::Array[OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader],
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class SipHeader < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Data::SipHeader,
                OpenAI::Internal::AnyHash
              )
            end

            # Name of the SIP Header.
            sig { returns(String) }
            attr_accessor :name

            # Value of the SIP Header.
            sig { returns(String) }
            attr_accessor :value

            # A header from the SIP Invite.
            sig do
              params(

                name: String,

                value: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Name of the SIP Header.
              name:,

              # Value of the SIP Header.

              value:
            )
            end

            sig do
              override.returns(
                {name: String, value: String}
              )
            end
            def to_hash
            end

          end
        end

        # The object of the event. Always `event`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT = T.let(:event, OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Webhooks::LiveTransportIncomingWebhookEvent::Object::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

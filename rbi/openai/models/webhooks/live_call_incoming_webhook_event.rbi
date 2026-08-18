# typed: strong

module OpenAI
  module Models
    module Webhooks
      class LiveCallIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent,
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
        sig { returns(OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data) }
        attr_reader :data

        sig do
          params(
            data: OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `live.call.incoming`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when an incoming API SIP session is available for Live acceptance. The same
        # pending session can also emit `realtime.call.incoming`; the first successful
        # Realtime or Live accept endpoint selects the runtime surface.
        sig do
          params(
            id: String,
            created_at: Integer,
            data: OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
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
          # The type of the event. Always `live.call.incoming`.
          type: :"live.call.incoming"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The Transceiver `rtc_...` ID of the pending SIP session. The same value appears
          # as `call_id` in `realtime.call.incoming`.
          sig { returns(String) }
          attr_accessor :session_id

          # Headers from the SIP Invite.
          sig do
            returns(
              T::Array[
                OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader
              ]
            )
          end
          attr_accessor :sip_headers

          # Event data payload.
          sig do
            params(
              session_id: String,
              sip_headers:
                T::Array[
                  OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader::OrHash
                ]
            ).returns(T.attached_class)
          end
          def self.new(
            # The Transceiver `rtc_...` ID of the pending SIP session. The same value appears
            # as `call_id` in `realtime.call.incoming`.
            session_id:,
            # Headers from the SIP Invite.
            sip_headers:
          )
          end

          sig do
            override.returns(
              {
                session_id: String,
                sip_headers:
                  T::Array[
                    OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader
                  ]
              }
            )
          end
          def to_hash
          end

          class SipHeader < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Data::SipHeader,
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
              params(name: String, value: String).returns(T.attached_class)
            end
            def self.new(
              # Name of the SIP Header.
              name:,
              # Value of the SIP Header.
              value:
            )
            end

            sig { override.returns({ name: String, value: String }) }
            def to_hash
            end
          end
        end

        # The object of the event. Always `event`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::LiveCallIncomingWebhookEvent::Object::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end

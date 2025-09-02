# typed: strong

module OpenAI
  module Models
    module Webhooks
      class RealtimeCallIncomingWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the model response was completed.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig do
          returns(OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data)
        end
        attr_reader :data

        sig do
          params(
            data:
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `realtime.call.incoming`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when Realtime API Receives a incoming SIP call.
        sig do
          params(
            id: String,
            created_at: Integer,
            data:
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the model response was completed.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `realtime.call.incoming`.
          type: :"realtime.call.incoming"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of this call.
          sig { returns(String) }
          attr_accessor :call_id

          # Headers from the SIP Invite.
          sig do
            returns(
              T::Array[
                OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader
              ]
            )
          end
          attr_accessor :sip_headers

          # Event data payload.
          sig do
            params(
              call_id: String,
              sip_headers:
                T::Array[
                  OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader::OrHash
                ]
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of this call.
            call_id:,
            # Headers from the SIP Invite.
            sip_headers:
          )
          end

          sig do
            override.returns(
              {
                call_id: String,
                sip_headers:
                  T::Array[
                    OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader
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
                  OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Data::SipHeader,
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
                OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent::Object::TaggedSymbol
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

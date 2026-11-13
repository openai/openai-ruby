# typed: strong

module OpenAI
  module Models

    module Webhooks

      class LiveTransportConnectedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::LiveTransportConnectedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The webhook event ID.
        sig { returns(String) }
        attr_accessor :id

        # Unix time in seconds when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        sig { returns(Symbol) }
        attr_accessor :object

        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when a direct Live WebRTC session is created or an Instant Connect session
        # activates. Use its session ID to attach a sideband observer.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data::OrHash,

            object: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The webhook event ID.
          id:,

          # Unix time in seconds when the event was created.
          created_at:,

          data:,

          object: :event,

          type: :"live.transport.connected"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data,
              object: Symbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Webhooks::LiveTransportConnectedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The Live session ID to use with the sideband attach endpoint.
          sig { returns(String) }
          attr_accessor :session_id

          # The session transport.
          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              session_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The Live session ID to use with the sideband attach endpoint.
            session_id:,

            # The session transport.

            type: :webrtc
          )
          end

          sig do
            override.returns(
              {session_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end

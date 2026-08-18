# typed: strong

module OpenAI
  module Models
    module Webhooks
      class BatchCancelledWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::BatchCancelledWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the batch API request was cancelled.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::BatchCancelledWebhookEvent::Data) }
        attr_reader :data

        sig do
          params(
            data: OpenAI::Webhooks::BatchCancelledWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `batch.cancelled`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when a batch API request has been cancelled.
        sig do
          params(
            id: String,
            created_at: Integer,
            data: OpenAI::Webhooks::BatchCancelledWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the batch API request was cancelled.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `batch.cancelled`.
          type: :"batch.cancelled"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::BatchCancelledWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::BatchCancelledWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the batch API request.
          sig { returns(String) }
          attr_accessor :id

          # Event data payload.
          sig { params(id: String).returns(T.attached_class) }
          def self.new(
            # The unique ID of the batch API request.
            id:
          )
          end

          sig { override.returns({ id: String }) }
          def to_hash
          end
        end

        # The object of the event. Always `event`.
        module Object
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Webhooks::BatchCancelledWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::BatchCancelledWebhookEvent::Object::TaggedSymbol
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

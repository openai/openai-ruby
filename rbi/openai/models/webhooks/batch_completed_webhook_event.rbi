# typed: strong

module OpenAI
  module Models
    module Webhooks
      class BatchCompletedWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::BatchCompletedWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the batch API request was completed.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::BatchCompletedWebhookEvent::Data) }
        attr_reader :data

        sig do
          params(
            data: OpenAI::Webhooks::BatchCompletedWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `batch.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when a batch API request has been completed.
        sig do
          params(
            id: String,
            created_at: Integer,
            data: OpenAI::Webhooks::BatchCompletedWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the batch API request was completed.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `batch.completed`.
          type: :"batch.completed"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::BatchCompletedWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::BatchCompletedWebhookEvent::Data,
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
                OpenAI::Webhooks::BatchCompletedWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::BatchCompletedWebhookEvent::Object::TaggedSymbol
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

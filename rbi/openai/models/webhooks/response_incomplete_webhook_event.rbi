# typed: strong

module OpenAI
  module Models
    module Webhooks
      class ResponseIncompleteWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the model response was interrupted.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data) }
        attr_reader :data

        sig do
          params(
            data: OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `response.incomplete`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when a background response has been interrupted.
        sig do
          params(
            id: String,
            created_at: Integer,
            data:
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the model response was interrupted.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `response.incomplete`.
          type: :"response.incomplete"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the model response.
          sig { returns(String) }
          attr_accessor :id

          # Event data payload.
          sig { params(id: String).returns(T.attached_class) }
          def self.new(
            # The unique ID of the model response.
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
                OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::ResponseIncompleteWebhookEvent::Object::TaggedSymbol
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

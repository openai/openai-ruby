# typed: strong

module OpenAI
  module Models
    module Webhooks
      class EvalRunSucceededWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the eval run succeeded.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig { returns(OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data) }
        attr_reader :data

        sig do
          params(
            data: OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `eval.run.succeeded`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when an eval run has succeeded.
        sig do
          params(
            id: String,
            created_at: Integer,
            data: OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the eval run succeeded.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `eval.run.succeeded`.
          type: :"eval.run.succeeded"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the eval run.
          sig { returns(String) }
          attr_accessor :id

          # Event data payload.
          sig { params(id: String).returns(T.attached_class) }
          def self.new(
            # The unique ID of the eval run.
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
                OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::EvalRunSucceededWebhookEvent::Object::TaggedSymbol
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

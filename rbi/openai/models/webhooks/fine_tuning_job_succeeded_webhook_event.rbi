# typed: strong

module OpenAI
  module Models
    module Webhooks
      class FineTuningJobSucceededWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the fine-tuning job succeeded.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig do
          returns(OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data)
        end
        attr_reader :data

        sig do
          params(
            data:
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `fine_tuning.job.succeeded`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when a fine-tuning job has succeeded.
        sig do
          params(
            id: String,
            created_at: Integer,
            data:
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the fine-tuning job succeeded.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `fine_tuning.job.succeeded`.
          type: :"fine_tuning.job.succeeded"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the fine-tuning job.
          sig { returns(String) }
          attr_accessor :id

          # Event data payload.
          sig { params(id: String).returns(T.attached_class) }
          def self.new(
            # The unique ID of the fine-tuning job.
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
                OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::FineTuningJobSucceededWebhookEvent::Object::TaggedSymbol
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

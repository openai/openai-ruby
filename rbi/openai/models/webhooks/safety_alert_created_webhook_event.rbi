# typed: strong

module OpenAI
  module Models

    module Webhooks

      class SafetyAlertCreatedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the webhook event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp in seconds when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Always `safety.alert.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when an approved safety alert is available for an API project.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data::OrHash,

            object: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the webhook event.
          id:,

          # The Unix timestamp in seconds when the event was created.
          created_at:,

          data:,

          # Always `event`.
          object: :event,

          # Always `safety.alert.created`.

          type: :"safety.alert.created"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data,
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
              OpenAI::Webhooks::SafetyAlertCreatedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The safety alert ID to pass to `GET /v1/safety/alerts/{id}`.
          sig { returns(String) }
          attr_accessor :id

          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The safety alert ID to pass to `GET /v1/safety/alerts/{id}`.

            id:
          )
          end

          sig do
            override.returns(
              {id: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end

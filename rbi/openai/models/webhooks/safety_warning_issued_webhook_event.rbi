# typed: strong

module OpenAI
  module Models

    module Webhooks

      class SafetyWarningIssuedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the webhook event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp in seconds when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Always `safety.warning_issued`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when a warning is issued for a safety identifier in your organization.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent::Data::OrHash,

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

          # Always `safety.warning_issued`.

          type: :"safety.warning_issued"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent::Data,
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
              OpenAI::Webhooks::SafetyWarningIssuedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The safety case ID to pass to `GET /v1/safety/cases/{id}`.
          sig { returns(String) }
          attr_accessor :id

          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The safety case ID to pass to `GET /v1/safety/cases/{id}`.

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

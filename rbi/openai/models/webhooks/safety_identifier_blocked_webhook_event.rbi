# typed: strong

module OpenAI
  module Models
    module Webhooks
      class SafetyIdentifierBlockedWebhookEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) of when the request was blocked.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Event data payload.
        sig do
          returns(OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data)
        end
        attr_reader :data

        sig do
          params(
            data:
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data::OrHash
          ).void
        end
        attr_writer :data

        # The type of the event. Always `safety_identifier.blocked`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The object of the event. Always `event`.
        sig do
          returns(
            T.nilable(
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::TaggedSymbol
            )
          )
        end
        attr_reader :object

        sig do
          params(
            object:
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::OrSymbol
          ).void
        end
        attr_writer :object

        # Sent when a request associated with a safety identifier has been blocked.
        sig do
          params(
            id: String,
            created_at: Integer,
            data:
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data::OrHash,
            object:
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the event.
          id:,
          # The Unix timestamp (in seconds) of when the request was blocked.
          created_at:,
          # Event data payload.
          data:,
          # The object of the event. Always `event`.
          object: nil,
          # The type of the event. Always `safety_identifier.blocked`.
          type: :"safety_identifier.blocked"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data,
              type: Symbol,
              object:
                OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Data < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Data,
                OpenAI::Internal::AnyHash
              )
            end

          # The safety category that triggered the block, such as `bio` or `cyber`.
          sig { returns(String) }
          attr_accessor :safety_category

          # The stable safety identifier associated with the blocked request.
          sig { returns(String) }
          attr_accessor :safety_identifier

          # The model used for the blocked request, if available.
          sig { returns(T.nilable(String)) }
          attr_reader :model

          sig { params(model: String).void }
          attr_writer :model

          # The project associated with the blocked request, if available.
          sig { returns(T.nilable(String)) }
          attr_reader :project_id

          sig { params(project_id: String).void }
          attr_writer :project_id

          # The OpenAI request ID for the blocked request, if available.
          sig { returns(T.nilable(String)) }
          attr_reader :request_id

          sig { params(request_id: String).void }
          attr_writer :request_id

          # Event data payload.
          sig do
            params(
              safety_category: String,
              safety_identifier: String,
              model: String,
              project_id: String,
              request_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The safety category that triggered the block, such as `bio` or `cyber`.
            safety_category:,
            # The stable safety identifier associated with the blocked request.
            safety_identifier:,
            # The model used for the blocked request, if available.
            model: nil,
            # The project associated with the blocked request, if available.
            project_id: nil,
            # The OpenAI request ID for the blocked request, if available.
            request_id: nil
          )
          end

          sig do
            override.returns(
              {
                safety_category: String,
                safety_identifier: String,
                model: String,
                project_id: String,
                request_id: String
              }
            )
          end
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
                OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          EVENT =
            T.let(
              :event,
              OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Webhooks::SafetyIdentifierBlockedWebhookEvent::Object::TaggedSymbol
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

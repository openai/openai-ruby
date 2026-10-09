# typed: strong

module OpenAI
  module Models

    module Webhooks

      class AgentEnvironmentFailedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Identifies the environment whose lifecycle changed.
        sig { returns(OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The object type. Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The event type. Always `agent.environment.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when setup fails for a prewarmed OpenAI-hosted environment before it is
        # attached to a session.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data::OrHash,

            object: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          id:,

          # The Unix timestamp, in seconds, when the event was created.
          created_at:,

          # Identifies the environment whose lifecycle changed.
          data:,

          # The object type. Always `event`.
          object: :event,

          # The event type. Always `agent.environment.failed`.

          type: :"agent.environment.failed"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data,
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
              OpenAI::Webhooks::AgentEnvironmentFailedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the environment.
          sig { returns(String) }
          attr_accessor :id

          # Identifies the environment whose lifecycle changed.
          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the environment.

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

# typed: strong

module OpenAI
  module Models

    module Webhooks

      class AgentSessionInProgressWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::AgentSessionInProgressWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The object type. Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The event type. Always `agent.session.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when an agent session enters the in-progress state.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data::OrHash,

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

          data:,

          # The object type. Always `event`.
          object: :event,

          # The event type. Always `agent.session.in_progress`.

          type: :"agent.session.in_progress"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data,
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
              OpenAI::Webhooks::AgentSessionInProgressWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the session.
          sig { returns(String) }
          attr_accessor :id

          # The environment type: `none`, `openai_hosted`, or `self_hosted`.
          sig { returns(String) }
          attr_accessor :environment_type

          # The ID of the environment, when one exists.
          sig { returns(T.nilable(String)) }
          attr_reader :environment_id

          sig { params(environment_id: String).void }
          attr_writer :environment_id

          sig do
            params(

              id: String,

              environment_type: String,

              environment_id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the session.
            id:,

            # The environment type: `none`, `openai_hosted`, or `self_hosted`.
            environment_type:,

            # The ID of the environment, when one exists.

            environment_id: nil
          )
          end

          sig do
            override.returns(
              {id: String, environment_type: String, environment_id: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end

# typed: strong

module OpenAI
  module Models

    module Webhooks

      class AgentSessionCreatedWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::AgentSessionCreatedWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The object type. Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The event type. Always `agent.session.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when an agent session is created.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::OrHash,

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

          # The event type. Always `agent.session.created`.

          type: :"agent.session.created"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data,
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
              OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the session.
          sig { returns(String) }
          attr_accessor :id

          # The environment type: `none`, `openai_hosted`, or `self_hosted`.
          sig { returns(String) }
          attr_accessor :environment_type

          sig { returns(T.nilable(OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect)) }
          attr_reader :connect

          sig { params(connect: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect::OrHash).void }
          attr_writer :connect

          # The ID of the environment, when one exists.
          sig { returns(T.nilable(String)) }
          attr_reader :environment_id

          sig { params(environment_id: String).void }
          attr_writer :environment_id

          sig do
            params(

              id: String,

              environment_type: String,

              connect: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect::OrHash,

              environment_id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the session.
            id:,

            # The environment type: `none`, `openai_hosted`, or `self_hosted`.
            environment_type:,

            connect: nil,

            # The ID of the environment, when one exists.

            environment_id: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                environment_type: String,
                connect: OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect,
                environment_id: String
              }
            )
          end
          def to_hash
          end

          class Connect < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Webhooks::AgentSessionCreatedWebhookEvent::Data::Connect,
                OpenAI::Internal::AnyHash
              )
            end

            # The URL used to connect the self-hosted environment.
            sig { returns(String) }
            attr_accessor :remote_url

            sig do
              params(

                remote_url: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The URL used to connect the self-hosted environment.

              remote_url:
            )
            end

            sig do
              override.returns(
                {remote_url: String}
              )
            end
            def to_hash
            end

          end
        end

      end

    end

  end
end

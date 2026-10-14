# typed: strong

module OpenAI
  module Models

    module Webhooks

      class AgentSessionActionRequiredWebhookEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp, in seconds, when the event was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data) }
        attr_reader :data

        sig { params(data: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::OrHash).void }
        attr_writer :data

        # The object type. Always `event`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The event type. Always `agent.session.action_required`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent when an agent session requires an action. Retrieve the session for action
        # details.
        sig do
          params(

            id: String,

            created_at: Integer,

            data: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::OrHash,

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

          # The event type. Always `agent.session.action_required`.

          type: :"agent.session.action_required"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data,
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
              OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the session.
          sig { returns(String) }
          attr_accessor :id

          # The action type. Retrieve the session for action details.
          sig { returns(OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction) }
          attr_reader :required_action

          sig {
            params(
              required_action: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::OrHash
            )
              .void
          }
          attr_writer :required_action

          sig do
            params(

              id: String,

              required_action: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the session.
            id:,

            # The action type. Retrieve the session for action details.

            required_action:
          )
          end

          sig do
            override.returns(
              {
                id: String,
                required_action: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction
              }
            )
          end
          def to_hash
          end

          class RequiredAction < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction,
                OpenAI::Internal::AnyHash
              )
            end

            sig {
              returns(
                OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
              )
            }
            attr_accessor :type

            # The action type. Retrieve the session for action details.
            sig do
              params(

                type: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              type:
            )
            end

            sig do
              override.returns(
                {
                  type: OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              COMPUTER_USE_APPROVAL_REQUEST = T.let(
                :computer_use_approval_request,
                OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
              )
              FUNCTION_CALL = T.let(
                :function_call,
                OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
              )
              ENVIRONMENT_CONNECTION = T.let(
                :environment_connection,
                OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::Webhooks::AgentSessionActionRequiredWebhookEvent::Data::RequiredAction::Type::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end
        end

      end

    end

  end
end

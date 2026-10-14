# typed: strong

module OpenAI
  module Models

    module Live

      class CommentaryAppendEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::CommentaryAppendEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Speakable context for the Live model, limited to 500 tokens. Use this for a
        # result the model should communicate; use session.thinking.append for silent
        # context.
        sig { returns(String) }
        attr_accessor :content

        # Required, nullable. Set null for general session context, or use the ID from
        # session.delegation.created for an existing client delegation. Non-null IDs are
        # not accepted with Responses delegation.
        sig { returns(T.nilable(String)) }
        attr_accessor :delegation_id

        # The Live client event type. Always `session.commentary.append`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Provide context the Live model can communicate to the user, optionally for an
        # existing client delegation.
        sig do
          params(

            content: String,

            delegation_id: T.nilable(String),

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Speakable context for the Live model, limited to 500 tokens. Use this for a
          # result the model should communicate; use session.thinking.append for silent
          # context.
          content:,

          # Required, nullable. Set null for general session context, or use the ID from
          # session.delegation.created for an existing client delegation. Non-null IDs are
          # not accepted with Responses delegation.
          delegation_id:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.commentary.append`.

          type: :"session.commentary.append"
        )
        end

        sig do
          override.returns(
            {content: String, delegation_id: T.nilable(String), type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end

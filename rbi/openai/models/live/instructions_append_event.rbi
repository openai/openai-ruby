# typed: strong

module OpenAI
  module Models

    module Live

      class InstructionsAppendEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::InstructionsAppendEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Instruction text to append, limited to 500 tokens. This is a plain string, not
        # an array of content parts.
        sig { returns(String) }
        attr_accessor :content

        # Required, nullable. Set null for general session context, or use the ID from
        # session.delegation.created for an existing client delegation. Non-null IDs are
        # not accepted with Responses delegation.
        sig { returns(T.nilable(String)) }
        attr_accessor :delegation_id

        # The Live client event type. Always `session.instructions.append`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Append instructions to the Live conversation while it is running, optionally
        # associating them with an existing client delegation.
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

          # Instruction text to append, limited to 500 tokens. This is a plain string, not
          # an array of content parts.
          content:,

          # Required, nullable. Set null for general session context, or use the ID from
          # session.delegation.created for an existing client delegation. Non-null IDs are
          # not accepted with Responses delegation.
          delegation_id:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.instructions.append`.

          type: :"session.instructions.append"
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

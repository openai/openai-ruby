# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionSubagentClosedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionSubagentClosedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The subagent that was closed.
        sig { returns(OpenAI::Beta::Subagent) }
        attr_reader :subagent

        sig { params(subagent: OpenAI::Beta::Subagent::OrHash).void }
        attr_writer :subagent

        # The type of the object. Always `agent.session.subagent.closed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a subagent is closed.
        sig do
          params(

            event_id: String,

            subagent: OpenAI::Beta::Subagent::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The subagent that was closed.
          subagent:,

          # The type of the object. Always `agent.session.subagent.closed`.

          type: :"agent.session.subagent.closed"
        )
        end

        sig do
          override.returns(
            {event_id: String, subagent: OpenAI::Beta::Subagent, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end

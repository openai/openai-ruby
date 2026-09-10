# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionSubagentCreatedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionSubagentCreatedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the event.
        sig { returns(String) }
        attr_accessor :event_id

        # The subagent that was created.
        sig { returns(OpenAI::Beta::Subagent) }
        attr_reader :subagent

        sig { params(subagent: OpenAI::Beta::Subagent::OrHash).void }
        attr_writer :subagent

        # The type of the object. Always `agent.session.subagent.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a subagent is created.
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

          # The subagent that was created.
          subagent:,

          # The type of the object. Always `agent.session.subagent.created`.

          type: :"agent.session.subagent.created"
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

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

        # Random alphanumeric padding. Present when stream obfuscation is enabled.
        sig { returns(T.nilable(String)) }
        attr_reader :obfuscation

        sig { params(obfuscation: String).void }
        attr_writer :obfuscation

        # Emitted when a subagent is created.
        sig do
          params(

            event_id: String,

            subagent: OpenAI::Beta::Subagent::OrHash,

            obfuscation: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the event.
          event_id:,

          # The subagent that was created.
          subagent:,

          # Random alphanumeric padding. Present when stream obfuscation is enabled.
          obfuscation: nil,

          # The type of the object. Always `agent.session.subagent.created`.

          type: :"agent.session.subagent.created"
        )
        end

        sig do
          override.returns(
            {event_id: String, subagent: OpenAI::Beta::Subagent, type: Symbol, obfuscation: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end

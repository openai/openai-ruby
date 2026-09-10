# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionAssistantMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionAssistantMessage,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the message.
        sig { returns(String) }
        attr_accessor :id

        # The content of the message.
        sig { returns(T::Array[OpenAI::Beta::OutputText]) }
        attr_accessor :content

        # The phase of an assistant message.
        sig { returns(T.nilable(OpenAI::Beta::AgentSessionAssistantMessage::Phase::TaggedSymbol)) }
        attr_accessor :phase

        # The role of the message author. Always `assistant`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The status of the message.
        sig { returns(OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An assistant message produced by the agent.
        sig do
          params(

            id: String,

            content: T::Array[OpenAI::Beta::OutputText::OrHash],

            phase: T.nilable(OpenAI::Beta::AgentSessionAssistantMessage::Phase::OrSymbol),

            status: OpenAI::Beta::AgentOutputItemStatus::OrSymbol,

            turn_id: String,

            role: Symbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the message.
          id:,

          # The content of the message.
          content:,

          # The phase of an assistant message.
          phase:,

          # The status of the message.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The role of the message author. Always `assistant`.
          role: :assistant,

          # The item type. Always `message`.

          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: T::Array[OpenAI::Beta::OutputText],
              phase: T.nilable(OpenAI::Beta::AgentSessionAssistantMessage::Phase::TaggedSymbol),
              role: Symbol,
              status: OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol,
              turn_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The phase of an assistant message.
        module Phase
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSessionAssistantMessage::Phase) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Commentary produced while the agent works.
          COMMENTARY = T.let(:commentary, OpenAI::Beta::AgentSessionAssistantMessage::Phase::TaggedSymbol)

          # The agent's final answer.
          FINAL_ANSWER = T.let(:final_answer, OpenAI::Beta::AgentSessionAssistantMessage::Phase::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSessionAssistantMessage::Phase::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

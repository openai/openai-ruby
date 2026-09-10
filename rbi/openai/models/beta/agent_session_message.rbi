# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionMessage,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of this item, or null for legacy user messages whose ID was not recorded.
        sig { returns(T.nilable(String)) }
        attr_accessor :id

        # The content of the message. User messages contain input text or images;
        # assistant messages contain output text.
        sig { returns(T::Array[OpenAI::Beta::AgentSessionMessageContent::Variants]) }
        attr_accessor :content

        # The phase of an assistant message.
        sig { returns(T.nilable(OpenAI::Beta::AgentSessionMessage::Phase::TaggedSymbol)) }
        attr_accessor :phase

        # The role of the message author.
        sig { returns(OpenAI::Beta::AgentSessionMessage::Role::TaggedSymbol) }
        attr_accessor :role

        # The status of the message. User messages are always `completed`.
        sig { returns(OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A user or assistant message recorded in a session.
        sig do
          params(

            id: T.nilable(String),

            content: T::Array[
              T.any(
                OpenAI::Beta::AgentSessionMessageContent::InputText::OrHash,
                OpenAI::Beta::AgentSessionMessageContent::InputImage::OrHash,
                OpenAI::Beta::AgentSessionMessageContent::OutputText::OrHash
              )
            ],

            phase: T.nilable(OpenAI::Beta::AgentSessionMessage::Phase::OrSymbol),

            role: OpenAI::Beta::AgentSessionMessage::Role::OrSymbol,

            status: OpenAI::Beta::AgentOutputItemStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of this item, or null for legacy user messages whose ID was not recorded.
          id:,

          # The content of the message. User messages contain input text or images;
          # assistant messages contain output text.
          content:,

          # The phase of an assistant message.
          phase:,

          # The role of the message author.
          role:,

          # The status of the message. User messages are always `completed`.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `message`.

          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: T.nilable(String),
              content: T::Array[OpenAI::Beta::AgentSessionMessageContent::Variants],
              phase: T.nilable(OpenAI::Beta::AgentSessionMessage::Phase::TaggedSymbol),
              role: OpenAI::Beta::AgentSessionMessage::Role::TaggedSymbol,
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

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSessionMessage::Phase) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Commentary produced while the agent works.
          COMMENTARY = T.let(:commentary, OpenAI::Beta::AgentSessionMessage::Phase::TaggedSymbol)

          # The agent's final answer.
          FINAL_ANSWER = T.let(:final_answer, OpenAI::Beta::AgentSessionMessage::Phase::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSessionMessage::Phase::TaggedSymbol]) }
          def self.values
          end
        end

        # The role of the message author.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSessionMessage::Role) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          USER = T.let(:user, OpenAI::Beta::AgentSessionMessage::Role::TaggedSymbol)
          ASSISTANT = T.let(:assistant, OpenAI::Beta::AgentSessionMessage::Role::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSessionMessage::Role::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

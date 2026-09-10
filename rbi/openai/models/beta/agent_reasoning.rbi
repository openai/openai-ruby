# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentReasoning < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentReasoning,
            OpenAI::Internal::AnyHash
          )
        end

        # The amount of reasoning effort used by an agent.
        sig { returns(T.nilable(OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)) }
        attr_accessor :effort

        # The reasoning summary format requested from an agent.
        sig { returns(T.nilable(OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol)) }
        attr_accessor :summary

        # The reasoning configuration used by an agent.
        sig do
          params(

            effort: T.nilable(OpenAI::Beta::AgentReasoning::Effort::OrSymbol),

            summary: T.nilable(OpenAI::Beta::AgentReasoning::Summary::OrSymbol)
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The amount of reasoning effort used by an agent.
          effort:,

          # The reasoning summary format requested from an agent.

          summary:
        )
        end

        sig do
          override.returns(
            {
              effort: T.nilable(OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol),
              summary: T.nilable(OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol)
            }
          )
        end
        def to_hash
        end

        # The amount of reasoning effort used by an agent.
        module Effort
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentReasoning::Effort) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          NONE = T.let(:none, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          MINIMAL = T.let(:minimal, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          LOW = T.let(:low, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          MEDIUM = T.let(:medium, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          XHIGH = T.let(:xhigh, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)
          MAX = T.let(:max, OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentReasoning::Effort::TaggedSymbol]) }
          def self.values
          end
        end

        # The reasoning summary format requested from an agent.
        module Summary
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentReasoning::Summary) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Returns a concise reasoning summary when supported.
          CONCISE = T.let(:concise, OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol)

          # Returns a detailed reasoning summary when supported.
          DETAILED = T.let(:detailed, OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol)

          # Automatically selects the most detailed summary supported by the model.
          AUTO = T.let(:auto, OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentReasoning::Summary::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

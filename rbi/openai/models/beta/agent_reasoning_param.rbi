# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentReasoningParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentReasoningParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The amount of reasoning effort the model should use.
        sig { returns(T.nilable(OpenAI::Beta::AgentReasoningParam::Effort::OrSymbol)) }
        attr_accessor :effort

        # The reasoning summary format requested from the model.
        sig { returns(T.nilable(OpenAI::Beta::AgentReasoningParam::Summary::OrSymbol)) }
        attr_accessor :summary

        # Reasoning configuration for the agent.
        sig do
          params(

            effort: T.nilable(OpenAI::Beta::AgentReasoningParam::Effort::OrSymbol),

            summary: T.nilable(OpenAI::Beta::AgentReasoningParam::Summary::OrSymbol)
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The amount of reasoning effort the model should use.
          effort: nil,

          # The reasoning summary format requested from the model.

          summary: nil
        )
        end

        sig do
          override.returns(
            {
              effort: T.nilable(OpenAI::Beta::AgentReasoningParam::Effort::OrSymbol),
              summary: T.nilable(OpenAI::Beta::AgentReasoningParam::Summary::OrSymbol)
            }
          )
        end
        def to_hash
        end

        # The amount of reasoning effort the model should use.
        module Effort
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentReasoningParam::Effort) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          NONE = T.let(:none, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          MINIMAL = T.let(:minimal, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          LOW = T.let(:low, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          MEDIUM = T.let(:medium, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          XHIGH = T.let(:xhigh, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)
          MAX = T.let(:max, OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentReasoningParam::Effort::TaggedSymbol]) }
          def self.values
          end
        end

        # The reasoning summary format requested from the model.
        module Summary
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentReasoningParam::Summary) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Returns a concise reasoning summary when supported.
          CONCISE = T.let(:concise, OpenAI::Beta::AgentReasoningParam::Summary::TaggedSymbol)

          # Returns a detailed reasoning summary when supported.
          DETAILED = T.let(:detailed, OpenAI::Beta::AgentReasoningParam::Summary::TaggedSymbol)

          # Automatically selects the most detailed summary supported by the model.
          AUTO = T.let(:auto, OpenAI::Beta::AgentReasoningParam::Summary::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentReasoningParam::Summary::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

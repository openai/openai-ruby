# typed: strong

module OpenAI
  module Models

    module Beta

      # An output item produced by an agent.
      module AgentOutputItem
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionAssistantMessage,
            OpenAI::Beta::AgentReasoningItem,
            OpenAI::Beta::AgentFunctionCallItem,
            OpenAI::Beta::AgentMcpCallItem,
            OpenAI::Beta::AgentWebSearchCallItem,
            OpenAI::Beta::AgentCommandExecutionItem,
            OpenAI::Beta::AgentCreateSubagentCallItem,
            OpenAI::Beta::AgentSendSubagentInputCallItem,
            OpenAI::Beta::AgentResumeSubagentCallItem,
            OpenAI::Beta::AgentWaitForSubagentsCallItem,
            OpenAI::Beta::AgentInterruptSubagentCallItem,
            OpenAI::Beta::AgentCloseSubagentCallItem
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentOutputItem::Variants]) }
        def self.variants
        end

      end

    end

  end
end

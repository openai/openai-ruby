# typed: strong

module OpenAI
  module Models

    module Beta

      # The status of a tool call.
      module AgentFunctionCallStatus
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentFunctionCallStatus) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        # The call is in progress.
        IN_PROGRESS = T.let(:in_progress, OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol)

        # The call completed successfully.
        COMPLETED = T.let(:completed, OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol)

        # The call failed.
        FAILED = T.let(:failed, OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol)

        # The call stopped before completing.
        INCOMPLETE = T.let(:incomplete, OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end

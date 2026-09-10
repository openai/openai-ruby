# typed: strong

module OpenAI
  module Models

    module Beta

      # The status of an agent output item.
      module AgentOutputItemStatus
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentOutputItemStatus) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        # The item is in progress.
        IN_PROGRESS = T.let(:in_progress, OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol)

        # The item is complete.
        COMPLETED = T.let(:completed, OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol)

        # The item stopped before completing.
        INCOMPLETE = T.let(:incomplete, OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Beta::AgentOutputItemStatus::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end

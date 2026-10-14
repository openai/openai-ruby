# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The status of an agent output item.
      module AgentOutputItemStatus
        extend OpenAI::Internal::Type::Enum

        # The item is in progress.
        IN_PROGRESS = :in_progress

        # The item is complete.
        COMPLETED = :completed

        # The item stopped before completing.
        INCOMPLETE = :incomplete

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

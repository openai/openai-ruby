# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The status of a tool call.
      module AgentFunctionCallStatus
        extend OpenAI::Internal::Type::Enum

        # The call is in progress.
        IN_PROGRESS = :in_progress

        # The call completed successfully.
        COMPLETED = :completed

        # The call failed.
        FAILED = :failed

        # The call stopped before completing.
        INCOMPLETE = :incomplete

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # The status of the response generation. One of `completed`, `failed`,
      # `in_progress`, or `incomplete`.
      module ResponseStatus
        extend OpenAI::Internal::Type::Enum

        COMPLETED = :completed
        FAILED = :failed
        IN_PROGRESS = :in_progress
        INCOMPLETE = :incomplete

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

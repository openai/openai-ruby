# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # The status of the response generation. One of `completed`, `failed`,
      # `in_progress`, `cancelled`, `queued`, or `incomplete`.
      module BetaResponseStatus
        extend OpenAI::Internal::Type::Enum

        COMPLETED = :completed
        FAILED = :failed
        IN_PROGRESS = :in_progress
        CANCELLED = :cancelled
        QUEUED = :queued
        INCOMPLETE = :incomplete

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end

    BetaResponseStatus = Beta::BetaResponseStatus
  end
end

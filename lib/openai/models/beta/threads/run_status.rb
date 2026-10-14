# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # The status of the run, which can be either `queued`, `in_progress`,
        # `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
        # `incomplete`, or `expired`.
        module RunStatus
          extend OpenAI::Internal::Type::Enum

          QUEUED = :queued
          IN_PROGRESS = :in_progress
          REQUIRES_ACTION = :requires_action
          CANCELLING = :cancelling
          CANCELLED = :cancelled
          FAILED = :failed
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          EXPIRED = :expired

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

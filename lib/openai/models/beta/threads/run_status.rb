# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @abstract
        #
        # The status of the run, which can be either `queued`, `in_progress`,
        #   `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
        #   `incomplete`, or `expired`.
        class RunStatus < OpenAI::Enum
          QUEUED = :queued
          IN_PROGRESS = :in_progress
          REQUIRES_ACTION = :requires_action
          CANCELLING = :cancelling
          CANCELLED = :cancelled
          FAILED = :failed
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          EXPIRED = :expired

          finalize!
        end
      end
    end
  end
end

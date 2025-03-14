# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # The status of the run, which can be either `queued`, `in_progress`,
        #   `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
        #   `incomplete`, or `expired`.
        class RunStatus < OpenAI::Enum
          abstract!

          QUEUED = :queued
          IN_PROGRESS = :in_progress
          REQUIRES_ACTION = :requires_action
          CANCELLING = :cancelling
          CANCELLED = :cancelled
          FAILED = :failed
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          EXPIRED = :expired

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end

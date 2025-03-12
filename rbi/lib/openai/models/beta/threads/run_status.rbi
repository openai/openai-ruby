# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
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

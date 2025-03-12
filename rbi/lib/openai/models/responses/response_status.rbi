# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseStatus < OpenAI::Enum
        abstract!

        COMPLETED = :completed
        FAILED = :failed
        IN_PROGRESS = :in_progress
        INCOMPLETE = :incomplete

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end

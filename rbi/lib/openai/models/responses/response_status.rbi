# typed: strong

module OpenAI
  module Models
    module Responses
      # The status of the response generation. One of `completed`, `failed`,
      #   `in_progress`, or `incomplete`.
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

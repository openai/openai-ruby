# typed: strong

module OpenAI
  module Models
    module Responses
      # The status of the response generation. One of `completed`, `failed`,
      #   `in_progress`, or `incomplete`.
      class ResponseStatus < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        COMPLETED = :completed
        FAILED = :failed
        IN_PROGRESS = :in_progress
        INCOMPLETE = :incomplete
      end
    end
  end
end

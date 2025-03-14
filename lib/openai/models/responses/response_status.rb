# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @abstract
      #
      # The status of the response generation. One of `completed`, `failed`,
      #   `in_progress`, or `incomplete`.
      class ResponseStatus < OpenAI::Enum
        COMPLETED = :completed
        FAILED = :failed
        IN_PROGRESS = :in_progress
        INCOMPLETE = :incomplete

        finalize!
      end
    end
  end
end

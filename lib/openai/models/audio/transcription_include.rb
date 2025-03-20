# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @abstract
      class TranscriptionInclude < OpenAI::Enum
        LOGPROBS = :logprobs

        finalize!
      end
    end
  end
end

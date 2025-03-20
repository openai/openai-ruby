# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Enum

        LOGPROBS = :logprobs

        finalize!
      end
    end
  end
end

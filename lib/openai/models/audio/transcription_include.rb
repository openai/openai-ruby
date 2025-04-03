# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Internal::Type::Enum

        LOGPROBS = :logprobs

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end

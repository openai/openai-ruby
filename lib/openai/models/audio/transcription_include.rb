# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Enum

        LOGPROBS = :logprobs

        finalize!

        class << self
          # @!parse
          #   # @return [Array<Symbol>]
          #   def values; end
        end
      end
    end
  end
end

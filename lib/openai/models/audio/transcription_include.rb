# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Internal::Type::Enum

        LOGPROBS = :logprobs

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

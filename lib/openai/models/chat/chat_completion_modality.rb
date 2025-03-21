# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Enum

        TEXT = :text
        AUDIO = :audio

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Enum

        TEXT = :text
        AUDIO = :audio

        finalize!

        class << self
          # @!parse
          #   # @return [Array<Symbol>]
          #   def values; end
        end
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

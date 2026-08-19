# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Internal::Type::Enum

        TEXT = :text
        AUDIO = :audio

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

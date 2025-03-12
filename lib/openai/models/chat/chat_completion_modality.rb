# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @abstract
      #
      class ChatCompletionModality < OpenAI::Enum
        TEXT = :text
        AUDIO = :audio

        finalize!
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

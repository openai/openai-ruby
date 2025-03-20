# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # The role of the author of a message
      module ChatCompletionRole
        extend OpenAI::Enum

        DEVELOPER = :developer
        SYSTEM = :system
        USER = :user
        ASSISTANT = :assistant
        TOOL = :tool
        FUNCTION = :function

        finalize!
      end
    end

    ChatCompletionRole = Chat::ChatCompletionRole
  end
end

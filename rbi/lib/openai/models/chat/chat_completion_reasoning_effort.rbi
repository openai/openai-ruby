# typed: strong

module OpenAI
  module Models
    ChatCompletionReasoningEffort = T.type_alias { Chat::ChatCompletionReasoningEffort }

    module Chat
      ChatCompletionReasoningEffort = T.type_alias { OpenAI::Models::ReasoningEffort }
    end
  end
end

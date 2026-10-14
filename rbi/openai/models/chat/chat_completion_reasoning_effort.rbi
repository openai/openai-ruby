# typed: strong

module OpenAI
  module Models
    ChatCompletionReasoningEffort = Chat::ChatCompletionReasoningEffort

    module Chat
      ChatCompletionReasoningEffort = OpenAI::Models::ReasoningEffort
    end
  end
end

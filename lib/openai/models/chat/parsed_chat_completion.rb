# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ParsedChoice < OpenAI::Models::Chat::ChatCompletion::Choice
        optional :finish_reason, enum: -> { OpenAI::Chat::ChatCompletion::Choice::FinishReason }, nil?: true
      end

      class ParsedChatCompletion < ChatCompletion
        required :choices, -> { OpenAI::Internal::Type::ArrayOf[ParsedChoice] }
      end
    end
  end
end

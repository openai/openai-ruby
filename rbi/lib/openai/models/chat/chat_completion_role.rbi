# typed: strong

module OpenAI
  module Models
    module Chat
      # The role of the author of a message
      module ChatCompletionRole
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionRole) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol) }

        DEVELOPER = T.let(:developer, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
        SYSTEM = T.let(:system, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
        USER = T.let(:user, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
        ASSISTANT = T.let(:assistant, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
        TOOL = T.let(:tool, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
        FUNCTION = T.let(:function, OpenAI::Models::Chat::ChatCompletionRole::OrSymbol)
      end
    end

    ChatCompletionRole = Chat::ChatCompletionRole
  end
end

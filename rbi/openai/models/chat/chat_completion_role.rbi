# typed: strong

module OpenAI
  module Models
    ChatCompletionRole = Chat::ChatCompletionRole

    module Chat
      # The role of the author of a message
      module ChatCompletionRole
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionRole) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        DEVELOPER = T.let(:developer, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        SYSTEM = T.let(:system, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        USER = T.let(:user, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        ASSISTANT = T.let(:assistant, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        TOOL = T.let(:tool, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        FUNCTION = T.let(:function, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end

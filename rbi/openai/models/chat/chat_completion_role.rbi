# typed: strong

module OpenAI
  module Models
    ChatCompletionRole = Chat::ChatCompletionRole

    module Chat
      # The role of the author of a message
      module ChatCompletionRole
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Chat::ChatCompletionRole) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        DEVELOPER =
          T.let(:developer, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)
        SYSTEM = T.let(:system, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)
        USER = T.let(:user, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)
        ASSISTANT =
          T.let(:assistant, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)
        TOOL = T.let(:tool, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)
        FUNCTION =
          T.let(:function, OpenAI::Chat::ChatCompletionRole::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionRole::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end

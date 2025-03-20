# typed: strong

module OpenAI
  module Models
    module Chat
      # The role of the author of a message
      module ChatCompletionRole
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionRole) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol) }

        DEVELOPER = T.let(:developer, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        SYSTEM = T.let(:system, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        USER = T.let(:user, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        ASSISTANT = T.let(:assistant, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        TOOL = T.let(:tool, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)
        FUNCTION = T.let(:function, OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionRole::TaggedSymbol]) }
          def values
          end
        end
      end
    end

    ChatCompletionRole = Chat::ChatCompletionRole
  end
end

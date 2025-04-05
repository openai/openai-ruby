# typed: strong

module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionModality) }
        OrSymbol =
          T.type_alias { T.any(Symbol, String, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol) }

        TEXT = T.let(:text, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol)
        AUDIO = T.let(:audio, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol]) }
        def self.values; end
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

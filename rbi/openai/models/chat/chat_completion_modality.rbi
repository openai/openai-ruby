# typed: strong

module OpenAI
  module Models
    ChatCompletionModality = Chat::ChatCompletionModality

    module Chat
      module ChatCompletionModality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Chat::ChatCompletionModality) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TEXT = T.let(:text, OpenAI::Chat::ChatCompletionModality::TaggedSymbol)
        AUDIO =
          T.let(:audio, OpenAI::Chat::ChatCompletionModality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionModality::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end

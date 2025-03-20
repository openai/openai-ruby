# typed: strong

module OpenAI
  module Models
    module Chat
      module ChatCompletionModality
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionModality) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol) }

        TEXT = T.let(:text, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol)
        AUDIO = T.let(:audio, OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionModality::TaggedSymbol]) }
          def values
          end
        end
      end
    end

    ChatCompletionModality = Chat::ChatCompletionModality
  end
end

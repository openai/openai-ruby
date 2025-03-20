# typed: strong

module OpenAI
  module Models
    module Audio
      module SpeechModel
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::SpeechModel) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Audio::SpeechModel::TaggedSymbol) }

        TTS_1 = T.let(:"tts-1", OpenAI::Models::Audio::SpeechModel::TaggedSymbol)
        TTS_1_HD = T.let(:"tts-1-hd", OpenAI::Models::Audio::SpeechModel::TaggedSymbol)
        GPT_4O_MINI_TTS = T.let(:"gpt-4o-mini-tts", OpenAI::Models::Audio::SpeechModel::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Audio::SpeechModel::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end

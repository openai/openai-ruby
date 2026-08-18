# typed: strong

module OpenAI
  module Models
    module Audio
      module SpeechModel
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Audio::SpeechModel) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TTS_1 = T.let(:"tts-1", OpenAI::Audio::SpeechModel::TaggedSymbol)
        TTS_1_HD = T.let(:"tts-1-hd", OpenAI::Audio::SpeechModel::TaggedSymbol)
        GPT_4O_MINI_TTS =
          T.let(:"gpt-4o-mini-tts", OpenAI::Audio::SpeechModel::TaggedSymbol)
        GPT_4O_MINI_TTS_2025_12_15 =
          T.let(
            :"gpt-4o-mini-tts-2025-12-15",
            OpenAI::Audio::SpeechModel::TaggedSymbol
          )

        sig do
          override.returns(T::Array[OpenAI::Audio::SpeechModel::TaggedSymbol])
        end
        def self.values
        end
      end
    end
  end
end

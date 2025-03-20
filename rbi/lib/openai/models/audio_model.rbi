# typed: strong

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AudioModel) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::AudioModel::TaggedSymbol) }

      WHISPER_1 = T.let(:"whisper-1", OpenAI::Models::AudioModel::TaggedSymbol)
      GPT_4O_TRANSCRIBE = T.let(:"gpt-4o-transcribe", OpenAI::Models::AudioModel::TaggedSymbol)
      GPT_4O_MINI_TRANSCRIBE = T.let(:"gpt-4o-mini-transcribe", OpenAI::Models::AudioModel::TaggedSymbol)

      class << self
        sig { override.returns(T::Array[OpenAI::Models::AudioModel::TaggedSymbol]) }
        def values
        end
      end
    end
  end
end

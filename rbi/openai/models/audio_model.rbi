# typed: strong

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::AudioModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      WHISPER_1 = T.let(:"whisper-1", OpenAI::AudioModel::TaggedSymbol)
      GPT_4O_TRANSCRIBE =
        T.let(:"gpt-4o-transcribe", OpenAI::AudioModel::TaggedSymbol)
      GPT_4O_MINI_TRANSCRIBE =
        T.let(:"gpt-4o-mini-transcribe", OpenAI::AudioModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::AudioModel::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

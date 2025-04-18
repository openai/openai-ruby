# typed: strong

module OpenAI
  module Models
    module AudioModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AudioModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      WHISPER_1 = T.let(:"whisper-1", OpenAI::Models::AudioModel::TaggedSymbol)
      GPT_4O_TRANSCRIBE = T.let(:"gpt-4o-transcribe", OpenAI::Models::AudioModel::TaggedSymbol)
      GPT_4O_MINI_TRANSCRIBE = T.let(:"gpt-4o-mini-transcribe", OpenAI::Models::AudioModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::Models::AudioModel::TaggedSymbol]) }
      def self.values; end
    end
  end
end

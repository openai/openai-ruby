# typed: strong

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    # `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
    # the only supported format is `json`.
    module AudioResponseFormat
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AudioResponseFormat) }
      OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::AudioResponseFormat::TaggedSymbol) }

      JSON = T.let(:json, OpenAI::Models::AudioResponseFormat::TaggedSymbol)
      TEXT = T.let(:text, OpenAI::Models::AudioResponseFormat::TaggedSymbol)
      SRT = T.let(:srt, OpenAI::Models::AudioResponseFormat::TaggedSymbol)
      VERBOSE_JSON = T.let(:verbose_json, OpenAI::Models::AudioResponseFormat::TaggedSymbol)
      VTT = T.let(:vtt, OpenAI::Models::AudioResponseFormat::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::Models::AudioResponseFormat::TaggedSymbol]) }
      def self.values; end
    end
  end
end

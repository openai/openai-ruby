# typed: strong

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    # `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
    # `gpt-4o-mini-transcribe`, the only supported format is `json`. For
    # `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
    # `diarized_json`, with `diarized_json` required to receive speaker annotations.
    module AudioResponseFormat
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::AudioResponseFormat) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      JSON = T.let(:json, OpenAI::AudioResponseFormat::TaggedSymbol)
      TEXT = T.let(:text, OpenAI::AudioResponseFormat::TaggedSymbol)
      SRT = T.let(:srt, OpenAI::AudioResponseFormat::TaggedSymbol)
      VERBOSE_JSON =
        T.let(:verbose_json, OpenAI::AudioResponseFormat::TaggedSymbol)
      VTT = T.let(:vtt, OpenAI::AudioResponseFormat::TaggedSymbol)
      DIARIZED_JSON =
        T.let(:diarized_json, OpenAI::AudioResponseFormat::TaggedSymbol)

      sig do
        override.returns(T::Array[OpenAI::AudioResponseFormat::TaggedSymbol])
      end
      def self.values
      end
    end
  end
end

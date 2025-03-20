# typed: strong

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    #   `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
    #   the only supported format is `json`.
    module AudioResponseFormat
      extend OpenAI::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::AudioResponseFormat) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::AudioResponseFormat::TaggedSymbol) }

      JSON = T.let(:json, OpenAI::Models::AudioResponseFormat::OrSymbol)
      TEXT = T.let(:text, OpenAI::Models::AudioResponseFormat::OrSymbol)
      SRT = T.let(:srt, OpenAI::Models::AudioResponseFormat::OrSymbol)
      VERBOSE_JSON = T.let(:verbose_json, OpenAI::Models::AudioResponseFormat::OrSymbol)
      VTT = T.let(:vtt, OpenAI::Models::AudioResponseFormat::OrSymbol)
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    # `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
    # `gpt-4o-mini-transcribe`, the only supported format is `json`. For
    # `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
    # `diarized_json`, with `diarized_json` required to receive speaker annotations.
    module AudioResponseFormat
      extend OpenAI::Internal::Type::Enum

      JSON = :json
      TEXT = :text
      SRT = :srt
      VERBOSE_JSON = :verbose_json
      VTT = :vtt
      DIARIZED_JSON = :diarized_json

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end

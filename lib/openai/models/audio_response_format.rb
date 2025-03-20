# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    #   `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
    #   the only supported format is `json`.
    class AudioResponseFormat < OpenAI::Enum
      JSON = :json
      TEXT = :text
      SRT = :srt
      VERBOSE_JSON = :verbose_json
      VTT = :vtt

      finalize!
    end
  end
end

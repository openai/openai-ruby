# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    #   `verbose_json`, or `vtt`.
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

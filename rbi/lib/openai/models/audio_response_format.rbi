# typed: strong

module OpenAI
  module Models
    # The format of the output, in one of these options: `json`, `text`, `srt`,
    #   `verbose_json`, or `vtt`.
    class AudioResponseFormat < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      JSON = :json
      TEXT = :text
      SRT = :srt
      VERBOSE_JSON = :verbose_json
      VTT = :vtt
    end
  end
end

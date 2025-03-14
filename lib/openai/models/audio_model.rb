# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    class AudioModel < OpenAI::Enum
      WHISPER_1 = :"whisper-1"

      finalize!
    end
  end
end

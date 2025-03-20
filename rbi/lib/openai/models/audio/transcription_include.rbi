# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionInclude < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        LOGPROBS = :logprobs
      end
    end
  end
end

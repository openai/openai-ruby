# typed: strong

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranscriptionInclude) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol) }

        LOGPROBS = T.let(:logprobs, OpenAI::Models::Audio::TranscriptionInclude::OrSymbol)
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranscriptionInclude) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOGPROBS = T.let(:logprobs, OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranscriptionInclude) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol) }

        LOGPROBS = T.let(:logprobs, OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Audio::TranscriptionInclude::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end

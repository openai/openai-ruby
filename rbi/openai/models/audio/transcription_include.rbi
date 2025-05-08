# typed: strong

module OpenAI
  module Models
    module Audio
      module TranscriptionInclude
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Audio::TranscriptionInclude) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOGPROBS =
          T.let(:logprobs, OpenAI::Audio::TranscriptionInclude::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Audio::TranscriptionInclude::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end

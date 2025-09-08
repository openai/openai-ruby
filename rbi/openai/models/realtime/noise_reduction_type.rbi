# typed: strong

module OpenAI
  module Models
    module Realtime
      # Type of noise reduction. `near_field` is for close-talking microphones such as
      # headphones, `far_field` is for far-field microphones such as laptop or
      # conference room microphones.
      module NoiseReductionType
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Realtime::NoiseReductionType) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        NEAR_FIELD =
          T.let(:near_field, OpenAI::Realtime::NoiseReductionType::TaggedSymbol)
        FAR_FIELD =
          T.let(:far_field, OpenAI::Realtime::NoiseReductionType::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::NoiseReductionType::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end

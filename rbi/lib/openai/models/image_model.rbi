# typed: strong

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageModel) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageModel::TaggedSymbol) }

      DALL_E_2 = T.let(:"dall-e-2", OpenAI::Models::ImageModel::TaggedSymbol)
      DALL_E_3 = T.let(:"dall-e-3", OpenAI::Models::ImageModel::TaggedSymbol)

      class << self
        sig { override.returns(T::Array[OpenAI::Models::ImageModel::TaggedSymbol]) }
        def values
        end
      end
    end
  end
end

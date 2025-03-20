# typed: strong

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageModel) }
      OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageModel::TaggedSymbol) }

      DALL_E_2 = T.let(:"dall-e-2", OpenAI::Models::ImageModel::OrSymbol)
      DALL_E_3 = T.let(:"dall-e-3", OpenAI::Models::ImageModel::OrSymbol)
    end
  end
end

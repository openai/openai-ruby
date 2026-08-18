# typed: strong

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      GPT_IMAGE_1 = T.let(:"gpt-image-1", OpenAI::ImageModel::TaggedSymbol)
      GPT_IMAGE_1_MINI =
        T.let(:"gpt-image-1-mini", OpenAI::ImageModel::TaggedSymbol)
      GPT_IMAGE_2 = T.let(:"gpt-image-2", OpenAI::ImageModel::TaggedSymbol)
      GPT_IMAGE_2_2026_04_21 =
        T.let(:"gpt-image-2-2026-04-21", OpenAI::ImageModel::TaggedSymbol)
      GPT_IMAGE_1_5 = T.let(:"gpt-image-1.5", OpenAI::ImageModel::TaggedSymbol)
      CHATGPT_IMAGE_LATEST =
        T.let(:"chatgpt-image-latest", OpenAI::ImageModel::TaggedSymbol)
      DALL_E_2 = T.let(:"dall-e-2", OpenAI::ImageModel::TaggedSymbol)
      DALL_E_3 = T.let(:"dall-e-3", OpenAI::ImageModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ImageModel::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module VideoModel
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias { T.any(String, OpenAI::VideoModel::TaggedSymbol) }

      sig { override.returns(T::Array[OpenAI::VideoModel::Variants]) }
      def self.variants
      end

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::VideoModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      SORA_2 = T.let(:"sora-2", OpenAI::VideoModel::TaggedSymbol)
      SORA_2_PRO = T.let(:"sora-2-pro", OpenAI::VideoModel::TaggedSymbol)
      SORA_2_2025_10_06 =
        T.let(:"sora-2-2025-10-06", OpenAI::VideoModel::TaggedSymbol)
      SORA_2_PRO_2025_10_06 =
        T.let(:"sora-2-pro-2025-10-06", OpenAI::VideoModel::TaggedSymbol)
      SORA_2_2025_12_08 =
        T.let(:"sora-2-2025-12-08", OpenAI::VideoModel::TaggedSymbol)
    end
  end
end

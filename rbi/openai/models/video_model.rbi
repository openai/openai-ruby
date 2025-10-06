# typed: strong

module OpenAI
  module Models
    module VideoModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::VideoModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      SORA_2 = T.let(:"sora-2", OpenAI::VideoModel::TaggedSymbol)
      SORA_2_PRO = T.let(:"sora-2-pro", OpenAI::VideoModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::VideoModel::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

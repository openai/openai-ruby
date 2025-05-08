# typed: strong

module OpenAI
  module Models
    module ModerationModel
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ModerationModel) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      OMNI_MODERATION_LATEST =
        T.let(:"omni-moderation-latest", OpenAI::ModerationModel::TaggedSymbol)
      OMNI_MODERATION_2024_09_26 =
        T.let(
          :"omni-moderation-2024-09-26",
          OpenAI::ModerationModel::TaggedSymbol
        )
      TEXT_MODERATION_LATEST =
        T.let(:"text-moderation-latest", OpenAI::ModerationModel::TaggedSymbol)
      TEXT_MODERATION_STABLE =
        T.let(:"text-moderation-stable", OpenAI::ModerationModel::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ModerationModel::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

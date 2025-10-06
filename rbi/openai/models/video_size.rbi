# typed: strong

module OpenAI
  module Models
    module VideoSize
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::VideoSize) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      VIDEO_SIZE_720X1280 = T.let(:"720x1280", OpenAI::VideoSize::TaggedSymbol)
      VIDEO_SIZE_1280X720 = T.let(:"1280x720", OpenAI::VideoSize::TaggedSymbol)
      VIDEO_SIZE_1024X1792 =
        T.let(:"1024x1792", OpenAI::VideoSize::TaggedSymbol)
      VIDEO_SIZE_1792X1024 =
        T.let(:"1792x1024", OpenAI::VideoSize::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::VideoSize::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

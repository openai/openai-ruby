# typed: strong

module OpenAI
  module Models
    module VideoSeconds
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::VideoSeconds) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      VIDEO_SECONDS_4 = T.let(:"4", OpenAI::VideoSeconds::TaggedSymbol)
      VIDEO_SECONDS_8 = T.let(:"8", OpenAI::VideoSeconds::TaggedSymbol)
      VIDEO_SECONDS_12 = T.let(:"12", OpenAI::VideoSeconds::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::VideoSeconds::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

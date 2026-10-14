# typed: strong

module OpenAI
  module Models
    Metadata =
      T.let(
        OpenAI::Internal::Type::HashOf[String],
        OpenAI::Internal::Type::Converter
      )
  end
end

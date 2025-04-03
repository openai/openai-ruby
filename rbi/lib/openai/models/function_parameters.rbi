# typed: strong

module OpenAI
  module Models
    FunctionParameters =
      T.let(
        OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
        OpenAI::Internal::Type::Converter
      )
  end
end

# typed: strong

module OpenAI
  module Models
    FunctionParameters = T.let(OpenAI::HashOf[OpenAI::Unknown], OpenAI::Internal::Type::Converter)
  end
end

# typed: strong

module OpenAI
  module Models
    FunctionParameters = T.let(OpenAI::HashOf[OpenAI::Unknown], OpenAI::Type::Converter)
  end
end

# typed: strong

module OpenAI
  module Models
    FunctionParameters = T.let(OpenAI::HashOf[OpenAI::Unknown], OpenAI::Converter)
  end
end

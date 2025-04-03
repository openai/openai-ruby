# typed: strong

module OpenAI
  module Models
    Metadata = T.let(OpenAI::HashOf[String], OpenAI::Internal::Type::Converter)
  end
end

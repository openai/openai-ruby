# typed: strong

module OpenAI
  module Models
    Metadata = T.let(OpenAI::HashOf[String], OpenAI::Converter)
  end
end

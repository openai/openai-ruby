# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInput =
        T.let(OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputItem], OpenAI::Converter)
    end
  end
end

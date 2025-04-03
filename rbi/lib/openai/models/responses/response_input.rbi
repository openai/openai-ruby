# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInput =
        T.let(
          OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputItem],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInput =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Responses::ResponseInputItem
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

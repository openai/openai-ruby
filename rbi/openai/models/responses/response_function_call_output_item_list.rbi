# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseFunctionCallOutputItemList =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Responses::ResponseFunctionCallOutputItem
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

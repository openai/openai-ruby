# typed: strong

module OpenAI
  module Models
    module Responses
      ResponseInputMessageContentList =
        T.let(
          OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputContent],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

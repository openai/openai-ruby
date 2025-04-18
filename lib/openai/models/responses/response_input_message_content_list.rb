# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      ResponseInputMessageContentList =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Models::Responses::ResponseInputContent }]
    end
  end
end

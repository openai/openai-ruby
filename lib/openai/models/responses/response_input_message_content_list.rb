# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @type [OpenAI::Internal::Type::Converter]
      ResponseInputMessageContentList =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ResponseInputContent }]
    end
  end
end

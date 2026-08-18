# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @type [OpenAI::Internal::Type::Converter]
      ResponseFunctionCallOutputItemList =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ResponseFunctionCallOutputItem }]
    end
  end
end

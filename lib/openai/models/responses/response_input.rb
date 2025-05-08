# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @type [OpenAI::Internal::Type::Converter]
      ResponseInput = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ResponseInputItem }]
    end
  end
end

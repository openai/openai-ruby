# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      ResponseInput =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Models::Responses::ResponseInputItem }]
    end
  end
end

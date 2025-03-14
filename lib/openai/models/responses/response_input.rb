# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      ResponseInput = OpenAI::ArrayOf[union: -> { OpenAI::Models::Responses::ResponseInputItem }]
    end
  end
end

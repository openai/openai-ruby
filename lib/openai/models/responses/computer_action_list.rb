# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @type [OpenAI::Internal::Type::Converter]
      ComputerActionList = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ComputerAction }]
    end
  end
end

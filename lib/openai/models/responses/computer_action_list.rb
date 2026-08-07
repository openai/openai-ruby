# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Responses
      # @type [OpenAI::Internal::Type::Converter]
      ComputerActionList = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Responses::ComputerAction }]
    end
  end
end

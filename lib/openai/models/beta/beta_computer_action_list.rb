# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Beta
      # @type [OpenAI::Internal::Type::Converter]
      BetaComputerActionList = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaComputerAction }]
    end

    # @type [OpenAI::Internal::Type::Converter]
    BetaComputerActionList = Beta::BetaComputerActionList
  end
end

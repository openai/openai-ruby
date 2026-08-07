# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Beta
      # @type [OpenAI::Internal::Type::Converter]
      BetaResponseFunctionCallOutputItemList =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaResponseFunctionCallOutputItem }]
    end

    # @type [OpenAI::Internal::Type::Converter]
    BetaResponseFunctionCallOutputItemList = Beta::BetaResponseFunctionCallOutputItemList
  end
end

# frozen_string_literal: true

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

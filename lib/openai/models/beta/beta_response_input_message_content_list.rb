# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @type [OpenAI::Internal::Type::Converter]
      BetaResponseInputMessageContentList =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaResponseInputContent }]
    end

    # @type [OpenAI::Internal::Type::Converter]
    BetaResponseInputMessageContentList = Beta::BetaResponseInputMessageContentList
  end
end

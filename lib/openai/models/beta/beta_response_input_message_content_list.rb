# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
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

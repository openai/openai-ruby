# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Beta
      # @type [OpenAI::Internal::Type::Converter]
      BetaResponseInput = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Beta::BetaResponseInputItem }]
    end

    # @type [OpenAI::Internal::Type::Converter]
    BetaResponseInput = Beta::BetaResponseInput
  end
end

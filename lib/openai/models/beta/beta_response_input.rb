# frozen_string_literal: true

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

# typed: strong
# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

module OpenAI
  module Models
    BetaComputerActionList =
      T.let(Beta::BetaComputerActionList, OpenAI::Internal::Type::Converter)

    module Beta
      BetaComputerActionList =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::BetaComputerAction
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

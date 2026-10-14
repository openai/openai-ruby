# typed: strong

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

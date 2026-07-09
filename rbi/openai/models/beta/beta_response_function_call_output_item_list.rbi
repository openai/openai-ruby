# typed: strong

module OpenAI
  module Models
    BetaResponseFunctionCallOutputItemList =
      T.let(
        Beta::BetaResponseFunctionCallOutputItemList,
        OpenAI::Internal::Type::Converter
      )

    module Beta
      BetaResponseFunctionCallOutputItemList =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::BetaResponseFunctionCallOutputItem
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

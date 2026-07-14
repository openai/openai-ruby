# typed: strong

module OpenAI
  module Models
    BetaResponseInput =
      T.let(Beta::BetaResponseInput, OpenAI::Internal::Type::Converter)

    module Beta
      BetaResponseInput =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::BetaResponseInputItem
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

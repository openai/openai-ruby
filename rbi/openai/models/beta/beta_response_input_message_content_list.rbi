# typed: strong

module OpenAI
  module Models
    BetaResponseInputMessageContentList =
      T.let(
        Beta::BetaResponseInputMessageContentList,
        OpenAI::Internal::Type::Converter
      )

    module Beta
      BetaResponseInputMessageContentList =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::BetaResponseInputContent
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

# typed: strong

module OpenAI
  module Models

    module Live

      DecisionJSONObject = T.let(
        OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
        OpenAI::Internal::Type::Converter
      )

    end

  end
end

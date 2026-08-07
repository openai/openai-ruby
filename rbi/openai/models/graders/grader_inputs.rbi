# typed: strong
# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

module OpenAI
  module Models
    GraderInputs =
      T.let(Graders::GraderInputs, OpenAI::Internal::Type::Converter)

    module Graders
      GraderInputs =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Graders::GraderInputItem
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

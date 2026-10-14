# typed: strong

module OpenAI
  module Models
    module Responses
      ComputerActionList =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Responses::ComputerAction
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end

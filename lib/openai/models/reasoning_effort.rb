# frozen_string_literal: true

module OpenAI
  module Models
    # Constrains effort on reasoning for
    # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
    # effort can result in faster responses and fewer tokens used on reasoning in a
    # response.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      MINIMAL = :minimal
      LOW = :low
      MEDIUM = :medium
      HIGH = :high

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end

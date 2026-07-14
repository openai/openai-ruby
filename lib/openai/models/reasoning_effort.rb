# frozen_string_literal: true

module OpenAI
  module Models
    # Constrains effort on reasoning for reasoning models. Currently supported values
    # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
    # reasoning effort can result in faster responses and fewer tokens used on
    # reasoning in a response. Not all reasoning models support every value. See the
    # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
    # model-specific support.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      NONE = :none
      MINIMAL = :minimal
      LOW = :low
      MEDIUM = :medium
      HIGH = :high
      XHIGH = :xhigh
      MAX = :max

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end

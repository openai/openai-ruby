# frozen_string_literal: true

module OpenAI
  module Models
    # **o-series models only**
    #
    # Constrains effort on reasoning for
    # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    # supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
    # result in faster responses and fewer tokens used on reasoning in a response.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      LOW = :low
      MEDIUM = :medium
      HIGH = :high

      finalize!

      # @!parse
      #   # @return [Array<Symbol>]
      #   def self.values; end
    end
  end
end

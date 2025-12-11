# frozen_string_literal: true

module OpenAI
  module Models
    # Constrains effort on reasoning for
    # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
    # Reducing reasoning effort can result in faster responses and fewer tokens used
    # on reasoning in a response.
    #
    # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
    #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
    #   calls are supported for all reasoning values in gpt-5.1.
    # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
    #   support `none`.
    # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
    # - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      NONE = :none
      MINIMAL = :minimal
      LOW = :low
      MEDIUM = :medium
      HIGH = :high
      XHIGH = :xhigh

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end

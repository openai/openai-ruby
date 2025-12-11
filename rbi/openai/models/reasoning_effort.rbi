# typed: strong

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

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ReasoningEffort) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      NONE = T.let(:none, OpenAI::ReasoningEffort::TaggedSymbol)
      MINIMAL = T.let(:minimal, OpenAI::ReasoningEffort::TaggedSymbol)
      LOW = T.let(:low, OpenAI::ReasoningEffort::TaggedSymbol)
      MEDIUM = T.let(:medium, OpenAI::ReasoningEffort::TaggedSymbol)
      HIGH = T.let(:high, OpenAI::ReasoningEffort::TaggedSymbol)
      XHIGH = T.let(:xhigh, OpenAI::ReasoningEffort::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ReasoningEffort::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

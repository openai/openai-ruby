# typed: strong

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

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ReasoningEffort) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      NONE = T.let(:none, OpenAI::ReasoningEffort::TaggedSymbol)
      MINIMAL = T.let(:minimal, OpenAI::ReasoningEffort::TaggedSymbol)
      LOW = T.let(:low, OpenAI::ReasoningEffort::TaggedSymbol)
      MEDIUM = T.let(:medium, OpenAI::ReasoningEffort::TaggedSymbol)
      HIGH = T.let(:high, OpenAI::ReasoningEffort::TaggedSymbol)
      XHIGH = T.let(:xhigh, OpenAI::ReasoningEffort::TaggedSymbol)
      MAX = T.let(:max, OpenAI::ReasoningEffort::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ReasoningEffort::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

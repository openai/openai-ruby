# typed: strong

module OpenAI
  module Models
    # **o-series models only**
    #
    #   Constrains effort on reasoning for
    #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
    #   result in faster responses and fewer tokens used on reasoning in a response.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ReasoningEffort) }
      OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::ReasoningEffort::TaggedSymbol) }

      LOW = T.let(:low, OpenAI::Models::ReasoningEffort::TaggedSymbol)
      MEDIUM = T.let(:medium, OpenAI::Models::ReasoningEffort::TaggedSymbol)
      HIGH = T.let(:high, OpenAI::Models::ReasoningEffort::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::Models::ReasoningEffort::TaggedSymbol]) }
      def self.values; end
    end
  end
end

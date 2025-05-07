# typed: strong

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

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ReasoningEffort) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      LOW = T.let(:low, OpenAI::ReasoningEffort::TaggedSymbol)
      MEDIUM = T.let(:medium, OpenAI::ReasoningEffort::TaggedSymbol)
      HIGH = T.let(:high, OpenAI::ReasoningEffort::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ReasoningEffort::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

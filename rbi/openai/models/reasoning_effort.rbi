# typed: strong

module OpenAI
  module Models
    # Constrains effort on reasoning for
    # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    # supported values are `minimal`, `low`, `medium`, and `high`. Reducing reasoning
    # effort can result in faster responses and fewer tokens used on reasoning in a
    # response.
    #
    # Note: The `gpt-5-pro` model defaults to (and only supports) `high` reasoning
    # effort.
    module ReasoningEffort
      extend OpenAI::Internal::Type::Enum

      TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ReasoningEffort) }
      OrSymbol = T.type_alias { T.any(Symbol, String) }

      MINIMAL = T.let(:minimal, OpenAI::ReasoningEffort::TaggedSymbol)
      LOW = T.let(:low, OpenAI::ReasoningEffort::TaggedSymbol)
      MEDIUM = T.let(:medium, OpenAI::ReasoningEffort::TaggedSymbol)
      HIGH = T.let(:high, OpenAI::ReasoningEffort::TaggedSymbol)

      sig { override.returns(T::Array[OpenAI::ReasoningEffort::TaggedSymbol]) }
      def self.values
      end
    end
  end
end

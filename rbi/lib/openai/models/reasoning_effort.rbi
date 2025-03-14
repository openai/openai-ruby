# typed: strong

module OpenAI
  module Models
    # **o-series models only**
    #
    #   Constrains effort on reasoning for
    #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
    #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
    #   result in faster responses and fewer tokens used on reasoning in a response.
    class ReasoningEffort < OpenAI::Enum
      abstract!

      LOW = T.let(:low, T.nilable(Symbol))
      MEDIUM = T.let(:medium, T.nilable(Symbol))
      HIGH = T.let(:high, T.nilable(Symbol))

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end

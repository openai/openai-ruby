# typed: strong

module OpenAI
  module Models
    ChatCompletionReasoningEffort = T.type_alias { Chat::ChatCompletionReasoningEffort }

    module Chat
      # **o1 and o3-mini models only**
      #
      #   Constrains effort on reasoning for
      #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
      #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
      #   result in faster responses and fewer tokens used on reasoning in a response.
      class ChatCompletionReasoningEffort < OpenAI::Enum
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
end

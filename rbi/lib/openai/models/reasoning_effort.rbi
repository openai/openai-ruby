# typed: strong

module OpenAI
  module Models
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

# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionsDelegationConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute model
        #
        #   @return [String]
        required :model, String

        # @!attribute questions
        #   Native Decision API questions evaluated together, in order.
        #
        #   @return [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>]
        required :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionQuestion] }

        # @!method initialize(model:, questions:)
        #   @param model [String]
        #
        #   @param questions [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>]
        #     Native Decision API questions evaluated together, in order.
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionsDelegationUpdateConfig < OpenAI::Internal::Type::BaseModel
        # @!attribute model
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute questions
        #   Native Decision API questions evaluated together, in order.
        #
        #   @return [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>, nil]
        optional :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionQuestion] }

        # @!method initialize(model: nil, questions: nil)
        #   @param model [String]
        #
        #   @param questions [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>]
        #     Native Decision API questions evaluated together, in order.
      end
    end
  end
end

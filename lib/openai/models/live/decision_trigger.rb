# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionTrigger < OpenAI::Internal::Type::BaseModel
        # @!attribute decisions
        #   Questions evaluated using the current transcript and the session's shared
        #   Decision items.
        #
        #   @return [OpenAI::Models::Live::DecisionTrigger::Decisions]
        required :decisions, -> { OpenAI::Live::DecisionTrigger::Decisions }

        # @!attribute event_type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionTrigger::EventType]
        required :event_type, enum: -> { OpenAI::Live::DecisionTrigger::EventType }

        # @!attribute type
        #
        #   @return [Symbol, :decisions]
        required :type, const: :decisions

        # @!method initialize(decisions:, event_type:, type: :decisions)
        #   @param decisions [OpenAI::Models::Live::DecisionTrigger::Decisions]
        #     Questions evaluated using the current transcript and the session's shared
        #     Decision items.
        #
        #   @param event_type [Symbol, OpenAI::Models::Live::DecisionTrigger::EventType]
        #
        #   @param type [Symbol, :decisions]

        # @see OpenAI::Models::Live::DecisionTrigger#decisions
        class Decisions < OpenAI::Internal::Type::BaseModel
          require_relative "decision_question"
          Question = ::OpenAI::Models::Live::DecisionQuestion

          # @!attribute questions
          #   Native Decision API questions evaluated together, in order.
          #
          #   @return [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>]
          required :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionQuestion] }

          # @!method initialize(questions:)
          #   Questions evaluated using the current transcript and the session's shared
          #   Decision items.
          #
          #   @param questions [Array<OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score>]
          #     Native Decision API questions evaluated together, in order.
        end

        # @see OpenAI::Models::Live::DecisionTrigger#event_type
        module EventType
          extend OpenAI::Internal::Type::Enum

          SESSION_INPUT_TRANSCRIPT_DELTA = :"session.input_transcript.delta"
          SESSION_OUTPUT_TRANSCRIPT_DELTA = :"session.output_transcript.delta"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

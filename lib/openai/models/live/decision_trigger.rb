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
          # @!attribute questions
          #   Native Decision API questions evaluated together, in order.
          #
          #   @return [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Predicate, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Score>]
          required(
            :questions,
            -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionTrigger::Decisions::Question] }
          )

          # @!method initialize(questions:)
          #   Questions evaluated using the current transcript and the session's shared
          #   Decision items.
          #
          #   @param questions [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Predicate, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Score>]
          #     Native Decision API questions evaluated together, in order.

          # A question about the request's input, with an optional correlation name.
          module Question
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Estimate how likely it is that a statement about the input is true.
            variant :predicate, -> { OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate }

            # Choose from the supplied options based on the input.
            variant :choice, -> { OpenAI::Live::DecisionTrigger::Decisions::Question::Choice }

            # Rate the input against the supplied ordered levels.
            variant :score, -> { OpenAI::Live::DecisionTrigger::Decisions::Question::Score }

            class Predicate < OpenAI::Internal::Type::BaseModel
              # @!attribute instructions
              #
              #   @return [String]
              required :instructions, String

              # @!attribute type
              #   The type of the object. Always `predicate`.
              #
              #   @return [Symbol, :predicate]
              required :type, const: :predicate

              # @!attribute name
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(instructions:, name: nil, type: :predicate)
              #   Estimate how likely it is that a statement about the input is true.
              #
              #   @param instructions [String]
              #
              #   @param name [String]
              #
              #   @param type [Symbol, :predicate]
              #     The type of the object. Always `predicate`.
            end

            class Choice < OpenAI::Internal::Type::BaseModel
              # @!attribute choices
              #   Provide between 2 and 255 choices. Each choice must be unique.
              #
              #   @return [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice::Choice>]
              required(
                :choices,
                -> {
                  OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice]
                }
              )

              # @!attribute instructions
              #
              #   @return [String]
              required :instructions, String

              # @!attribute type
              #   The type of the object. Always `choice`.
              #
              #   @return [Symbol, :choice]
              required :type, const: :choice

              # @!attribute name
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(choices:, instructions:, name: nil, type: :choice)
              #   Choose from the supplied options based on the input.
              #
              #   @param choices [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice::Choice>]
              #     Provide between 2 and 255 choices. Each choice must be unique.
              #
              #   @param instructions [String]
              #
              #   @param name [String]
              #
              #   @param type [Symbol, :choice]
              #     The type of the object. Always `choice`.
              class Choice < OpenAI::Internal::Type::BaseModel
                # @!attribute value
                #   Choice values are typed: a string and a boolean with the same text are distinct.
                #
                #   @return [String, Boolean]
                required(
                  :value,
                  union: -> { OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice::Value }
                )

                # @!attribute description
                #
                #   @return [String, nil]
                optional :description, String

                # @!method initialize(value:, description: nil)
                #   @param value [String, Boolean]
                #     Choice values are typed: a string and a boolean with the same text are distinct.
                #
                #   @param description [String]

                # Choice values are typed: a string and a boolean with the same text are distinct.
                #
                # @see OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice::Choice#value
                module Value
                  extend OpenAI::Internal::Type::Union

                  variant String

                  variant OpenAI::Internal::Type::Boolean

                  # @!method self.variants
                  #   @return [Array(String, Boolean)]
                end
              end
            end

            class Score < OpenAI::Internal::Type::BaseModel
              # @!attribute instructions
              #
              #   @return [String]
              required :instructions, String

              # @!attribute levels
              #
              #   @return [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Score::Level>]
              required(
                :levels,
                -> {
                  OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Level]
                }
              )

              # @!attribute type
              #   The type of the object. Always `score`.
              #
              #   @return [Symbol, :score]
              required :type, const: :score

              # @!attribute name
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(instructions:, levels:, name: nil, type: :score)
              #   Rate the input against the supplied ordered levels.
              #
              #   @param instructions [String]
              #
              #   @param levels [Array<OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Score::Level>]
              #
              #   @param name [String]
              #
              #   @param type [Symbol, :score]
              #     The type of the object. Always `score`.
              class Level < OpenAI::Internal::Type::BaseModel
                # @!attribute label
                #
                #   @return [String]
                required :label, String

                # @!attribute description
                #
                #   @return [String, nil]
                optional :description, String

                # @!method initialize(label:, description: nil)
                #   @param label [String]
                #   @param description [String]
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Predicate, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Choice, OpenAI::Models::Live::DecisionTrigger::Decisions::Question::Score)]
          end
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

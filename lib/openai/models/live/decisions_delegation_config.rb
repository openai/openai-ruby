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
        #   @return [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Predicate, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score>]
        required(
          :questions,
          -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionsDelegationConfig::Question] }
        )

        # @!method initialize(model:, questions:)
        #   @param model [String]
        #
        #   @param questions [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Predicate, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score>]
        #     Native Decision API questions evaluated together, in order.

        # A question about the request's input, with an optional correlation name.
        module Question
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Estimate how likely it is that a statement about the input is true.
          variant :predicate, -> { OpenAI::Live::DecisionsDelegationConfig::Question::Predicate }

          # Choose from the supplied options based on the input.
          variant :choice, -> { OpenAI::Live::DecisionsDelegationConfig::Question::Choice }

          # Rate the input against the supplied ordered levels.
          variant :score, -> { OpenAI::Live::DecisionsDelegationConfig::Question::Score }

          class Predicate < OpenAI::Internal::Type::BaseModel
            # @!attribute instructions
            #
            #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
            required(
              :instructions,
              union: -> { OpenAI::Live::DecisionsDelegationConfig::Question::Predicate::Instructions }
            )

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
            #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
            #
            #   @param name [String]
            #
            #   @param type [Symbol, :predicate]
            #     The type of the object. Always `predicate`.

            # @see OpenAI::Models::Live::DecisionsDelegationConfig::Question::Predicate#instructions
            module Instructions
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::Live::DecisionsDelegationConfig::Question::Predicate::Instructions::DecisionQuestionInputPartArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
                union: -> { OpenAI::DecisionQuestionInputPart }
              ]
            end
          end

          class Choice < OpenAI::Internal::Type::BaseModel
            # @!attribute choices
            #   Provide between 2 and 255 choices. Each choice must be unique.
            #
            #   @return [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice::Choice>]
            required(
              :choices,
              -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice] }
            )

            # @!attribute instructions
            #
            #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
            required(
              :instructions,
              union: -> { OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Instructions }
            )

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
            #   @param choices [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice::Choice>]
            #     Provide between 2 and 255 choices. Each choice must be unique.
            #
            #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
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
              required :value, union: -> { OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice::Value }

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
              # @see OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice::Choice#value
              module Value
                extend OpenAI::Internal::Type::Union

                variant String

                variant OpenAI::Internal::Type::Boolean

                # @!method self.variants
                #   @return [Array(String, Boolean)]
              end
            end

            # @see OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice#instructions
            module Instructions
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice::Instructions::DecisionQuestionInputPartArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
                union: -> { OpenAI::DecisionQuestionInputPart }
              ]
            end
          end

          class Score < OpenAI::Internal::Type::BaseModel
            # @!attribute instructions
            #
            #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
            required(
              :instructions,
              union: -> { OpenAI::Live::DecisionsDelegationConfig::Question::Score::Instructions }
            )

            # @!attribute levels
            #
            #   @return [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score::Level>]
            required(
              :levels,
              -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionsDelegationConfig::Question::Score::Level] }
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
            #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
            #
            #   @param levels [Array<OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score::Level>]
            #
            #   @param name [String]
            #
            #   @param type [Symbol, :score]
            #     The type of the object. Always `score`.

            # @see OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score#instructions
            module Instructions
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score::Instructions::DecisionQuestionInputPartArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
                union: -> { OpenAI::DecisionQuestionInputPart }
              ]
            end

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
          #   @return [Array(OpenAI::Models::Live::DecisionsDelegationConfig::Question::Predicate, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Choice, OpenAI::Models::Live::DecisionsDelegationConfig::Question::Score)]
        end
      end
    end
  end
end

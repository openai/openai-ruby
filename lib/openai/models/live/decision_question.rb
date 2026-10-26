# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      module DecisionQuestion
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :choice, -> { OpenAI::Live::DecisionQuestion::Choice }

        variant :predicate, -> { OpenAI::Live::DecisionQuestion::Predicate }

        variant :score, -> { OpenAI::Live::DecisionQuestion::Score }

        class Choice < OpenAI::Internal::Type::BaseModel
          require_relative "decision_choice_option"
          Choice = ::OpenAI::Models::Live::DecisionChoiceOption

          # @!attribute choices
          #
          #   @return [Array<OpenAI::Models::Live::DecisionChoiceOption>]
          required :choices, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionChoiceOption] }

          # @!attribute instructions
          #
          #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          required :instructions, union: -> { OpenAI::Live::DecisionQuestion::Choice::Instructions }

          # @!attribute type
          #
          #   @return [Symbol, :choice]
          required :type, const: :choice

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(choices:, instructions:, name: nil, type: :choice)
          #   @param choices [Array<OpenAI::Models::Live::DecisionChoiceOption>]
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #   @param name [String]
          #   @param type [Symbol, :choice]

          # @see OpenAI::Models::Live::DecisionQuestion::Choice#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant -> { OpenAI::Models::Live::DecisionQuestion::Choice::Instructions::DecisionQuestionInputPartArray }

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

            # @type [OpenAI::Internal::Type::Converter]
            DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::DecisionQuestionInputPart }
            ]
          end
        end

        class Predicate < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #
          #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          required :instructions, union: -> { OpenAI::Live::DecisionQuestion::Predicate::Instructions }

          # @!attribute type
          #
          #   @return [Symbol, :predicate]
          required :type, const: :predicate

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, name: nil, type: :predicate)
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #   @param name [String]
          #   @param type [Symbol, :predicate]

          # @see OpenAI::Models::Live::DecisionQuestion::Predicate#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant(
              -> { OpenAI::Models::Live::DecisionQuestion::Predicate::Instructions::DecisionQuestionInputPartArray }
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
          required :instructions, union: -> { OpenAI::Live::DecisionQuestion::Score::Instructions }

          # @!attribute levels
          #
          #   @return [Array<OpenAI::Models::Live::DecisionQuestion::Score::Level>]
          required :levels, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::DecisionQuestion::Score::Level] }

          # @!attribute type
          #
          #   @return [Symbol, :score]
          required :type, const: :score

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, levels:, name: nil, type: :score)
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #   @param levels [Array<OpenAI::Models::Live::DecisionQuestion::Score::Level>]
          #   @param name [String]
          #   @param type [Symbol, :score]

          # @see OpenAI::Models::Live::DecisionQuestion::Score#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant -> { OpenAI::Models::Live::DecisionQuestion::Score::Instructions::DecisionQuestionInputPartArray }

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
        #   @return [Array(OpenAI::Models::Live::DecisionQuestion::Choice, OpenAI::Models::Live::DecisionQuestion::Predicate, OpenAI::Models::Live::DecisionQuestion::Score)]
      end
    end
  end
end

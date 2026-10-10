# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Decisions#create
    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   The text or images to evaluate for every question. Provide a text string or user
      #   messages containing text and inline images. Images must be inline data URLs; at
      #   most 128 images are allowed across all messages in one request. External URLs,
      #   files, audio, tools, and item references are not supported.
      #
      #   @return [String, Array<OpenAI::Models::DecisionInputMessage>]
      required :input, union: -> { OpenAI::DecisionCreateParams::Input }

      # @!attribute model
      #
      #   @return [String]
      required :model, String

      # @!attribute questions
      #
      #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      required :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionCreateParams::Question] }

      # @!attribute safety_identifier
      #   Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #   Responses' limit; this is never the authenticated user identity.
      #
      #   @return [String, nil]
      optional :safety_identifier, String, nil?: true

      # @!method initialize(input:, model:, questions:, safety_identifier: nil, request_options: {})
      #   @param input [String, Array<OpenAI::Models::DecisionInputMessage>]
      #     The text or images to evaluate for every question. Provide a text string or user
      #     messages containing text and inline images. Images must be inline data URLs; at
      #     most 128 images are allowed across all messages in one request. External URLs,
      #     files, audio, tools, and item references are not supported.
      #
      #   @param model [String]
      #
      #   @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      #
      #   @param safety_identifier [String, nil]
      #     Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #     Responses' limit; this is never the authenticated user identity.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The text or images to evaluate for every question. Provide a text string or user
      # messages containing text and inline images. Images must be inline data URLs; at
      # most 128 images are allowed across all messages in one request. External URLs,
      # files, audio, tools, and item references are not supported.
      module Input
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::DecisionCreateParams::Input::DecisionInputMessageArray }

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::DecisionInputMessage>)]

        # @type [OpenAI::Internal::Type::Converter]
        DecisionInputMessageArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputMessage }]
      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Estimate how likely it is that a statement about the input is true.
        variant :predicate, -> { OpenAI::DecisionCreateParams::Question::Predicate }

        # Choose from the supplied options based on the input.
        variant :choice, -> { OpenAI::DecisionCreateParams::Question::Choice }

        # Rate the input against the supplied ordered levels.
        variant :score, -> { OpenAI::DecisionCreateParams::Question::Score }

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
          #
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
          required(
            :choices,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Choice::Choice] }
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
          #   @param choices [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
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
            required :value, union: -> { OpenAI::DecisionCreateParams::Question::Choice::Choice::Value }

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
            # @see OpenAI::Models::DecisionCreateParams::Question::Choice::Choice#value
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
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
          required(
            :levels,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Score::Level] }
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
          #   @param levels [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
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
        #   @return [Array(OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score)]
      end
    end
  end
end

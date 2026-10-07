# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Decisions#create
    class Decision < OpenAI::Internal::Type::BaseModel
      # @!attribute answers
      #
      #   @return [Array<OpenAI::Models::Decision::Answer::Predicate, OpenAI::Models::Decision::Answer::Choice, OpenAI::Models::Decision::Answer::Score, OpenAI::Models::Decision::Answer::Refusal>]
      required :answers, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Decision::Answer] }

      # @!attribute model
      #
      #   @return [String]
      required :model, String

      # @!attribute usage
      #
      #   @return [OpenAI::Models::Decision::Usage]
      required :usage, -> { OpenAI::Decision::Usage }

      # @!method initialize(answers:, model:, usage:)
      #   @param answers [Array<OpenAI::Models::Decision::Answer::Predicate, OpenAI::Models::Decision::Answer::Choice, OpenAI::Models::Decision::Answer::Score, OpenAI::Models::Decision::Answer::Refusal>]
      #   @param model [String]
      #   @param usage [OpenAI::Models::Decision::Usage]

      # A completed question always includes its name, including null when unnamed.
      module Answer
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :predicate, -> { OpenAI::Decision::Answer::Predicate }

        variant :choice, -> { OpenAI::Decision::Answer::Choice }

        variant :score, -> { OpenAI::Decision::Answer::Score }

        # The host may decline one question without disclosing its refusal score.
        variant :refusal, -> { OpenAI::Decision::Answer::Refusal }

        class Predicate < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute probability
          #
          #   @return [Float]
          required :probability, Float

          # @!attribute type
          #   The type of the object. Always `predicate`.
          #
          #   @return [Symbol, :predicate]
          required :type, const: :predicate

          # @!method initialize(name:, probability:, type: :predicate)
          #   @param name [String, nil]
          #
          #   @param probability [Float]
          #
          #   @param type [Symbol, :predicate]
          #     The type of the object. Always `predicate`.
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute choice
          #   Choice values are typed: a string and a boolean with the same text are distinct.
          #
          #   @return [String, Boolean]
          required :choice, union: -> { OpenAI::Decision::Answer::Choice::Choice }

          # @!attribute confidence
          #
          #   @return [Float]
          required :confidence, Float

          # @!attribute name
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute probabilities
          #
          #   @return [Array<OpenAI::Models::Decision::Answer::Choice::Probability>]
          required(
            :probabilities,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Decision::Answer::Choice::Probability] }
          )

          # @!attribute type
          #   The type of the object. Always `choice`.
          #
          #   @return [Symbol, :choice]
          required :type, const: :choice

          # @!method initialize(choice:, confidence:, name:, probabilities:, type: :choice)
          #   @param choice [String, Boolean]
          #     Choice values are typed: a string and a boolean with the same text are distinct.
          #
          #   @param confidence [Float]
          #
          #   @param name [String, nil]
          #
          #   @param probabilities [Array<OpenAI::Models::Decision::Answer::Choice::Probability>]
          #
          #   @param type [Symbol, :choice]
          #     The type of the object. Always `choice`.

          # Choice values are typed: a string and a boolean with the same text are distinct.
          #
          # @see OpenAI::Models::Decision::Answer::Choice#choice
          module Choice
            extend OpenAI::Internal::Type::Union

            variant String

            variant OpenAI::Internal::Type::Boolean

            # @!method self.variants
            #   @return [Array(String, Boolean)]
          end

          class Probability < OpenAI::Internal::Type::BaseModel
            # @!attribute probability
            #
            #   @return [Float]
            required :probability, Float

            # @!attribute value
            #   Choice values are typed: a string and a boolean with the same text are distinct.
            #
            #   @return [String, Boolean]
            required :value, union: -> { OpenAI::Decision::Answer::Choice::Probability::Value }

            # @!method initialize(probability:, value:)
            #   @param probability [Float]
            #
            #   @param value [String, Boolean]
            #     Choice values are typed: a string and a boolean with the same text are distinct.

            # Choice values are typed: a string and a boolean with the same text are distinct.
            #
            # @see OpenAI::Models::Decision::Answer::Choice::Probability#value
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
          # @!attribute confidence
          #
          #   @return [Float]
          required :confidence, Float

          # @!attribute name
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute probabilities
          #
          #   @return [Array<OpenAI::Models::Decision::Answer::Score::Probability>]
          required(
            :probabilities,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Decision::Answer::Score::Probability] }
          )

          # @!attribute score
          #
          #   @return [Float]
          required :score, Float

          # @!attribute type
          #   The type of the object. Always `score`.
          #
          #   @return [Symbol, :score]
          required :type, const: :score

          # @!method initialize(confidence:, name:, probabilities:, score:, type: :score)
          #   @param confidence [Float]
          #
          #   @param name [String, nil]
          #
          #   @param probabilities [Array<OpenAI::Models::Decision::Answer::Score::Probability>]
          #
          #   @param score [Float]
          #
          #   @param type [Symbol, :score]
          #     The type of the object. Always `score`.
          class Probability < OpenAI::Internal::Type::BaseModel
            # @!attribute label
            #
            #   @return [String]
            required :label, String

            # @!attribute probability
            #
            #   @return [Float]
            required :probability, Float

            # @!attribute value
            #
            #   @return [Integer]
            required :value, Integer

            # @!method initialize(label:, probability:, value:)
            #   @param label [String]
            #   @param probability [Float]
            #   @param value [Integer]
          end
        end

        class Refusal < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #
          #   @return [String, nil]
          required :name, String, nil?: true

          # @!attribute type
          #   The type of the object. Always `refusal`.
          #
          #   @return [Symbol, :refusal]
          required :type, const: :refusal

          # @!method initialize(name:, type: :refusal)
          #   The host may decline one question without disclosing its refusal score.
          #
          #   @param name [String, nil]
          #
          #   @param type [Symbol, :refusal]
          #     The type of the object. Always `refusal`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Decision::Answer::Predicate, OpenAI::Models::Decision::Answer::Choice, OpenAI::Models::Decision::Answer::Score, OpenAI::Models::Decision::Answer::Refusal)]
      end

      # @see OpenAI::Models::Decision#usage
      class Usage < OpenAI::Internal::Type::BaseModel
        # @!attribute input_tokens
        #
        #   @return [Integer]
        required :input_tokens, Integer

        # @!attribute input_tokens_details
        #
        #   @return [OpenAI::Models::Decision::Usage::InputTokensDetails]
        required :input_tokens_details, -> { OpenAI::Decision::Usage::InputTokensDetails }

        # @!attribute output_tokens
        #
        #   @return [Integer]
        required :output_tokens, Integer

        # @!attribute output_tokens_details
        #
        #   @return [OpenAI::Models::Decision::Usage::OutputTokensDetails]
        required :output_tokens_details, -> { OpenAI::Decision::Usage::OutputTokensDetails }

        # @!attribute total_tokens
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!attribute compute_units
        #
        #   @return [Integer, nil]
        optional :compute_units, Integer, nil?: true

        # @!method initialize(input_tokens:, input_tokens_details:, output_tokens:, output_tokens_details:, total_tokens:, compute_units: nil)
        #   @param input_tokens [Integer]
        #   @param input_tokens_details [OpenAI::Models::Decision::Usage::InputTokensDetails]
        #   @param output_tokens [Integer]
        #   @param output_tokens_details [OpenAI::Models::Decision::Usage::OutputTokensDetails]
        #   @param total_tokens [Integer]
        #   @param compute_units [Integer, nil]

        # @see OpenAI::Models::Decision::Usage#input_tokens_details
        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute cache_write_tokens
          #
          #   @return [Integer]
          required :cache_write_tokens, Integer

          # @!attribute cached_tokens
          #
          #   @return [Integer]
          required :cached_tokens, Integer

          # @!method initialize(cache_write_tokens:, cached_tokens:)
          #   @param cache_write_tokens [Integer]
          #   @param cached_tokens [Integer]
        end

        # @see OpenAI::Models::Decision::Usage#output_tokens_details
        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute reasoning_tokens
          #
          #   @return [Integer]
          required :reasoning_tokens, Integer

          # @!method initialize(reasoning_tokens:)
          #   @param reasoning_tokens [Integer]
        end
      end
    end
  end
end

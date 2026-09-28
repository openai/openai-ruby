# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      class MultiGrader < OpenAI::Internal::Type::BaseModel
        # @!attribute calculate_output
        #   A formula to calculate the output based on grader results.
        #
        #   @return [String]
        required :calculate_output, String

        # @!attribute graders
        #   Use explicit keys matching calculate_output variables for API requests.
        #   The previous single-grader SDK shape remains supported.
        #
        #   @return [Hash{Symbol=>OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader}, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader]
        required :graders, union: -> { OpenAI::Graders::MultiGrader::GradersValue }

        # @!attribute name
        #   The name of the grader.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The object type, which is always `multi`.
        #
        #   @return [Symbol, :multi]
        required :type, const: :multi

        # @!method initialize(calculate_output:, graders:, name:, type: :multi)
        #   A MultiGrader object combines the output of multiple graders to produce a single
        #   score.
        #
        #   @param calculate_output [String]
        #     A formula to calculate the output based on grader results.
        #
        #   @param graders [Hash{Symbol=>OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader}, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader]
        #     Use keys matching calculate_output variables for API requests.
        #
        #   @param name [String]
        #     The name of the grader.
        #
        #   @param type [Symbol, :multi]
        #     The object type, which is always `multi`.

        # A StringCheckGrader object that performs a string comparison between input and
        # reference using a specified operation.
        #
        # @see OpenAI::Models::Graders::MultiGrader#graders
        module Graders
          extend OpenAI::Internal::Type::Union

          # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
          variant -> { OpenAI::Graders::StringCheckGrader }

          # A TextSimilarityGrader object which grades text based on similarity metrics.
          variant -> { OpenAI::Graders::TextSimilarityGrader }

          # A PythonGrader object that runs a python script on the input.
          variant -> { OpenAI::Graders::PythonGrader }

          # A ScoreModelGrader object that uses a model to assign a score to the input.
          variant -> { OpenAI::Graders::ScoreModelGrader }

          # A LabelModelGrader object which uses a model to assign labels to each item
          # in the evaluation.
          variant -> { OpenAI::Graders::LabelModelGrader }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::LabelModelGrader)]
        end

        # A value in the named grader map. Leave the legacy Graders union's matching
        # behavior unchanged for existing SDK consumers.
        module Grader
          extend OpenAI::Internal::Type::Union

          discriminator :type
          variant :string_check, -> { OpenAI::Graders::StringCheckGrader }
          variant :text_similarity, -> { OpenAI::Graders::TextSimilarityGrader }
          variant :python, -> { OpenAI::Graders::PythonGrader }
          variant :score_model, -> { OpenAI::Graders::ScoreModelGrader }
          variant :label_model, -> { OpenAI::Graders::LabelModelGrader }
        end

        module GradersValue
          extend OpenAI::Internal::Type::Union

          variant -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Graders::MultiGrader::Grader] }
          variant union: -> { OpenAI::Graders::MultiGrader::Graders }

          # @api private
          #
          # Named maps contain grader objects, even when a formula variable is "type".
          # Other values keep the original Graders union's matching rules.
          def self.coerce(value, state:)
            target = if value.is_a?(Hash) &&
                value.values.all? do |item|
                  item.is_a?(Hash) || OpenAI::Graders::MultiGrader::Graders === item
                end
              OpenAI::Internal::Type::HashOf[union: OpenAI::Graders::MultiGrader::Grader]
            else
              OpenAI::Graders::MultiGrader::Graders
            end

            OpenAI::Internal::Type::Converter.coerce(target, value, state: state)
          end
        end
      end
    end

    MultiGrader = Graders::MultiGrader
  end
end

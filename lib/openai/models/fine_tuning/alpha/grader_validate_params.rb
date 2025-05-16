# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Alpha
        # @see OpenAI::Resources::FineTuning::Alpha::Graders#validate
        class GraderValidateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute grader
          #   The grader used for the fine-tuning job.
          #
          #   @return [OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader]
          required :grader, union: -> { OpenAI::FineTuning::Alpha::GraderValidateParams::Grader }

          # @!method initialize(grader:, request_options: {})
          #   @param grader [OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader] The grader used for the fine-tuning job.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The grader used for the fine-tuning job.
          module Grader
            extend OpenAI::Internal::Type::Union

            # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
            variant -> { OpenAI::Graders::StringCheckGrader }

            # A TextSimilarityGrader object which grades text based on similarity metrics.
            variant -> { OpenAI::Graders::TextSimilarityGrader }

            # A PythonGrader object that runs a python script on the input.
            variant -> { OpenAI::Graders::PythonGrader }

            # A ScoreModelGrader object that uses a model to assign a score to the input.
            variant -> { OpenAI::Graders::ScoreModelGrader }

            # A MultiGrader object combines the output of multiple graders to produce a single score.
            variant -> { OpenAI::Graders::MultiGrader }

            # @!method self.variants
            #   @return [Array(OpenAI::Graders::StringCheckGrader, OpenAI::Graders::TextSimilarityGrader, OpenAI::Graders::PythonGrader, OpenAI::Graders::ScoreModelGrader, OpenAI::Graders::MultiGrader)]

            define_sorbet_constant!(:Variants) do
              T.type_alias do
                T.any(
                  OpenAI::Graders::StringCheckGrader,
                  OpenAI::Graders::TextSimilarityGrader,
                  OpenAI::Graders::PythonGrader,
                  OpenAI::Graders::ScoreModelGrader,
                  OpenAI::Graders::MultiGrader
                )
              end
            end
          end
        end
      end
    end
  end
end

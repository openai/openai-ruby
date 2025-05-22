# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Alpha
        # @see OpenAI::Resources::FineTuning::Alpha::Graders#run
        class GraderRunParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute grader
          #   The grader used for the fine-tuning job.
          #
          #   @return [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader]
          required :grader, union: -> { OpenAI::FineTuning::Alpha::GraderRunParams::Grader }

          # @!attribute model_sample
          #   The model sample to be evaluated.
          #
          #   @return [String]
          required :model_sample, String

          # @!attribute reference_answer
          #   The reference answer for the evaluation.
          #
          #   @return [String, Object, Array<Object>, Float]
          required :reference_answer,
                   union: -> {
                     OpenAI::FineTuning::Alpha::GraderRunParams::ReferenceAnswer
                   }

          # @!method initialize(grader:, model_sample:, reference_answer:, request_options: {})
          #   @param grader [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader] The grader used for the fine-tuning job.
          #
          #   @param model_sample [String] The model sample to be evaluated.
          #
          #   @param reference_answer [String, Object, Array<Object>, Float] The reference answer for the evaluation.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The grader used for the fine-tuning job.
          module Grader
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
            variant :string_check, -> { OpenAI::Graders::StringCheckGrader }

            # A TextSimilarityGrader object which grades text based on similarity metrics.
            variant :text_similarity, -> { OpenAI::Graders::TextSimilarityGrader }

            # A PythonGrader object that runs a python script on the input.
            variant :python, -> { OpenAI::Graders::PythonGrader }

            # A ScoreModelGrader object that uses a model to assign a score to the input.
            variant :score_model, -> { OpenAI::Graders::ScoreModelGrader }

            # A MultiGrader object combines the output of multiple graders to produce a single score.
            variant :multi, -> { OpenAI::Graders::MultiGrader }

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader)]
          end

          # The reference answer for the evaluation.
          module ReferenceAnswer
            extend OpenAI::Internal::Type::Union

            variant String

            variant OpenAI::Internal::Type::Unknown

            variant -> { OpenAI::Models::FineTuning::Alpha::GraderRunParams::ReferenceAnswer::UnionMember2Array }

            variant Float

            # @!method self.variants
            #   @return [Array(String, Object, Array<Object>, Float)]

            # @type [OpenAI::Internal::Type::Converter]
            UnionMember2Array = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]
          end
        end
      end
    end
  end
end

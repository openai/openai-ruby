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
          #   The model sample to be evaluated. This value will be used to populate the
          #   `sample` namespace. See
          #   [the guide](https://platform.openai.com/docs/guides/graders) for more details.
          #   The `output_json` variable will be populated if the model sample is a valid JSON
          #   string.
          #
          #   @return [String]
          required :model_sample, String

          # @!attribute item
          #   The dataset item provided to the grader. This will be used to populate the
          #   `item` namespace. See
          #   [the guide](https://platform.openai.com/docs/guides/graders) for more details.
          #
          #   @return [Object, nil]
          optional :item, OpenAI::Internal::Type::Unknown

          # @!method initialize(grader:, model_sample:, item: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::FineTuning::Alpha::GraderRunParams} for more details.
          #
          #   @param grader [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader] The grader used for the fine-tuning job.
          #
          #   @param model_sample [String] The model sample to be evaluated. This value will be used to populate
          #
          #   @param item [Object] The dataset item provided to the grader. This will be used to populate
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
        end
      end
    end
  end
end

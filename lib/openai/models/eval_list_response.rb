# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#list
    class EvalListResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   Unique identifier for the evaluation.
      #
      #   @return [String]
      required :id, String

      # @!attribute created_at
      #   The Unix timestamp (in seconds) for when the eval was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute data_source_config
      #   Configuration of data sources used in runs of the evaluation.
      #
      #   @return [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalListResponse::DataSourceConfig::Logs, OpenAI::Models::EvalStoredCompletionsDataSourceConfig]
      required :data_source_config, union: -> { OpenAI::Models::EvalListResponse::DataSourceConfig }

      # @!attribute metadata
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      #
      #   @return [Hash{Symbol=>String}, nil]
      required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

      # @!attribute name
      #   The name of the evaluation.
      #
      #   @return [String]
      required :name, String

      # @!attribute object
      #   The object type.
      #
      #   @return [Symbol, :eval]
      required :object, const: :eval

      # @!attribute testing_criteria
      #   A list of testing criteria.
      #
      #   @return [Array<OpenAI::Models::Graders::LabelModelGrader, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderScoreModel>]
      required(
        :testing_criteria,
        -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalListResponse::TestingCriterion] }
      )

      # @!method initialize(id:, created_at:, data_source_config:, metadata:, name:, testing_criteria:, object: :eval)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::EvalListResponse} for more details.
      #
      #   An Eval object with a data source config and testing criteria. An Eval
      #   represents a task to be done for your LLM integration. Like:
      #
      #   - Improve the quality of my chatbot
      #   - See how well my chatbot handles customer support
      #   - Check if o4-mini is better at my usecase than gpt-6-astra
      #
      #   @param id [String] Unique identifier for the evaluation.
      #
      #   @param created_at [Integer] The Unix timestamp (in seconds) for when the eval was created.
      #
      #   @param data_source_config [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalListResponse::DataSourceConfig::Logs, OpenAI::Models::EvalStoredCompletionsDataSourceConfig] Configuration of data sources used in runs of the evaluation.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param name [String] The name of the evaluation.
      #
      #   @param testing_criteria [Array<OpenAI::Models::Graders::LabelModelGrader, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderScoreModel>] A list of testing criteria.
      #
      #   @param object [Symbol, :eval] The object type.

      # Configuration of data sources used in runs of the evaluation.
      #
      # @see OpenAI::Models::EvalListResponse#data_source_config
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A CustomDataSourceConfig which specifies the schema of your `item` and optionally `sample` namespaces.
        # The response schema defines the shape of the data that will be:
        # - Used to define your testing criteria and
        # - What data is required when creating a run
        variant :custom, -> { OpenAI::EvalCustomDataSourceConfig }

        # A LogsDataSourceConfig which specifies the metadata property of your logs query.
        # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
        # The schema returned by this data source config is used to defined what variables are available in your evals.
        # `item` and `sample` are both defined when using this data source config.
        variant :logs, -> { OpenAI::Models::EvalListResponse::DataSourceConfig::Logs }

        # Deprecated in favor of LogsDataSourceConfig.
        variant :stored_completions, -> { OpenAI::EvalStoredCompletionsDataSourceConfig }

        class Logs < OpenAI::Internal::Type::BaseModel
          # @!attribute schema
          #   The json schema for the run data source items. Learn how to build JSON schemas
          #   [here](https://json-schema.org/).
          #
          #   @return [Hash{Symbol=>Object}]
          required :schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute type
          #   The type of data source. Always `logs`.
          #
          #   @return [Symbol, :logs]
          required :type, const: :logs

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!method initialize(schema:, metadata: nil, type: :logs)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::EvalListResponse::DataSourceConfig::Logs} for more details.
          #
          #   A LogsDataSourceConfig which specifies the metadata property of your logs query.
          #   This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc. The
          #   schema returned by this data source config is used to defined what variables are
          #   available in your evals. `item` and `sample` are both defined when using this
          #   data source config.
          #
          #   @param schema [Hash{Symbol=>Object}] The json schema for the run data source items.
          #
          #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param type [Symbol, :logs] The type of data source. Always `logs`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalListResponse::DataSourceConfig::Logs, OpenAI::Models::EvalStoredCompletionsDataSourceConfig)]
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        # A LabelModelGrader object which uses a model to assign labels to each item
        # in the evaluation.
        variant -> { OpenAI::Graders::LabelModelGrader }

        # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
        variant -> { OpenAI::Graders::StringCheckGrader }

        # A TextSimilarityGrader object which grades text based on similarity metrics.
        variant -> { OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderTextSimilarity }

        # A PythonGrader object that runs a python script on the input.
        variant -> { OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderPython }

        # A ScoreModelGrader object that uses a model to assign a score to the input.
        variant -> { OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderScoreModel }

        class EvalGraderTextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float]
          required :pass_threshold, Float

          # @!method initialize(evaluation_metric:, input:, name:, reference:, pass_threshold:, type: :text_similarity)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderTextSimilarity}
          #   for more details.
          #
          #   A TextSimilarityGrader object which grades text based on similarity metrics.
          #
          #   @param evaluation_metric [Symbol, OpenAI::Models::Graders::TextSimilarityGrader::EvaluationMetric] The evaluation metric to use. One of `cosine`, `fuzzy_match`, `bleu`,
          #
          #   @param input [String] The text being graded.
          #
          #   @param name [String] The name of the grader.
          #
          #   @param reference [String] The text being graded against.
          #
          #   @param pass_threshold [Float] The threshold for the score.
          #
          #   @param type [Symbol, :text_similarity] The type of grader.
        end

        class EvalGraderPython < OpenAI::Models::Graders::PythonGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!method initialize(name:, source:, image_tag: nil, pass_threshold: nil, type: :python)
          #   A PythonGrader object that runs a python script on the input.
          #
          #   @param name [String] The name of the grader.
          #
          #   @param source [String] The source code of the python script.
          #
          #   @param image_tag [String] The image tag to use for the python script.
          #
          #   @param pass_threshold [Float] The threshold for the score.
          #
          #   @param type [Symbol, :python] The object type, which is always `python`.
        end

        class EvalGraderScoreModel < OpenAI::Models::Graders::ScoreModelGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!method initialize(input:, model:, name:, range: nil, sampling_params: nil, pass_threshold: nil, type: :score_model)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderScoreModel} for
          #   more details.
          #
          #   A ScoreModelGrader object that uses a model to assign a score to the input.
          #
          #   @param input [Array<OpenAI::Models::Graders::ScoreModelGrader::Input>] The input messages evaluated by the grader. Supports text, output text, input im
          #
          #   @param model [String] The model to use for the evaluation.
          #
          #   @param name [String] The name of the grader.
          #
          #   @param range [Array<Float>] The range of the score. Defaults to `[0, 1]`.
          #
          #   @param sampling_params [OpenAI::Models::Graders::ScoreModelGrader::SamplingParams] The sampling parameters for the model.
          #
          #   @param pass_threshold [Float] The threshold for the score.
          #
          #   @param type [Symbol, :score_model] The object type, which is always `score_model`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Graders::LabelModelGrader, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalListResponse::TestingCriterion::EvalGraderScoreModel)]
      end
    end
  end
end

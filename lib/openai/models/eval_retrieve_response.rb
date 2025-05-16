# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#retrieve
    class EvalRetrieveResponse < OpenAI::Internal::Type::BaseModel
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
      #   @return [OpenAI::EvalCustomDataSourceConfig, OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs, OpenAI::EvalStoredCompletionsDataSourceConfig]
      required :data_source_config, union: -> { OpenAI::Models::EvalRetrieveResponse::DataSourceConfig }

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
      #   @return [Array<OpenAI::Graders::LabelModelGrader, OpenAI::Graders::StringCheckGrader, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel>]
      required :testing_criteria,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalRetrieveResponse::TestingCriterion] }

      # @!method initialize(id:, created_at:, data_source_config:, metadata:, name:, testing_criteria:, object: :eval)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::EvalRetrieveResponse} for more details.
      #
      #   An Eval object with a data source config and testing criteria. An Eval
      #   represents a task to be done for your LLM integration. Like:
      #
      #   - Improve the quality of my chatbot
      #   - See how well my chatbot handles customer support
      #   - Check if o4-mini is better at my usecase than gpt-4o
      #
      #   @param id [String] Unique identifier for the evaluation.
      #
      #   @param created_at [Integer] The Unix timestamp (in seconds) for when the eval was created.
      #
      #   @param data_source_config [OpenAI::EvalCustomDataSourceConfig, OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs, OpenAI::EvalStoredCompletionsDataSourceConfig] Configuration of data sources used in runs of the evaluation.
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param name [String] The name of the evaluation.
      #
      #   @param testing_criteria [Array<OpenAI::Graders::LabelModelGrader, OpenAI::Graders::StringCheckGrader, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel>] A list of testing criteria.
      #
      #   @param object [Symbol, :eval] The object type.

      # Configuration of data sources used in runs of the evaluation.
      #
      # @see OpenAI::Models::EvalRetrieveResponse#data_source_config
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
        variant :logs, -> { OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs }

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
          #   {OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs} for more details.
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
        #   @return [Array(OpenAI::EvalCustomDataSourceConfig, OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs, OpenAI::EvalStoredCompletionsDataSourceConfig)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(
              OpenAI::EvalCustomDataSourceConfig,
              OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Logs,
              OpenAI::EvalStoredCompletionsDataSourceConfig
            )
          end
        end
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
        variant -> { OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity }

        # A PythonGrader object that runs a python script on the input.
        variant -> { OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython }

        # A ScoreModelGrader object that uses a model to assign a score to the input.
        variant -> { OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel }

        class EvalGraderTextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float]
          required :pass_threshold, Float

          # @!method initialize(pass_threshold:)
          #   A TextSimilarityGrader object which grades text based on similarity metrics.
          #
          #   @param pass_threshold [Float] The threshold for the score.
        end

        class EvalGraderPython < OpenAI::Models::Graders::PythonGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!method initialize(pass_threshold: nil)
          #   A PythonGrader object that runs a python script on the input.
          #
          #   @param pass_threshold [Float] The threshold for the score.
        end

        class EvalGraderScoreModel < OpenAI::Models::Graders::ScoreModelGrader
          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!method initialize(pass_threshold: nil)
          #   A ScoreModelGrader object that uses a model to assign a score to the input.
          #
          #   @param pass_threshold [Float] The threshold for the score.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Graders::LabelModelGrader, OpenAI::Graders::StringCheckGrader, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython, OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(
              OpenAI::Graders::LabelModelGrader,
              OpenAI::Graders::StringCheckGrader,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel
            )
          end
        end
      end
    end
  end
end

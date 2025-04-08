# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#update
    class EvalUpdateResponse < OpenAI::Internal::Type::BaseModel
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
      #   @return [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig]
      required :data_source_config, union: -> { OpenAI::Models::EvalUpdateResponse::DataSourceConfig }

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

      # @!attribute share_with_openai
      #   Indicates whether the evaluation is shared with OpenAI.
      #
      #   @return [Boolean]
      required :share_with_openai, OpenAI::Internal::Type::Boolean

      # @!attribute testing_criteria
      #   A list of testing criteria.
      #
      #   @return [Array<OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader>]
      required :testing_criteria,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalUpdateResponse::TestingCriterion] }

      # @!parse
      #   # An Eval object with a data source config and testing criteria. An Eval
      #   # represents a task to be done for your LLM integration. Like:
      #   #
      #   # - Improve the quality of my chatbot
      #   # - See how well my chatbot handles customer support
      #   # - Check if o3-mini is better at my usecase than gpt-4o
      #   #
      #   # @param id [String]
      #   # @param created_at [Integer]
      #   # @param data_source_config [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param name [String]
      #   # @param share_with_openai [Boolean]
      #   # @param testing_criteria [Array<OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader>]
      #   # @param object [Symbol, :eval]
      #   #
      #   def initialize(
      #     id:,
      #     created_at:,
      #     data_source_config:,
      #     metadata:,
      #     name:,
      #     share_with_openai:,
      #     testing_criteria:,
      #     object: :eval,
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # Configuration of data sources used in runs of the evaluation.
      #
      # @see OpenAI::Models::EvalUpdateResponse#data_source_config
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A CustomDataSourceConfig which specifies the schema of your `item` and optionally `sample` namespaces.
        # The response schema defines the shape of the data that will be:
        # - Used to define your testing criteria and
        # - What data is required when creating a run
        variant :custom, -> { OpenAI::Models::EvalCustomDataSourceConfig }

        # A StoredCompletionsDataSourceConfig which specifies the metadata property of your stored completions query.
        # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
        # The schema returned by this data source config is used to defined what variables are available in your evals.
        # `item` and `sample` are both defined when using this data source config.
        variant :stored_completions, -> { OpenAI::Models::EvalStoredCompletionsDataSourceConfig }

        # @!parse
        #   # @return [Array(OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig)]
        #   def self.variants; end
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A LabelModelGrader object which uses a model to assign labels to each item
        # in the evaluation.
        variant :label_model, -> { OpenAI::Models::EvalLabelModelGrader }

        # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
        variant :string_check, -> { OpenAI::Models::EvalStringCheckGrader }

        # A TextSimilarityGrader object which grades text based on similarity metrics.
        variant :text_similarity, -> { OpenAI::Models::EvalTextSimilarityGrader }

        # @!parse
        #   # @return [Array(OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader)]
        #   def self.variants; end
      end
    end
  end
end

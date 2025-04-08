# typed: strong

module OpenAI
  module Models
    class EvalUpdateResponse < OpenAI::Internal::Type::BaseModel
      # Unique identifier for the evaluation.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the eval was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Configuration of data sources used in runs of the evaluation.
      sig do
        returns(
          T.any(OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig)
        )
      end
      attr_accessor :data_source_config

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the evaluation.
      sig { returns(String) }
      attr_accessor :name

      # The object type.
      sig { returns(Symbol) }
      attr_accessor :object

      # Indicates whether the evaluation is shared with OpenAI.
      sig { returns(T::Boolean) }
      attr_accessor :share_with_openai

      # A list of testing criteria.
      sig do
        returns(
          T::Array[
            T.any(
              OpenAI::Models::EvalLabelModelGrader,
              OpenAI::Models::EvalStringCheckGrader,
              OpenAI::Models::EvalTextSimilarityGrader
            )
          ]
        )
      end
      attr_accessor :testing_criteria

      # An Eval object with a data source config and testing criteria. An Eval
      # represents a task to be done for your LLM integration. Like:
      #
      # - Improve the quality of my chatbot
      # - See how well my chatbot handles customer support
      # - Check if o3-mini is better at my usecase than gpt-4o
      sig do
        params(
          id: String,
          created_at: Integer,
          data_source_config: T.any(
            OpenAI::Models::EvalCustomDataSourceConfig,
            OpenAI::Internal::AnyHash,
            OpenAI::Models::EvalStoredCompletionsDataSourceConfig
          ),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          share_with_openai: T::Boolean,
          testing_criteria: T::Array[
            T.any(
              OpenAI::Models::EvalLabelModelGrader,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::EvalStringCheckGrader,
              OpenAI::Models::EvalTextSimilarityGrader
            )
          ],
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        id:,
        created_at:,
        data_source_config:,
        metadata:,
        name:,
        share_with_openai:,
        testing_criteria:,
        object: :eval
      ); end
      sig do
        override
          .returns(
            {
              id: String,
              created_at: Integer,
              data_source_config: T.any(OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig),
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              object: Symbol,
              share_with_openai: T::Boolean,
              testing_criteria: T::Array[
                T.any(
                  OpenAI::Models::EvalLabelModelGrader,
                  OpenAI::Models::EvalStringCheckGrader,
                  OpenAI::Models::EvalTextSimilarityGrader
                )
              ]
            }
          )
      end
      def to_hash; end

      # Configuration of data sources used in runs of the evaluation.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig]
            )
        end
        def self.variants; end
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader]
            )
        end
        def self.variants; end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models

    class EvalCreateResponse < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::Models::EvalCreateResponse,
          OpenAI::Internal::AnyHash
        )
      end

      # Unique identifier for the evaluation.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the eval was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Configuration of data sources used in runs of the evaluation.
      sig { returns(OpenAI::Models::EvalCreateResponse::DataSourceConfig::Variants) }
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

      # A list of testing criteria.
      sig { returns(T::Array[OpenAI::Models::EvalCreateResponse::TestingCriterion::Variants]) }
      attr_accessor :testing_criteria

      # An Eval object with a data source config and testing criteria. An Eval
      # represents a task to be done for your LLM integration. Like:
      #
      # - Improve the quality of my chatbot
      # - See how well my chatbot handles customer support
      # - Check if o4-mini is better at my usecase than gpt-6-astra
      sig do
        params(

          id: String,

          created_at: Integer,

          data_source_config: T.any(
            OpenAI::EvalCustomDataSourceConfig::OrHash,
            OpenAI::Models::EvalCreateResponse::DataSourceConfig::Logs::OrHash,
            OpenAI::EvalStoredCompletionsDataSourceConfig::OrHash
          ),

          metadata: T.nilable(T::Hash[Symbol, String]),

          name: String,

          testing_criteria: T::Array[
            T.any(
              OpenAI::Graders::LabelModelGrader::OrHash,
              OpenAI::Graders::StringCheckGrader::OrHash,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderTextSimilarity::OrHash,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderPython::OrHash,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderScoreModel::OrHash
            )
          ],

          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Unique identifier for the evaluation.
        id:,

        # The Unix timestamp (in seconds) for when the eval was created.
        created_at:,

        # Configuration of data sources used in runs of the evaluation.
        data_source_config:,

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata:,

        # The name of the evaluation.
        name:,

        # A list of testing criteria.
        testing_criteria:,

        # The object type.

        object: :eval
      )
      end

      sig do
        override.returns(
          {
            id: String,
            created_at: Integer,
            data_source_config: OpenAI::Models::EvalCreateResponse::DataSourceConfig::Variants,
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            object: Symbol,
            testing_criteria: T::Array[OpenAI::Models::EvalCreateResponse::TestingCriterion::Variants]
          }
        )
      end
      def to_hash
      end

      # Configuration of data sources used in runs of the evaluation.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::EvalCustomDataSourceConfig,
            OpenAI::Models::EvalCreateResponse::DataSourceConfig::Logs,
            OpenAI::EvalStoredCompletionsDataSourceConfig
          )
        }

        class Logs < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::EvalCreateResponse::DataSourceConfig::Logs,
              OpenAI::Internal::AnyHash
            )
          end

          # The json schema for the run data source items. Learn how to build JSON schemas
          # [here](https://json-schema.org/).
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :schema

          # The type of data source. Always `logs`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # A LogsDataSourceConfig which specifies the metadata property of your logs query.
          # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc. The
          # schema returned by this data source config is used to defined what variables are
          # available in your evals. `item` and `sample` are both defined when using this
          # data source config.
          sig do
            params(

              schema: T::Hash[Symbol, T.anything],

              metadata: T.nilable(T::Hash[Symbol, String]),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The json schema for the run data source items. Learn how to build JSON schemas
            # [here](https://json-schema.org/).
            schema:,

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,

            # The type of data source. Always `logs`.

            type: :logs
          )
          end

          sig do
            override.returns(
              {schema: T::Hash[Symbol, T.anything], type: Symbol, metadata: T.nilable(T::Hash[Symbol, String])}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Models::EvalCreateResponse::DataSourceConfig::Variants]) }
        def self.variants
        end

      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::Graders::LabelModelGrader,
            OpenAI::Graders::StringCheckGrader,
            OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderTextSimilarity,
            OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderPython,
            OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderScoreModel
          )
        }

        class EvalGraderTextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderTextSimilarity,
              OpenAI::Internal::AnyHash
            )
          end

          # The threshold for the score.
          sig { returns(Float) }
          attr_accessor :pass_threshold

          # A TextSimilarityGrader object which grades text based on similarity metrics.
          sig do
            params(

              evaluation_metric: OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::OrSymbol,

              input: String,

              name: String,

              reference: String,

              pass_threshold: Float,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The evaluation metric to use. One of `cosine`, `fuzzy_match`, `bleu`, `gleu`,
            # `meteor`, `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
            evaluation_metric:,

            # The text being graded.
            input:,

            # The name of the grader.
            name:,

            # The text being graded against.
            reference:,

            # The threshold for the score.
            pass_threshold:,

            # The type of grader.

            type: :text_similarity
          )
          end

          sig do
            override.returns(
              {
                evaluation_metric: OpenAI::Graders::TextSimilarityGrader::EvaluationMetric::OrSymbol,
                input: String,
                name: String,
                reference: String,
                pass_threshold: Float,
                type: Symbol
              }
            )
          end
          def to_hash
          end

        end

        class EvalGraderPython < OpenAI::Models::Graders::PythonGrader
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderPython,
              OpenAI::Internal::AnyHash
            )
          end

          # The threshold for the score.
          sig { returns(T.nilable(Float)) }
          attr_reader :pass_threshold

          sig { params(pass_threshold: Float).void }
          attr_writer :pass_threshold

          # A PythonGrader object that runs a python script on the input.
          sig do
            params(

              name: String,

              source: String,

              image_tag: String,

              pass_threshold: Float,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The name of the grader.
            name:,

            # The source code of the python script.
            source:,

            # The image tag to use for the python script.
            image_tag: nil,

            # The threshold for the score.
            pass_threshold: nil,

            # The object type, which is always `python`.

            type: :python
          )
          end

          sig do
            override.returns(
              {name: String, source: String, type: Symbol, image_tag: String, pass_threshold: Float}
            )
          end
          def to_hash
          end

        end

        class EvalGraderScoreModel < OpenAI::Models::Graders::ScoreModelGrader
          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::EvalCreateResponse::TestingCriterion::EvalGraderScoreModel,
              OpenAI::Internal::AnyHash
            )
          end

          # The threshold for the score.
          sig { returns(T.nilable(Float)) }
          attr_reader :pass_threshold

          sig { params(pass_threshold: Float).void }
          attr_writer :pass_threshold

          # A ScoreModelGrader object that uses a model to assign a score to the input.
          sig do
            params(

              input: T::Array[OpenAI::Graders::ScoreModelGrader::Input::OrHash],

              model: String,

              name: String,

              range: T::Array[Float],

              sampling_params: OpenAI::Graders::ScoreModelGrader::SamplingParams::OrHash,

              pass_threshold: Float,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The input messages evaluated by the grader. Supports text, output text, input
            # image, and input audio content blocks, and may include template strings.
            input:,

            # The model to use for the evaluation.
            model:,

            # The name of the grader.
            name:,

            # The range of the score. Defaults to `[0, 1]`.
            range: nil,

            # The sampling parameters for the model.
            sampling_params: nil,

            # The threshold for the score.
            pass_threshold: nil,

            # The object type, which is always `score_model`.

            type: :score_model
          )
          end

          sig do
            override.returns(
              {
                input: T::Array[OpenAI::Graders::ScoreModelGrader::Input],
                model: String,
                name: String,
                type: Symbol,
                range: T::Array[Float],
                sampling_params: OpenAI::Graders::ScoreModelGrader::SamplingParams,
                pass_threshold: Float
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Models::EvalCreateResponse::TestingCriterion::Variants]) }
        def self.variants
        end

      end

    end

  end
end

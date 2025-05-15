# typed: strong

module OpenAI
  module Models
    class EvalRetrieveResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::Models::EvalRetrieveResponse, OpenAI::Internal::AnyHash)
        end

      # Unique identifier for the evaluation.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the eval was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Configuration of data sources used in runs of the evaluation.
      sig do
        returns(
          T.any(
            OpenAI::EvalCustomDataSourceConfig,
            OpenAI::EvalLogsDataSourceConfig,
            OpenAI::EvalStoredCompletionsDataSourceConfig
          )
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

      # A list of testing criteria.
      sig do
        returns(
          T::Array[
            T.any(
              OpenAI::Graders::LabelModelGrader,
              OpenAI::Graders::StringCheckGrader,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel
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
          data_source_config:
            T.any(
              OpenAI::EvalCustomDataSourceConfig::OrHash,
              OpenAI::EvalLogsDataSourceConfig::OrHash,
              OpenAI::EvalStoredCompletionsDataSourceConfig::OrHash
            ),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          testing_criteria:
            T::Array[
              T.any(
                OpenAI::Graders::LabelModelGrader::OrHash,
                OpenAI::Graders::StringCheckGrader::OrHash,
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity::OrHash,
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython::OrHash,
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel::OrHash
              )
            ],
          object: Symbol
        ).returns(T.attached_class)
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
            data_source_config:
              T.any(
                OpenAI::EvalCustomDataSourceConfig,
                OpenAI::EvalLogsDataSourceConfig,
                OpenAI::EvalStoredCompletionsDataSourceConfig
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            object: Symbol,
            testing_criteria:
              T::Array[
                T.any(
                  OpenAI::Graders::LabelModelGrader,
                  OpenAI::Graders::StringCheckGrader,
                  OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity,
                  OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython,
                  OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel
                )
              ]
          }
        )
      end
      def to_hash
      end

      # Configuration of data sources used in runs of the evaluation.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::EvalCustomDataSourceConfig,
              OpenAI::EvalLogsDataSourceConfig,
              OpenAI::EvalStoredCompletionsDataSourceConfig
            )
          end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::EvalRetrieveResponse::DataSourceConfig::Variants
            ]
          )
        end
        def self.variants
        end
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Graders::LabelModelGrader,
              OpenAI::Graders::StringCheckGrader,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython,
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel
            )
          end

        class EvalGraderTextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderTextSimilarity,
                OpenAI::Internal::AnyHash
              )
            end

          # The threshold for the score.
          sig { returns(Float) }
          attr_accessor :pass_threshold

          # A TextSimilarityGrader object which grades text based on similarity metrics.
          sig { params(pass_threshold: Float).returns(T.attached_class) }
          def self.new(
            # The threshold for the score.
            pass_threshold:
          )
          end

          sig { override.returns({ pass_threshold: Float }) }
          def to_hash
          end
        end

        class EvalGraderPython < OpenAI::Models::Graders::PythonGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderPython,
                OpenAI::Internal::AnyHash
              )
            end

          # The threshold for the score.
          sig { returns(T.nilable(Float)) }
          attr_reader :pass_threshold

          sig { params(pass_threshold: Float).void }
          attr_writer :pass_threshold

          # A PythonGrader object that runs a python script on the input.
          sig { params(pass_threshold: Float).returns(T.attached_class) }
          def self.new(
            # The threshold for the score.
            pass_threshold: nil
          )
          end

          sig { override.returns({ pass_threshold: Float }) }
          def to_hash
          end
        end

        class EvalGraderScoreModel < OpenAI::Models::Graders::ScoreModelGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalRetrieveResponse::TestingCriterion::EvalGraderScoreModel,
                OpenAI::Internal::AnyHash
              )
            end

          # The threshold for the score.
          sig { returns(T.nilable(Float)) }
          attr_reader :pass_threshold

          sig { params(pass_threshold: Float).void }
          attr_writer :pass_threshold

          # A ScoreModelGrader object that uses a model to assign a score to the input.
          sig { params(pass_threshold: Float).returns(T.attached_class) }
          def self.new(
            # The threshold for the score.
            pass_threshold: nil
          )
          end

          sig { override.returns({ pass_threshold: Float }) }
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::EvalRetrieveResponse::TestingCriterion::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end

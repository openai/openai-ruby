# typed: strong

module OpenAI
  module Models
    class EvalUpdateResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::Models::EvalUpdateResponse, OpenAI::Internal::AnyHash)
        end

      # Unique identifier for the evaluation.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) for when the eval was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Configuration of data sources used in runs of the evaluation.
      sig do
        returns(OpenAI::Models::EvalUpdateResponse::DataSourceConfig::Variants)
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
            OpenAI::Models::EvalUpdateResponse::TestingCriterion::Variants
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
              OpenAI::EvalStoredCompletionsDataSourceConfig::OrHash
            ),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          testing_criteria:
            T::Array[
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::OrHash,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::OrHash,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::OrHash,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::Python::OrHash,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::OrHash
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
              OpenAI::Models::EvalUpdateResponse::DataSourceConfig::Variants,
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            object: Symbol,
            testing_criteria:
              T::Array[
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::Variants
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
              OpenAI::EvalStoredCompletionsDataSourceConfig
            )
          end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::EvalUpdateResponse::DataSourceConfig::Variants
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
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel,
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck,
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity,
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::Python,
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel
            )
          end

        class LabelModel < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T::Array[
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input
              ]
            )
          end
          attr_accessor :input

          # The labels to assign to each item in the evaluation.
          sig { returns(T::Array[String]) }
          attr_accessor :labels

          # The model to use for the evaluation. Must support structured outputs.
          sig { returns(String) }
          attr_accessor :model

          # The name of the grader.
          sig { returns(String) }
          attr_accessor :name

          # The labels that indicate a passing result. Must be a subset of labels.
          sig { returns(T::Array[String]) }
          attr_accessor :passing_labels

          # The object type, which is always `label_model`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A LabelModelGrader object which uses a model to assign labels to each item in
          # the evaluation.
          sig do
            params(
              input:
                T::Array[
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::OrHash
                ],
              labels: T::Array[String],
              model: String,
              name: String,
              passing_labels: T::Array[String],
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            input:,
            # The labels to assign to each item in the evaluation.
            labels:,
            # The model to use for the evaluation. Must support structured outputs.
            model:,
            # The name of the grader.
            name:,
            # The labels that indicate a passing result. Must be a subset of labels.
            passing_labels:,
            # The object type, which is always `label_model`.
            type: :label_model
          )
          end

          sig do
            override.returns(
              {
                input:
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input
                  ],
                labels: T::Array[String],
                model: String,
                name: String,
                passing_labels: T::Array[String],
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Input < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input,
                  OpenAI::Internal::AnyHash
                )
              end

            # Text inputs to the model - can contain template strings.
            sig do
              returns(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::Variants
              )
            end
            attr_accessor :content

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            sig do
              returns(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            # The type of the message input. Always `message`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::TaggedSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::OrSymbol
              ).void
            end
            attr_writer :type

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            sig do
              params(
                content:
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText::OrHash,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::OutputText::OrHash
                  ),
                role:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::OrSymbol,
                type:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Text inputs to the model - can contain template strings.
              content:,
              # The role of the message input. One of `user`, `assistant`, `system`, or
              # `developer`.
              role:,
              # The type of the message input. Always `message`.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  content:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::Variants,
                  role:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol,
                  type:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # Text inputs to the model - can contain template strings.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::OutputText
                  )
                end

              class OutputText < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::OutputText,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The text output from the model.
                sig { returns(String) }
                attr_accessor :text

                # The type of the output text. Always `output_text`.
                sig { returns(Symbol) }
                attr_accessor :type

                # A text output from the model.
                sig do
                  params(text: String, type: Symbol).returns(T.attached_class)
                end
                def self.new(
                  # The text output from the model.
                  text:,
                  # The type of the output text. Always `output_text`.
                  type: :output_text
                )
                end

                sig { override.returns({ text: String, type: Symbol }) }
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Content::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USER =
                T.let(
                  :user,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
                )
              ASSISTANT =
                T.let(
                  :assistant,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
                )
              SYSTEM =
                T.let(
                  :system,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
                )
              DEVELOPER =
                T.let(
                  :developer,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Role::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # The type of the message input. Always `message`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE =
                T.let(
                  :message,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::LabelModel::Input::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end

        class StringCheck < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck,
                OpenAI::Internal::AnyHash
              )
            end

          # The input text. This may include template strings.
          sig { returns(String) }
          attr_accessor :input

          # The name of the grader.
          sig { returns(String) }
          attr_accessor :name

          # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
          sig do
            returns(
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
            )
          end
          attr_accessor :operation

          # The reference text. This may include template strings.
          sig { returns(String) }
          attr_accessor :reference

          # The object type, which is always `string_check`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A StringCheckGrader object that performs a string comparison between input and
          # reference using a specified operation.
          sig do
            params(
              input: String,
              name: String,
              operation:
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::OrSymbol,
              reference: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The input text. This may include template strings.
            input:,
            # The name of the grader.
            name:,
            # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
            operation:,
            # The reference text. This may include template strings.
            reference:,
            # The object type, which is always `string_check`.
            type: :string_check
          )
          end

          sig do
            override.returns(
              {
                input: String,
                name: String,
                operation:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol,
                reference: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
          module Operation
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            EQ =
              T.let(
                :eq,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
              )
            NE =
              T.let(
                :ne,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
              )
            LIKE =
              T.let(
                :like,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
              )
            ILIKE =
              T.let(
                :ilike,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::StringCheck::Operation::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class TextSimilarity < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity,
                OpenAI::Internal::AnyHash
              )
            end

          # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
          # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
          sig do
            returns(
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
            )
          end
          attr_accessor :evaluation_metric

          # The text being graded.
          sig { returns(String) }
          attr_accessor :input

          # A float score where a value greater than or equal indicates a passing grade.
          sig { returns(Float) }
          attr_accessor :pass_threshold

          # The text being graded against.
          sig { returns(String) }
          attr_accessor :reference

          # The type of grader.
          sig { returns(Symbol) }
          attr_accessor :type

          # The name of the grader.
          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # A TextSimilarityGrader object which grades text based on similarity metrics.
          sig do
            params(
              evaluation_metric:
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::OrSymbol,
              input: String,
              pass_threshold: Float,
              reference: String,
              name: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
            # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
            evaluation_metric:,
            # The text being graded.
            input:,
            # A float score where a value greater than or equal indicates a passing grade.
            pass_threshold:,
            # The text being graded against.
            reference:,
            # The name of the grader.
            name: nil,
            # The type of grader.
            type: :text_similarity
          )
          end

          sig do
            override.returns(
              {
                evaluation_metric:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol,
                input: String,
                pass_threshold: Float,
                reference: String,
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          # The evaluation metric to use. One of `fuzzy_match`, `bleu`, `gleu`, `meteor`,
          # `rouge_1`, `rouge_2`, `rouge_3`, `rouge_4`, `rouge_5`, or `rouge_l`.
          module EvaluationMetric
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FUZZY_MATCH =
              T.let(
                :fuzzy_match,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            BLEU =
              T.let(
                :bleu,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            GLEU =
              T.let(
                :gleu,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            METEOR =
              T.let(
                :meteor,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_1 =
              T.let(
                :rouge_1,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_2 =
              T.let(
                :rouge_2,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_3 =
              T.let(
                :rouge_3,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_4 =
              T.let(
                :rouge_4,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_5 =
              T.let(
                :rouge_5,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )
            ROUGE_L =
              T.let(
                :rouge_l,
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::TextSimilarity::EvaluationMetric::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class Python < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::Python,
                OpenAI::Internal::AnyHash
              )
            end

          # The name of the grader.
          sig { returns(String) }
          attr_accessor :name

          # The source code of the python script.
          sig { returns(String) }
          attr_accessor :source

          # The object type, which is always `python`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The image tag to use for the python script.
          sig { returns(T.nilable(String)) }
          attr_reader :image_tag

          sig { params(image_tag: String).void }
          attr_writer :image_tag

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
            ).returns(T.attached_class)
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
              {
                name: String,
                source: String,
                type: Symbol,
                image_tag: String,
                pass_threshold: Float
              }
            )
          end
          def to_hash
          end
        end

        class ScoreModel < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel,
                OpenAI::Internal::AnyHash
              )
            end

          # The input text. This may include template strings.
          sig do
            returns(
              T::Array[
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input
              ]
            )
          end
          attr_accessor :input

          # The model to use for the evaluation.
          sig { returns(String) }
          attr_accessor :model

          # The name of the grader.
          sig { returns(String) }
          attr_accessor :name

          # The object type, which is always `score_model`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The threshold for the score.
          sig { returns(T.nilable(Float)) }
          attr_reader :pass_threshold

          sig { params(pass_threshold: Float).void }
          attr_writer :pass_threshold

          # The range of the score. Defaults to `[0, 1]`.
          sig { returns(T.nilable(T::Array[Float])) }
          attr_reader :range

          sig { params(range: T::Array[Float]).void }
          attr_writer :range

          # The sampling parameters for the model.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :sampling_params

          sig { params(sampling_params: T.anything).void }
          attr_writer :sampling_params

          # A ScoreModelGrader object that uses a model to assign a score to the input.
          sig do
            params(
              input:
                T::Array[
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::OrHash
                ],
              model: String,
              name: String,
              pass_threshold: Float,
              range: T::Array[Float],
              sampling_params: T.anything,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The input text. This may include template strings.
            input:,
            # The model to use for the evaluation.
            model:,
            # The name of the grader.
            name:,
            # The threshold for the score.
            pass_threshold: nil,
            # The range of the score. Defaults to `[0, 1]`.
            range: nil,
            # The sampling parameters for the model.
            sampling_params: nil,
            # The object type, which is always `score_model`.
            type: :score_model
          )
          end

          sig do
            override.returns(
              {
                input:
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input
                  ],
                model: String,
                name: String,
                type: Symbol,
                pass_threshold: Float,
                range: T::Array[Float],
                sampling_params: T.anything
              }
            )
          end
          def to_hash
          end

          class Input < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input,
                  OpenAI::Internal::AnyHash
                )
              end

            # Text inputs to the model - can contain template strings.
            sig do
              returns(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::Variants
              )
            end
            attr_accessor :content

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            sig do
              returns(
                OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            # The type of the message input. Always `message`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::OrSymbol
              ).void
            end
            attr_writer :type

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            sig do
              params(
                content:
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText::OrHash,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText::OrHash
                  ),
                role:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::OrSymbol,
                type:
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Text inputs to the model - can contain template strings.
              content:,
              # The role of the message input. One of `user`, `assistant`, `system`, or
              # `developer`.
              role:,
              # The type of the message input. Always `message`.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  content:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::Variants,
                  role:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol,
                  type:
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # Text inputs to the model - can contain template strings.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText
                  )
                end

              class OutputText < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The text output from the model.
                sig { returns(String) }
                attr_accessor :text

                # The type of the output text. Always `output_text`.
                sig { returns(Symbol) }
                attr_accessor :type

                # A text output from the model.
                sig do
                  params(text: String, type: Symbol).returns(T.attached_class)
                end
                def self.new(
                  # The text output from the model.
                  text:,
                  # The type of the output text. Always `output_text`.
                  type: :output_text
                )
                end

                sig { override.returns({ text: String, type: Symbol }) }
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Content::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USER =
                T.let(
                  :user,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              ASSISTANT =
                T.let(
                  :assistant,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              SYSTEM =
                T.let(
                  :system,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              DEVELOPER =
                T.let(
                  :developer,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # The type of the message input. Always `message`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE =
                T.let(
                  :message,
                  OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalUpdateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::EvalUpdateResponse::TestingCriterion::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end

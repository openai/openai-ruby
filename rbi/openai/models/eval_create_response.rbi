# typed: strong

module OpenAI
  module Models
    class EvalCreateResponse < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
              OpenAI::EvalLabelModelGrader,
              OpenAI::EvalStringCheckGrader,
              OpenAI::EvalTextSimilarityGrader,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::Python,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel
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
              OpenAI::EvalStoredCompletionsDataSourceConfig::OrHash
            ),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          testing_criteria:
            T::Array[
              T.any(
                OpenAI::EvalLabelModelGrader::OrHash,
                OpenAI::EvalStringCheckGrader::OrHash,
                OpenAI::EvalTextSimilarityGrader::OrHash,
                OpenAI::Models::EvalCreateResponse::TestingCriterion::Python::OrHash,
                OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::OrHash
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
                OpenAI::EvalStoredCompletionsDataSourceConfig
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            object: Symbol,
            testing_criteria:
              T::Array[
                T.any(
                  OpenAI::EvalLabelModelGrader,
                  OpenAI::EvalStringCheckGrader,
                  OpenAI::EvalTextSimilarityGrader,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::Python,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel
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
              OpenAI::EvalStoredCompletionsDataSourceConfig
            )
          end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::EvalCreateResponse::DataSourceConfig::Variants
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
              OpenAI::EvalLabelModelGrader,
              OpenAI::EvalStringCheckGrader,
              OpenAI::EvalTextSimilarityGrader,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::Python,
              OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel
            )
          end

        class Python < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The input text. This may include template strings.
          sig do
            returns(
              T::Array[
                OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input
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
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::OrHash
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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input
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
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # Text inputs to the model - can contain template strings.
            sig do
              returns(
                T.any(
                  String,
                  OpenAI::Responses::ResponseInputText,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText
                )
              )
            end
            attr_accessor :content

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            sig do
              returns(
                OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            # The type of the message input. Always `message`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::OrSymbol
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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText::OrHash
                  ),
                role:
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::OrSymbol,
                type:
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::OrSymbol
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
                    T.any(
                      String,
                      OpenAI::Responses::ResponseInputText,
                      OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText
                    ),
                  role:
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol,
                  type:
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText
                  )
                end

              class OutputText < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::Variants
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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USER =
                T.let(
                  :user,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              ASSISTANT =
                T.let(
                  :assistant,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              SYSTEM =
                T.let(
                  :system,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )
              DEVELOPER =
                T.let(
                  :developer,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role::TaggedSymbol
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
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE =
                T.let(
                  :message,
                  OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type::TaggedSymbol
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
              OpenAI::Models::EvalCreateResponse::TestingCriterion::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end

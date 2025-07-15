# typed: strong

module OpenAI
  module Models
    class EvalCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::EvalCreateParams, OpenAI::Internal::AnyHash)
        end

      # The configuration for the data source used for the evaluation runs. Dictates the
      # schema of the data used in the evaluation.
      sig do
        returns(
          T.any(
            OpenAI::EvalCreateParams::DataSourceConfig::Custom,
            OpenAI::EvalCreateParams::DataSourceConfig::Logs,
            OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions
          )
        )
      end
      attr_accessor :data_source_config

      # A list of graders for all eval runs in this group. Graders can reference
      # variables in the data source using double curly braces notation, like
      # `{{item.variable_name}}`. To reference the model's output, use the `sample`
      # namespace (ie, `{{sample.output_text}}`).
      sig do
        returns(
          T::Array[
            T.any(
              OpenAI::EvalCreateParams::TestingCriterion::LabelModel,
              OpenAI::Graders::StringCheckGrader,
              OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity,
              OpenAI::EvalCreateParams::TestingCriterion::Python,
              OpenAI::EvalCreateParams::TestingCriterion::ScoreModel
            )
          ]
        )
      end
      attr_accessor :testing_criteria

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the evaluation.
      sig { returns(T.nilable(String)) }
      attr_reader :name

      sig { params(name: String).void }
      attr_writer :name

      sig do
        params(
          data_source_config:
            T.any(
              OpenAI::EvalCreateParams::DataSourceConfig::Custom::OrHash,
              OpenAI::EvalCreateParams::DataSourceConfig::Logs::OrHash,
              OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions::OrHash
            ),
          testing_criteria:
            T::Array[
              T.any(
                OpenAI::EvalCreateParams::TestingCriterion::LabelModel::OrHash,
                OpenAI::Graders::StringCheckGrader::OrHash,
                OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity::OrHash,
                OpenAI::EvalCreateParams::TestingCriterion::Python::OrHash,
                OpenAI::EvalCreateParams::TestingCriterion::ScoreModel::OrHash
              )
            ],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The configuration for the data source used for the evaluation runs. Dictates the
        # schema of the data used in the evaluation.
        data_source_config:,
        # A list of graders for all eval runs in this group. Graders can reference
        # variables in the data source using double curly braces notation, like
        # `{{item.variable_name}}`. To reference the model's output, use the `sample`
        # namespace (ie, `{{sample.output_text}}`).
        testing_criteria:,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # The name of the evaluation.
        name: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            data_source_config:
              T.any(
                OpenAI::EvalCreateParams::DataSourceConfig::Custom,
                OpenAI::EvalCreateParams::DataSourceConfig::Logs,
                OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions
              ),
            testing_criteria:
              T::Array[
                T.any(
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel,
                  OpenAI::Graders::StringCheckGrader,
                  OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity,
                  OpenAI::EvalCreateParams::TestingCriterion::Python,
                  OpenAI::EvalCreateParams::TestingCriterion::ScoreModel
                )
              ],
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The configuration for the data source used for the evaluation runs. Dictates the
      # schema of the data used in the evaluation.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::EvalCreateParams::DataSourceConfig::Custom,
              OpenAI::EvalCreateParams::DataSourceConfig::Logs,
              OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions
            )
          end

        class Custom < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::DataSourceConfig::Custom,
                OpenAI::Internal::AnyHash
              )
            end

          # The json schema for each row in the data source.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :item_schema

          # The type of data source. Always `custom`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Whether the eval should expect you to populate the sample namespace (ie, by
          # generating responses off of your data source)
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :include_sample_schema

          sig { params(include_sample_schema: T::Boolean).void }
          attr_writer :include_sample_schema

          # A CustomDataSourceConfig object that defines the schema for the data source used
          # for the evaluation runs. This schema is used to define the shape of the data
          # that will be:
          #
          # - Used to define your testing criteria and
          # - What data is required when creating a run
          sig do
            params(
              item_schema: T::Hash[Symbol, T.anything],
              include_sample_schema: T::Boolean,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The json schema for each row in the data source.
            item_schema:,
            # Whether the eval should expect you to populate the sample namespace (ie, by
            # generating responses off of your data source)
            include_sample_schema: nil,
            # The type of data source. Always `custom`.
            type: :custom
          )
          end

          sig do
            override.returns(
              {
                item_schema: T::Hash[Symbol, T.anything],
                type: Symbol,
                include_sample_schema: T::Boolean
              }
            )
          end
          def to_hash
          end
        end

        class Logs < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::DataSourceConfig::Logs,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of data source. Always `logs`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Metadata filters for the logs data source.
          sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
          attr_reader :metadata

          sig { params(metadata: T::Hash[Symbol, T.anything]).void }
          attr_writer :metadata

          # A data source config which specifies the metadata property of your logs query.
          # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
          sig do
            params(metadata: T::Hash[Symbol, T.anything], type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # Metadata filters for the logs data source.
            metadata: nil,
            # The type of data source. Always `logs`.
            type: :logs
          )
          end

          sig do
            override.returns(
              { type: Symbol, metadata: T::Hash[Symbol, T.anything] }
            )
          end
          def to_hash
          end
        end

        class StoredCompletions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions,
                OpenAI::Internal::AnyHash
              )
            end

          # The type of data source. Always `stored_completions`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Metadata filters for the stored completions data source.
          sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
          attr_reader :metadata

          sig { params(metadata: T::Hash[Symbol, T.anything]).void }
          attr_writer :metadata

          # Deprecated in favor of LogsDataSourceConfig.
          sig do
            params(metadata: T::Hash[Symbol, T.anything], type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # Metadata filters for the stored completions data source.
            metadata: nil,
            # The type of data source. Always `stored_completions`.
            type: :stored_completions
          )
          end

          sig do
            override.returns(
              { type: Symbol, metadata: T::Hash[Symbol, T.anything] }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::EvalCreateParams::DataSourceConfig::Variants]
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
              OpenAI::EvalCreateParams::TestingCriterion::LabelModel,
              OpenAI::Graders::StringCheckGrader,
              OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity,
              OpenAI::EvalCreateParams::TestingCriterion::Python,
              OpenAI::EvalCreateParams::TestingCriterion::ScoreModel
            )
          end

        class LabelModel < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::TestingCriterion::LabelModel,
                OpenAI::Internal::AnyHash
              )
            end

          # A list of chat messages forming the prompt or context. May include variable
          # references to the `item` namespace, ie {{item.name}}.
          sig do
            returns(
              T::Array[
                T.any(
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem
                )
              ]
            )
          end
          attr_accessor :input

          # The labels to classify to each item in the evaluation.
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
                  T.any(
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage::OrHash,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::OrHash
                  )
                ],
              labels: T::Array[String],
              model: String,
              name: String,
              passing_labels: T::Array[String],
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A list of chat messages forming the prompt or context. May include variable
            # references to the `item` namespace, ie {{item.name}}.
            input:,
            # The labels to classify to each item in the evaluation.
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
                    T.any(
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem
                    )
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

          # A chat message that makes up the prompt or context. May include variable
          # references to the `item` namespace, ie {{item.name}}.
          module Input
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem
                )
              end

            class SimpleInputMessage < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The content of the message.
              sig { returns(String) }
              attr_accessor :content

              # The role of the message (e.g. "system", "assistant", "user").
              sig { returns(String) }
              attr_accessor :role

              sig do
                params(content: String, role: String).returns(T.attached_class)
              end
              def self.new(
                # The content of the message.
                content:,
                # The role of the message (e.g. "system", "assistant", "user").
                role:
              )
              end

              sig { override.returns({ content: String, role: String }) }
              def to_hash
              end
            end

            class EvalItem < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Inputs to the model - can contain template strings.
              sig do
                returns(
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage,
                    T::Array[T.anything]
                  )
                )
              end
              attr_accessor :content

              # The role of the message input. One of `user`, `assistant`, `system`, or
              # `developer`.
              sig do
                returns(
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::OrSymbol
                )
              end
              attr_accessor :role

              # The type of the message input. Always `message`.
              sig do
                returns(
                  T.nilable(
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::OrSymbol
                  )
                )
              end
              attr_reader :type

              sig do
                params(
                  type:
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::OrSymbol
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
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText::OrHash,
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage::OrHash,
                      T::Array[T.anything]
                    ),
                  role:
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::OrSymbol,
                  type:
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::OrSymbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Inputs to the model - can contain template strings.
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
                        OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText,
                        OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage,
                        T::Array[T.anything]
                      ),
                    role:
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::OrSymbol,
                    type:
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::OrSymbol
                  }
                )
              end
              def to_hash
              end

              # Inputs to the model - can contain template strings.
              module Content
                extend OpenAI::Internal::Type::Union

                Variants =
                  T.type_alias do
                    T.any(
                      String,
                      OpenAI::Responses::ResponseInputText,
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText,
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage,
                      T::Array[T.anything]
                    )
                  end

                class OutputText < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText,
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

                class InputImage < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # The URL of the image input.
                  sig { returns(String) }
                  attr_accessor :image_url

                  # The type of the image input. Always `input_image`.
                  sig { returns(Symbol) }
                  attr_accessor :type

                  # The detail level of the image to be sent to the model. One of `high`, `low`, or
                  # `auto`. Defaults to `auto`.
                  sig { returns(T.nilable(String)) }
                  attr_reader :detail

                  sig { params(detail: String).void }
                  attr_writer :detail

                  # An image input to the model.
                  sig do
                    params(
                      image_url: String,
                      detail: String,
                      type: Symbol
                    ).returns(T.attached_class)
                  end
                  def self.new(
                    # The URL of the image input.
                    image_url:,
                    # The detail level of the image to be sent to the model. One of `high`, `low`, or
                    # `auto`. Defaults to `auto`.
                    detail: nil,
                    # The type of the image input. Always `input_image`.
                    type: :input_image
                  )
                  end

                  sig do
                    override.returns(
                      { image_url: String, type: Symbol, detail: String }
                    )
                  end
                  def to_hash
                  end
                end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::Variants
                    ]
                  )
                end
                def self.variants
                end

                AnArrayOfInputTextAndInputImageArray =
                  T.let(
                    OpenAI::Internal::Type::ArrayOf[
                      OpenAI::Internal::Type::Unknown
                    ],
                    OpenAI::Internal::Type::Converter
                  )
              end

              # The role of the message input. One of `user`, `assistant`, `system`, or
              # `developer`.
              module Role
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                USER =
                  T.let(
                    :user,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::TaggedSymbol
                  )
                ASSISTANT =
                  T.let(
                    :assistant,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::TaggedSymbol
                  )
                SYSTEM =
                  T.let(
                    :system,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::TaggedSymbol
                  )
                DEVELOPER =
                  T.let(
                    :developer,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role::TaggedSymbol
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
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                MESSAGE =
                  T.let(
                    :message,
                    OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        class TextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity,
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

        class Python < OpenAI::Models::Graders::PythonGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::TestingCriterion::Python,
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

        class ScoreModel < OpenAI::Models::Graders::ScoreModelGrader
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::EvalCreateParams::TestingCriterion::ScoreModel,
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
            T::Array[OpenAI::EvalCreateParams::TestingCriterion::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end

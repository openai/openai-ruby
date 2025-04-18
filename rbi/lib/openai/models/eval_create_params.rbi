# typed: strong

module OpenAI
  module Models
    class EvalCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # The configuration for the data source used for the evaluation runs.
      sig do
        returns(
          T.any(
            OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom,
            OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions
          )
        )
      end
      attr_accessor :data_source_config

      # A list of graders for all eval runs in this group.
      sig do
        returns(
          T::Array[
            T.any(
              OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel,
              OpenAI::Models::EvalStringCheckGrader,
              OpenAI::Models::EvalTextSimilarityGrader
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

      # Indicates whether the evaluation is shared with OpenAI.
      sig { returns(T.nilable(T::Boolean)) }
      attr_reader :share_with_openai

      sig { params(share_with_openai: T::Boolean).void }
      attr_writer :share_with_openai

      sig do
        params(
          data_source_config: T.any(
            OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom,
            OpenAI::Internal::AnyHash,
            OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions
          ),
          testing_criteria: T::Array[
            T.any(
              OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::EvalStringCheckGrader,
              OpenAI::Models::EvalTextSimilarityGrader
            )
          ],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          share_with_openai: T::Boolean,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        data_source_config:,
        testing_criteria:,
        metadata: nil,
        name: nil,
        share_with_openai: nil,
        request_options: {}
      ); end
      sig do
        override
          .returns(
            {
              data_source_config: T.any(
                OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom,
                OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions
              ),
              testing_criteria: T::Array[
                T.any(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel,
                  OpenAI::Models::EvalStringCheckGrader,
                  OpenAI::Models::EvalTextSimilarityGrader
                )
              ],
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              share_with_openai: T::Boolean,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end

      # The configuration for the data source used for the evaluation runs.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        class Custom < OpenAI::Internal::Type::BaseModel
          # The json schema for the run data source items.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :item_schema

          # The type of data source. Always `custom`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Whether to include the sample schema in the data source.
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
            params(item_schema: T::Hash[Symbol, T.anything], include_sample_schema: T::Boolean, type: Symbol)
              .returns(T.attached_class)
          end
          def self.new(item_schema:, include_sample_schema: nil, type: :custom); end

          sig do
            override
              .returns({
                         item_schema: T::Hash[Symbol, T.anything],
                         type: Symbol,
                         include_sample_schema: T::Boolean
                       })
          end
          def to_hash; end
        end

        class StoredCompletions < OpenAI::Internal::Type::BaseModel
          # The type of data source. Always `stored_completions`.
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

          # A data source config which specifies the metadata property of your stored
          # completions query. This is usually metadata like `usecase=chatbot` or
          # `prompt-version=v2`, etc.
          sig { params(metadata: T.nilable(T::Hash[Symbol, String]), type: Symbol).returns(T.attached_class) }
          def self.new(metadata: nil, type: :stored_completions); end

          sig { override.returns({type: Symbol, metadata: T.nilable(T::Hash[Symbol, String])}) }
          def to_hash; end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions]
            )
        end
        def self.variants; end
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        class LabelModel < OpenAI::Internal::Type::BaseModel
          sig do
            returns(
              T::Array[
                T.any(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage,
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage
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
              input: T::Array[
                T.any(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage,
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage
                )
              ],
              labels: T::Array[String],
              model: String,
              name: String,
              passing_labels: T::Array[String],
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(input:, labels:, model:, name:, passing_labels:, type: :label_model); end

          sig do
            override
              .returns(
                {
                  input: T::Array[
                    T.any(
                      OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage,
                      OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage,
                      OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage
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
          def to_hash; end

          module Input
            extend OpenAI::Internal::Type::Union

            class SimpleInputMessage < OpenAI::Internal::Type::BaseModel
              # The content of the message.
              sig { returns(String) }
              attr_accessor :content

              # The role of the message (e.g. "system", "assistant", "user").
              sig { returns(String) }
              attr_accessor :role

              sig { params(content: String, role: String).returns(T.attached_class) }
              def self.new(content:, role:); end

              sig { override.returns({content: String, role: String}) }
              def to_hash; end
            end

            class InputMessage < OpenAI::Internal::Type::BaseModel
              sig { returns(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content) }
              attr_reader :content

              sig do
                params(
                  content: T.any(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content,
                    OpenAI::Internal::AnyHash
                  )
                )
                  .void
              end
              attr_writer :content

              # The role of the message. One of `user`, `system`, or `developer`.
              sig do
                returns(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::OrSymbol
                )
              end
              attr_accessor :role

              # The type of item, which is always `message`.
              sig do
                returns(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type::OrSymbol
                )
              end
              attr_accessor :type

              sig do
                params(
                  content: T.any(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content,
                    OpenAI::Internal::AnyHash
                  ),
                  role: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::OrSymbol,
                  type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type::OrSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(content:, role:, type:); end

              sig do
                override
                  .returns(
                    {
                      content: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content,
                      role: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::OrSymbol,
                      type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type::OrSymbol
                    }
                  )
              end
              def to_hash; end

              class Content < OpenAI::Internal::Type::BaseModel
                # The text content.
                sig { returns(String) }
                attr_accessor :text

                # The type of content, which is always `input_text`.
                sig do
                  returns(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type::OrSymbol
                  )
                end
                attr_accessor :type

                sig do
                  params(
                    text: String,
                    type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type::OrSymbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(text:, type:); end

                sig do
                  override
                    .returns(
                      {
                        text: String,
                        type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type::OrSymbol
                      }
                    )
                end
                def to_hash; end

                # The type of content, which is always `input_text`.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type)
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  INPUT_TEXT =
                    T.let(
                      :input_text,
                      OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end
              end

              # The role of the message. One of `user`, `system`, or `developer`.
              module Role
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role) }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                USER =
                  T.let(
                    :user,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::TaggedSymbol
                  )
                SYSTEM =
                  T.let(
                    :system,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::TaggedSymbol
                  )
                DEVELOPER =
                  T.let(
                    :developer,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::TaggedSymbol
                  )

                sig do
                  override
                    .returns(
                      T::Array[OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role::TaggedSymbol]
                    )
                end
                def self.values; end
              end

              # The type of item, which is always `message`.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type) }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                MESSAGE =
                  T.let(
                    :message,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type::TaggedSymbol
                  )

                sig do
                  override
                    .returns(
                      T::Array[OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type::TaggedSymbol]
                    )
                end
                def self.values; end
              end
            end

            class OutputMessage < OpenAI::Internal::Type::BaseModel
              sig { returns(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content) }
              attr_reader :content

              sig do
                params(
                  content: T.any(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content,
                    OpenAI::Internal::AnyHash
                  )
                )
                  .void
              end
              attr_writer :content

              # The role of the message. Must be `assistant` for output.
              sig do
                returns(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role::OrSymbol
                )
              end
              attr_accessor :role

              # The type of item, which is always `message`.
              sig do
                returns(
                  OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type::OrSymbol
                )
              end
              attr_accessor :type

              sig do
                params(
                  content: T.any(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content,
                    OpenAI::Internal::AnyHash
                  ),
                  role: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role::OrSymbol,
                  type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type::OrSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(content:, role:, type:); end

              sig do
                override
                  .returns(
                    {
                      content: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content,
                      role: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role::OrSymbol,
                      type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type::OrSymbol
                    }
                  )
              end
              def to_hash; end

              class Content < OpenAI::Internal::Type::BaseModel
                # The text content.
                sig { returns(String) }
                attr_accessor :text

                # The type of content, which is always `output_text`.
                sig do
                  returns(
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type::OrSymbol
                  )
                end
                attr_accessor :type

                sig do
                  params(
                    text: String,
                    type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type::OrSymbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(text:, type:); end

                sig do
                  override
                    .returns(
                      {
                        text: String,
                        type: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type::OrSymbol
                      }
                    )
                end
                def to_hash; end

                # The type of content, which is always `output_text`.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type)
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  OUTPUT_TEXT =
                    T.let(
                      :output_text,
                      OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end
              end

              # The role of the message. Must be `assistant` for output.
              module Role
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role) }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                ASSISTANT =
                  T.let(
                    :assistant,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role::TaggedSymbol
                  )

                sig do
                  override
                    .returns(
                      T::Array[OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role::TaggedSymbol]
                    )
                end
                def self.values; end
              end

              # The type of item, which is always `message`.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias { T.all(Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type) }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                MESSAGE =
                  T.let(
                    :message,
                    OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type::TaggedSymbol
                  )

                sig do
                  override
                    .returns(
                      T::Array[OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type::TaggedSymbol]
                    )
                end
                def self.values; end
              end
            end

            sig do
              override
                .returns(
                  [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage]
                )
            end
            def self.variants; end
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader]
            )
        end
        def self.variants; end
      end
    end
  end
end

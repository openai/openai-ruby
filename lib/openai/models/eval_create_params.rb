# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#create
    class EvalCreateParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute data_source_config
      #   The configuration for the data source used for the evaluation runs.
      #
      #   @return [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions]
      required :data_source_config, union: -> { OpenAI::Models::EvalCreateParams::DataSourceConfig }

      # @!attribute testing_criteria
      #   A list of graders for all eval runs in this group.
      #
      #   @return [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader>]
      required :testing_criteria,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalCreateParams::TestingCriterion] }

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

      # @!attribute [r] name
      #   The name of the evaluation.
      #
      #   @return [String, nil]
      optional :name, String

      # @!parse
      #   # @return [String]
      #   attr_writer :name

      # @!attribute [r] share_with_openai
      #   Indicates whether the evaluation is shared with OpenAI.
      #
      #   @return [Boolean, nil]
      optional :share_with_openai, OpenAI::Internal::Type::Boolean

      # @!parse
      #   # @return [Boolean]
      #   attr_writer :share_with_openai

      # @!parse
      #   # @param data_source_config [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions]
      #   # @param testing_criteria [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader>]
      #   # @param metadata [Hash{Symbol=>String}, nil]
      #   # @param name [String]
      #   # @param share_with_openai [Boolean]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(
      #     data_source_config:,
      #     testing_criteria:,
      #     metadata: nil,
      #     name: nil,
      #     share_with_openai: nil,
      #     request_options: {},
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # The configuration for the data source used for the evaluation runs.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A CustomDataSourceConfig object that defines the schema for the data source used for the evaluation runs.
        # This schema is used to define the shape of the data that will be:
        # - Used to define your testing criteria and
        # - What data is required when creating a run
        variant :custom, -> { OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom }

        # A data source config which specifies the metadata property of your stored completions query.
        # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
        variant :stored_completions, -> { OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions }

        class Custom < OpenAI::Internal::Type::BaseModel
          # @!attribute item_schema
          #   The json schema for the run data source items.
          #
          #   @return [Hash{Symbol=>Object}]
          required :item_schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute type
          #   The type of data source. Always `custom`.
          #
          #   @return [Symbol, :custom]
          required :type, const: :custom

          # @!attribute [r] include_sample_schema
          #   Whether to include the sample schema in the data source.
          #
          #   @return [Boolean, nil]
          optional :include_sample_schema, OpenAI::Internal::Type::Boolean

          # @!parse
          #   # @return [Boolean]
          #   attr_writer :include_sample_schema

          # @!parse
          #   # A CustomDataSourceConfig object that defines the schema for the data source used
          #   # for the evaluation runs. This schema is used to define the shape of the data
          #   # that will be:
          #   #
          #   # - Used to define your testing criteria and
          #   # - What data is required when creating a run
          #   #
          #   # @param item_schema [Hash{Symbol=>Object}]
          #   # @param include_sample_schema [Boolean]
          #   # @param type [Symbol, :custom]
          #   #
          #   def initialize(item_schema:, include_sample_schema: nil, type: :custom, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end

        class StoredCompletions < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of data source. Always `stored_completions`.
          #
          #   @return [Symbol, :stored_completions]
          required :type, const: :stored_completions

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

          # @!parse
          #   # A data source config which specifies the metadata property of your stored
          #   # completions query. This is usually metadata like `usecase=chatbot` or
          #   # `prompt-version=v2`, etc.
          #   #
          #   # @param metadata [Hash{Symbol=>String}, nil]
          #   # @param type [Symbol, :stored_completions]
          #   #
          #   def initialize(metadata: nil, type: :stored_completions, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end

        # @!parse
        #   # @return [Array(OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions)]
        #   def self.variants; end
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A LabelModelGrader object which uses a model to assign labels to each item
        # in the evaluation.
        variant :label_model, -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel }

        # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
        variant :string_check, -> { OpenAI::Models::EvalStringCheckGrader }

        # A TextSimilarityGrader object which grades text based on similarity metrics.
        variant :text_similarity, -> { OpenAI::Models::EvalTextSimilarityGrader }

        class LabelModel < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #
          #   @return [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage>]
          required :input,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input] }

          # @!attribute labels
          #   The labels to classify to each item in the evaluation.
          #
          #   @return [Array<String>]
          required :labels, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute model
          #   The model to use for the evaluation. Must support structured outputs.
          #
          #   @return [String]
          required :model, String

          # @!attribute name
          #   The name of the grader.
          #
          #   @return [String]
          required :name, String

          # @!attribute passing_labels
          #   The labels that indicate a passing result. Must be a subset of labels.
          #
          #   @return [Array<String>]
          required :passing_labels, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute type
          #   The object type, which is always `label_model`.
          #
          #   @return [Symbol, :label_model]
          required :type, const: :label_model

          # @!parse
          #   # A LabelModelGrader object which uses a model to assign labels to each item in
          #   # the evaluation.
          #   #
          #   # @param input [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage>]
          #   # @param labels [Array<String>]
          #   # @param model [String]
          #   # @param name [String]
          #   # @param passing_labels [Array<String>]
          #   # @param type [Symbol, :label_model]
          #   #
          #   def initialize(input:, labels:, model:, name:, passing_labels:, type: :label_model, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          module Input
            extend OpenAI::Internal::Type::Union

            variant -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage }

            variant -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage }

            variant -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage }

            class SimpleInputMessage < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #   The content of the message.
              #
              #   @return [String]
              required :content, String

              # @!attribute role
              #   The role of the message (e.g. "system", "assistant", "user").
              #
              #   @return [String]
              required :role, String

              # @!parse
              #   # @param content [String]
              #   # @param role [String]
              #   #
              #   def initialize(content:, role:, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
            end

            class InputMessage < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #
              #   @return [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content]
              required :content,
                       -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content }

              # @!attribute role
              #   The role of the message. One of `user`, `system`, or `developer`.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role]
              required :role,
                       enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role }

              # @!attribute type
              #   The type of item, which is always `message`.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type]
              required :type,
                       enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type }

              # @!parse
              #   # @param content [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content]
              #   # @param role [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Role]
              #   # @param type [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Type]
              #   #
              #   def initialize(content:, role:, type:, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage#content
              class Content < OpenAI::Internal::Type::BaseModel
                # @!attribute text
                #   The text content.
                #
                #   @return [String]
                required :text, String

                # @!attribute type
                #   The type of content, which is always `input_text`.
                #
                #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type]
                required :type,
                         enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type }

                # @!parse
                #   # @param text [String]
                #   # @param type [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content::Type]
                #   #
                #   def initialize(text:, type:, **) = super

                # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

                # The type of content, which is always `input_text`.
                #
                # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage::Content#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  INPUT_TEXT = :input_text

                  finalize!

                  # @!parse
                  #   # @return [Array<Symbol>]
                  #   def self.values; end
                end
              end

              # The role of the message. One of `user`, `system`, or `developer`.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage#role
              module Role
                extend OpenAI::Internal::Type::Enum

                USER = :user
                SYSTEM = :system
                DEVELOPER = :developer

                finalize!

                # @!parse
                #   # @return [Array<Symbol>]
                #   def self.values; end
              end

              # The type of item, which is always `message`.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage#type
              module Type
                extend OpenAI::Internal::Type::Enum

                MESSAGE = :message

                finalize!

                # @!parse
                #   # @return [Array<Symbol>]
                #   def self.values; end
              end
            end

            class OutputMessage < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #
              #   @return [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content]
              required :content,
                       -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content }

              # @!attribute role
              #   The role of the message. Must be `assistant` for output.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role]
              required :role,
                       enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role }

              # @!attribute type
              #   The type of item, which is always `message`.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type]
              required :type,
                       enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type }

              # @!parse
              #   # @param content [OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content]
              #   # @param role [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Role]
              #   # @param type [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Type]
              #   #
              #   def initialize(content:, role:, type:, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage#content
              class Content < OpenAI::Internal::Type::BaseModel
                # @!attribute text
                #   The text content.
                #
                #   @return [String]
                required :text, String

                # @!attribute type
                #   The type of content, which is always `output_text`.
                #
                #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type]
                required :type,
                         enum: -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type }

                # @!parse
                #   # @param text [String]
                #   # @param type [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content::Type]
                #   #
                #   def initialize(text:, type:, **) = super

                # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

                # The type of content, which is always `output_text`.
                #
                # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage::Content#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  OUTPUT_TEXT = :output_text

                  finalize!

                  # @!parse
                  #   # @return [Array<Symbol>]
                  #   def self.values; end
                end
              end

              # The role of the message. Must be `assistant` for output.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage#role
              module Role
                extend OpenAI::Internal::Type::Enum

                ASSISTANT = :assistant

                finalize!

                # @!parse
                #   # @return [Array<Symbol>]
                #   def self.values; end
              end

              # The type of item, which is always `message`.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage#type
              module Type
                extend OpenAI::Internal::Type::Enum

                MESSAGE = :message

                finalize!

                # @!parse
                #   # @return [Array<Symbol>]
                #   def self.values; end
              end
            end

            # @!parse
            #   # @return [Array(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::InputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::OutputMessage)]
            #   def self.variants; end
          end
        end

        # @!parse
        #   # @return [Array(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader)]
        #   def self.variants; end
      end
    end
  end
end

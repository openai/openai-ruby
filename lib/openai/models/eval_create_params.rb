# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#create
    class EvalCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute data_source_config
      #   The configuration for the data source used for the evaluation runs. Dictates the
      #   schema of the data used in the evaluation.
      #
      #   @return [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::Logs, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions]
      required :data_source_config, union: -> { OpenAI::EvalCreateParams::DataSourceConfig }

      # @!attribute testing_criteria
      #   A list of graders for all eval runs in this group. Graders can reference
      #   variables in the data source using double curly braces notation, like
      #   `{{item.variable_name}}`. To reference the model's output, use the `sample`
      #   namespace (ie, `{{sample.output_text}}`).
      #
      #   @return [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalCreateParams::TestingCriterion::TextSimilarity, OpenAI::Models::EvalCreateParams::TestingCriterion::Python, OpenAI::Models::EvalCreateParams::TestingCriterion::ScoreModel>]
      required :testing_criteria,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::EvalCreateParams::TestingCriterion] }

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

      # @!attribute name
      #   The name of the evaluation.
      #
      #   @return [String, nil]
      optional :name, String

      # @!method initialize(data_source_config:, testing_criteria:, metadata: nil, name: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::EvalCreateParams} for more details.
      #
      #   @param data_source_config [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::Logs, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions] The configuration for the data source used for the evaluation runs. Dictates the
      #
      #   @param testing_criteria [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalCreateParams::TestingCriterion::TextSimilarity, OpenAI::Models::EvalCreateParams::TestingCriterion::Python, OpenAI::Models::EvalCreateParams::TestingCriterion::ScoreModel>] A list of graders for all eval runs in this group. Graders can reference variabl
      #
      #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      #   @param name [String] The name of the evaluation.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The configuration for the data source used for the evaluation runs. Dictates the
      # schema of the data used in the evaluation.
      module DataSourceConfig
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A CustomDataSourceConfig object that defines the schema for the data source used for the evaluation runs.
        # This schema is used to define the shape of the data that will be:
        # - Used to define your testing criteria and
        # - What data is required when creating a run
        variant :custom, -> { OpenAI::EvalCreateParams::DataSourceConfig::Custom }

        # A data source config which specifies the metadata property of your logs query.
        # This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
        variant :logs, -> { OpenAI::EvalCreateParams::DataSourceConfig::Logs }

        # Deprecated in favor of LogsDataSourceConfig.
        variant :stored_completions, -> { OpenAI::EvalCreateParams::DataSourceConfig::StoredCompletions }

        class Custom < OpenAI::Internal::Type::BaseModel
          # @!attribute item_schema
          #   The json schema for each row in the data source.
          #
          #   @return [Hash{Symbol=>Object}]
          required :item_schema, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute type
          #   The type of data source. Always `custom`.
          #
          #   @return [Symbol, :custom]
          required :type, const: :custom

          # @!attribute include_sample_schema
          #   Whether the eval should expect you to populate the sample namespace (ie, by
          #   generating responses off of your data source)
          #
          #   @return [Boolean, nil]
          optional :include_sample_schema, OpenAI::Internal::Type::Boolean

          # @!method initialize(item_schema:, include_sample_schema: nil, type: :custom)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom} for more details.
          #
          #   A CustomDataSourceConfig object that defines the schema for the data source used
          #   for the evaluation runs. This schema is used to define the shape of the data
          #   that will be:
          #
          #   - Used to define your testing criteria and
          #   - What data is required when creating a run
          #
          #   @param item_schema [Hash{Symbol=>Object}] The json schema for each row in the data source.
          #
          #   @param include_sample_schema [Boolean] Whether the eval should expect you to populate the sample namespace (ie, by gene
          #
          #   @param type [Symbol, :custom] The type of data source. Always `custom`.
        end

        class Logs < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of data source. Always `logs`.
          #
          #   @return [Symbol, :logs]
          required :type, const: :logs

          # @!attribute metadata
          #   Metadata filters for the logs data source.
          #
          #   @return [Hash{Symbol=>Object}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!method initialize(metadata: nil, type: :logs)
          #   A data source config which specifies the metadata property of your logs query.
          #   This is usually metadata like `usecase=chatbot` or `prompt-version=v2`, etc.
          #
          #   @param metadata [Hash{Symbol=>Object}] Metadata filters for the logs data source.
          #
          #   @param type [Symbol, :logs] The type of data source. Always `logs`.
        end

        # @deprecated
        class StoredCompletions < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of data source. Always `stored_completions`.
          #
          #   @return [Symbol, :stored_completions]
          required :type, const: :stored_completions

          # @!attribute metadata
          #   Metadata filters for the stored completions data source.
          #
          #   @return [Hash{Symbol=>Object}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!method initialize(metadata: nil, type: :stored_completions)
          #   Deprecated in favor of LogsDataSourceConfig.
          #
          #   @param metadata [Hash{Symbol=>Object}] Metadata filters for the stored completions data source.
          #
          #   @param type [Symbol, :stored_completions] The type of data source. Always `stored_completions`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::Logs, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions)]
      end

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      module TestingCriterion
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A LabelModelGrader object which uses a model to assign labels to each item
        # in the evaluation.
        variant :label_model, -> { OpenAI::EvalCreateParams::TestingCriterion::LabelModel }

        # A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.
        variant :string_check, -> { OpenAI::Graders::StringCheckGrader }

        # A TextSimilarityGrader object which grades text based on similarity metrics.
        variant :text_similarity, -> { OpenAI::EvalCreateParams::TestingCriterion::TextSimilarity }

        # A PythonGrader object that runs a python script on the input.
        variant :python, -> { OpenAI::EvalCreateParams::TestingCriterion::Python }

        # A ScoreModelGrader object that uses a model to assign a score to the input.
        variant :score_model, -> { OpenAI::EvalCreateParams::TestingCriterion::ScoreModel }

        class LabelModel < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   A list of chat messages forming the prompt or context. May include variable
          #   references to the `item` namespace, ie {{item.name}}.
          #
          #   @return [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem>]
          required :input,
                   -> {
                     OpenAI::Internal::Type::ArrayOf[union: OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input]
                   }

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

          # @!method initialize(input:, labels:, model:, name:, passing_labels:, type: :label_model)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel} for more
          #   details.
          #
          #   A LabelModelGrader object which uses a model to assign labels to each item in
          #   the evaluation.
          #
          #   @param input [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
          #
          #   @param labels [Array<String>] The labels to classify to each item in the evaluation.
          #
          #   @param model [String] The model to use for the evaluation. Must support structured outputs.
          #
          #   @param name [String] The name of the grader.
          #
          #   @param passing_labels [Array<String>] The labels that indicate a passing result. Must be a subset of labels.
          #
          #   @param type [Symbol, :label_model] The object type, which is always `label_model`.

          # A chat message that makes up the prompt or context. May include variable
          # references to the `item` namespace, ie {{item.name}}.
          module Input
            extend OpenAI::Internal::Type::Union

            variant -> { OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage }

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            variant -> { OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem }

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

              # @!method initialize(content:, role:)
              #   @param content [String] The content of the message.
              #
              #   @param role [String] The role of the message (e.g. "system", "assistant", "user").
            end

            class EvalItem < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #   Inputs to the model - can contain template strings.
              #
              #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage, Array<Object>]
              required :content,
                       union: -> {
                         OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content
                       }

              # @!attribute role
              #   The role of the message input. One of `user`, `assistant`, `system`, or
              #   `developer`.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role]
              required :role,
                       enum: -> {
                         OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role
                       }

              # @!attribute type
              #   The type of the message input. Always `message`.
              #
              #   @return [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type, nil]
              optional :type,
                       enum: -> {
                         OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type
                       }

              # @!method initialize(content:, role:, type: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem}
              #   for more details.
              #
              #   A message input to the model with a role indicating instruction following
              #   hierarchy. Instructions given with the `developer` or `system` role take
              #   precedence over instructions given with the `user` role. Messages with the
              #   `assistant` role are presumed to have been generated by the model in previous
              #   interactions.
              #
              #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage, Array<Object>] Inputs to the model - can contain template strings.
              #
              #   @param role [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Role] The role of the message input. One of `user`, `assistant`, `system`, or
              #
              #   @param type [Symbol, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Type] The type of the message input. Always `message`.

              # Inputs to the model - can contain template strings.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem#content
              module Content
                extend OpenAI::Internal::Type::Union

                # A text input to the model.
                variant String

                # A text input to the model.
                variant -> { OpenAI::Responses::ResponseInputText }

                # A text output from the model.
                variant -> {
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText
                }

                # An image input to the model.
                variant -> {
                  OpenAI::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage
                }

                # A list of inputs, each of which may be either an input text or input image object.
                variant -> { OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::AnArrayOfInputTextAndInputImageArray }

                class OutputText < OpenAI::Internal::Type::BaseModel
                  # @!attribute text
                  #   The text output from the model.
                  #
                  #   @return [String]
                  required :text, String

                  # @!attribute type
                  #   The type of the output text. Always `output_text`.
                  #
                  #   @return [Symbol, :output_text]
                  required :type, const: :output_text

                  # @!method initialize(text:, type: :output_text)
                  #   Some parameter documentations has been truncated, see
                  #   {OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText}
                  #   for more details.
                  #
                  #   A text output from the model.
                  #
                  #   @param text [String] The text output from the model.
                  #
                  #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`.
                end

                class InputImage < OpenAI::Internal::Type::BaseModel
                  # @!attribute image_url
                  #   The URL of the image input.
                  #
                  #   @return [String]
                  required :image_url, String

                  # @!attribute type
                  #   The type of the image input. Always `input_image`.
                  #
                  #   @return [Symbol, :input_image]
                  required :type, const: :input_image

                  # @!attribute detail
                  #   The detail level of the image to be sent to the model. One of `high`, `low`, or
                  #   `auto`. Defaults to `auto`.
                  #
                  #   @return [String, nil]
                  optional :detail, String

                  # @!method initialize(image_url:, detail: nil, type: :input_image)
                  #   Some parameter documentations has been truncated, see
                  #   {OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage}
                  #   for more details.
                  #
                  #   An image input to the model.
                  #
                  #   @param image_url [String] The URL of the image input.
                  #
                  #   @param detail [String] The detail level of the image to be sent to the model. One of `high`, `low`, or
                  #
                  #   @param type [Symbol, :input_image] The type of the image input. Always `input_image`.
                end

                # @!method self.variants
                #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::OutputText, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem::Content::InputImage, Array<Object>)]

                # @type [OpenAI::Internal::Type::Converter]
                AnArrayOfInputTextAndInputImageArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]
              end

              # The role of the message input. One of `user`, `assistant`, `system`, or
              # `developer`.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem#role
              module Role
                extend OpenAI::Internal::Type::Enum

                USER = :user
                ASSISTANT = :assistant
                SYSTEM = :system
                DEVELOPER = :developer

                # @!method self.values
                #   @return [Array<Symbol>]
              end

              # The type of the message input. Always `message`.
              #
              # @see OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem#type
              module Type
                extend OpenAI::Internal::Type::Enum

                MESSAGE = :message

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::SimpleInputMessage, OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel::Input::EvalItem)]
          end
        end

        class TextSimilarity < OpenAI::Models::Graders::TextSimilarityGrader
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

        class Python < OpenAI::Models::Graders::PythonGrader
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

        class ScoreModel < OpenAI::Models::Graders::ScoreModelGrader
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
        #   @return [Array(OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::EvalCreateParams::TestingCriterion::TextSimilarity, OpenAI::Models::EvalCreateParams::TestingCriterion::Python, OpenAI::Models::EvalCreateParams::TestingCriterion::ScoreModel)]
      end
    end
  end
end

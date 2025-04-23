# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#create
    class EvalCreateResponse < OpenAI::Internal::Type::BaseModel
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
      required :data_source_config, union: -> { OpenAI::Models::EvalCreateResponse::DataSourceConfig }

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

      # @!attribute testing_criteria
      #   A list of testing criteria.
      #
      #   @return [Array<OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader, OpenAI::Models::EvalCreateResponse::TestingCriterion::Python, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel>]
      required :testing_criteria,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalCreateResponse::TestingCriterion] }

      # @!method initialize(id:, created_at:, data_source_config:, metadata:, name:, testing_criteria:, object: :eval)
      #   An Eval object with a data source config and testing criteria. An Eval
      #   represents a task to be done for your LLM integration. Like:
      #
      #   - Improve the quality of my chatbot
      #   - See how well my chatbot handles customer support
      #   - Check if o3-mini is better at my usecase than gpt-4o
      #
      #   @param id [String]
      #   @param created_at [Integer]
      #   @param data_source_config [OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig]
      #   @param metadata [Hash{Symbol=>String}, nil]
      #   @param name [String]
      #   @param testing_criteria [Array<OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader, OpenAI::Models::EvalCreateResponse::TestingCriterion::Python, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel>]
      #   @param object [Symbol, :eval]

      # Configuration of data sources used in runs of the evaluation.
      #
      # @see OpenAI::Models::EvalCreateResponse#data_source_config
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

        # @!method self.variants
        #   @return [Array(OpenAI::Models::EvalCustomDataSourceConfig, OpenAI::Models::EvalStoredCompletionsDataSourceConfig)]
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

        # A PythonGrader object that runs a python script on the input.
        variant :python, -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::Python }

        # A ScoreModelGrader object that uses a model to assign a score to the input.
        variant :score_model, -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel }

        class Python < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #   The name of the grader.
          #
          #   @return [String]
          required :name, String

          # @!attribute source
          #   The source code of the python script.
          #
          #   @return [String]
          required :source, String

          # @!attribute type
          #   The object type, which is always `python`.
          #
          #   @return [Symbol, :python]
          required :type, const: :python

          # @!attribute image_tag
          #   The image tag to use for the python script.
          #
          #   @return [String, nil]
          optional :image_tag, String

          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!method initialize(name:, source:, image_tag: nil, pass_threshold: nil, type: :python)
          #   A PythonGrader object that runs a python script on the input.
          #
          #   @param name [String]
          #   @param source [String]
          #   @param image_tag [String]
          #   @param pass_threshold [Float]
          #   @param type [Symbol, :python]
        end

        class ScoreModel < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   The input text. This may include template strings.
          #
          #   @return [Array<OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input>]
          required :input,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input] }

          # @!attribute model
          #   The model to use for the evaluation.
          #
          #   @return [String]
          required :model, String

          # @!attribute name
          #   The name of the grader.
          #
          #   @return [String]
          required :name, String

          # @!attribute type
          #   The object type, which is always `score_model`.
          #
          #   @return [Symbol, :score_model]
          required :type, const: :score_model

          # @!attribute pass_threshold
          #   The threshold for the score.
          #
          #   @return [Float, nil]
          optional :pass_threshold, Float

          # @!attribute range
          #   The range of the score. Defaults to `[0, 1]`.
          #
          #   @return [Array<Float>, nil]
          optional :range, OpenAI::Internal::Type::ArrayOf[Float]

          # @!attribute sampling_params
          #   The sampling parameters for the model.
          #
          #   @return [Object, nil]
          optional :sampling_params, OpenAI::Internal::Type::Unknown

          # @!method initialize(input:, model:, name:, pass_threshold: nil, range: nil, sampling_params: nil, type: :score_model)
          #   A ScoreModelGrader object that uses a model to assign a score to the input.
          #
          #   @param input [Array<OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input>]
          #   @param model [String]
          #   @param name [String]
          #   @param pass_threshold [Float]
          #   @param range [Array<Float>]
          #   @param sampling_params [Object]
          #   @param type [Symbol, :score_model]

          class Input < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   Text inputs to the model - can contain template strings.
            #
            #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText]
            required :content,
                     union: -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content }

            # @!attribute role
            #   The role of the message input. One of `user`, `assistant`, `system`, or
            #   `developer`.
            #
            #   @return [Symbol, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role]
            required :role, enum: -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role }

            # @!attribute type
            #   The type of the message input. Always `message`.
            #
            #   @return [Symbol, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type, nil]
            optional :type, enum: -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type }

            # @!method initialize(content:, role:, type: nil)
            #   A message input to the model with a role indicating instruction following
            #   hierarchy. Instructions given with the `developer` or `system` role take
            #   precedence over instructions given with the `user` role. Messages with the
            #   `assistant` role are presumed to have been generated by the model in previous
            #   interactions.
            #
            #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText]
            #   @param role [Symbol, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Role]
            #   @param type [Symbol, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Type]

            # Text inputs to the model - can contain template strings.
            #
            # @see OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input#content
            module Content
              extend OpenAI::Internal::Type::Union

              # A text input to the model.
              variant String

              # A text input to the model.
              variant -> { OpenAI::Models::Responses::ResponseInputText }

              # A text output from the model.
              variant -> { OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText }

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
                #   A text output from the model.
                #
                #   @param text [String]
                #   @param type [Symbol, :output_text]
              end

              # @!method self.variants
              #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input::Content::OutputText)]
            end

            # The role of the message input. One of `user`, `assistant`, `system`, or
            # `developer`.
            #
            # @see OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input#role
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
            # @see OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel::Input#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE = :message

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::EvalLabelModelGrader, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader, OpenAI::Models::EvalCreateResponse::TestingCriterion::Python, OpenAI::Models::EvalCreateResponse::TestingCriterion::ScoreModel)]
      end
    end
  end
end

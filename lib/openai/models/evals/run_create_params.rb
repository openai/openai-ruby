# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#create
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute data_source
        #   Details about the run's data source.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource]
        required :data_source, union: -> { OpenAI::Evals::RunCreateParams::DataSource }

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
        #   The name of the run.
        #
        #   @return [String, nil]
        optional :name, String

        # @!method initialize(data_source:, metadata: nil, name: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::RunCreateParams} for more details.
        #
        #   @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource] Details about the run's data source.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param name [String] The name of the run.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant -> { OpenAI::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource }

          # A ResponsesRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource }

          class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
            # @!attribute source
            #   Determines what populates the `item` namespace in this run's data source.
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses]
            required :source,
                     union: -> {
                       OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source
                     }

            # @!attribute type
            #   The type of run data source. Always `responses`.
            #
            #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type]
            required :type,
                     enum: -> {
                       OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type
                     }

            # @!attribute input_messages
            #   Used when sampling from a model. Dictates the structure of the messages passed
            #   into the model. Can either be a reference to a prebuilt trajectory (ie,
            #   `item.input_trajectory`), or a template with variable references to the `item`
            #   namespace.
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference, nil]
            optional :input_messages,
                     union: -> {
                       OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages
                     }

            # @!attribute model
            #   The name of the model to use for generating completions (e.g. "o3-mini").
            #
            #   @return [String, nil]
            optional :model, String

            # @!attribute sampling_params
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams, nil]
            optional :sampling_params,
                     -> {
                       OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams
                     }

            # @!method initialize(source:, type:, input_messages: nil, model: nil, sampling_params: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource}
            #   for more details.
            #
            #   A ResponsesRunDataSource object describing a model sampling configuration.
            #
            #   @param source [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses] Determines what populates the `item` namespace in this run's data source.
            #
            #   @param type [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type] The type of run data source. Always `responses`.
            #
            #   @param input_messages [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference] Used when sampling from a model. Dictates the structure of the messages passed i
            #
            #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
            #
            #   @param sampling_params [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams]

            # Determines what populates the `item` namespace in this run's data source.
            #
            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#source
            module Source
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :file_content,
                      -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent
                      }

              variant :file_id,
                      -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID
                      }

              # A EvalResponsesSource object describing a run data source configuration.
              variant :responses,
                      -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                      }

              class FileContent < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   The content of the jsonl file.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content>]
                required :content,
                         -> {
                           OpenAI::Internal::Type::ArrayOf[OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content]
                         }

                # @!attribute type
                #   The type of jsonl source. Always `file_content`.
                #
                #   @return [Symbol, :file_content]
                required :type, const: :file_content

                # @!method initialize(content:, type: :file_content)
                #   @param content [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content>] The content of the jsonl file.
                #
                #   @param type [Symbol, :file_content] The type of jsonl source. Always `file_content`.

                class Content < OpenAI::Internal::Type::BaseModel
                  # @!attribute item
                  #
                  #   @return [Hash{Symbol=>Object}]
                  required :item, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

                  # @!attribute sample
                  #
                  #   @return [Hash{Symbol=>Object}, nil]
                  optional :sample, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

                  # @!method initialize(item:, sample: nil)
                  #   @param item [Hash{Symbol=>Object}]
                  #   @param sample [Hash{Symbol=>Object}]
                end
              end

              class FileID < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The identifier of the file.
                #
                #   @return [String]
                required :id, String

                # @!attribute type
                #   The type of jsonl source. Always `file_id`.
                #
                #   @return [Symbol, :file_id]
                required :type, const: :file_id

                # @!method initialize(id:, type: :file_id)
                #   @param id [String] The identifier of the file.
                #
                #   @param type [Symbol, :file_id] The type of jsonl source. Always `file_id`.
              end

              class Responses < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The type of run data source. Always `responses`.
                #
                #   @return [Symbol, :responses]
                required :type, const: :responses

                # @!attribute created_after
                #   Only include items created after this timestamp (inclusive). This is a query
                #   parameter used to select responses.
                #
                #   @return [Integer, nil]
                optional :created_after, Integer, nil?: true

                # @!attribute created_before
                #   Only include items created before this timestamp (inclusive). This is a query
                #   parameter used to select responses.
                #
                #   @return [Integer, nil]
                optional :created_before, Integer, nil?: true

                # @!attribute instructions_search
                #   Optional string to search the 'instructions' field. This is a query parameter
                #   used to select responses.
                #
                #   @return [String, nil]
                optional :instructions_search, String, nil?: true

                # @!attribute metadata
                #   Metadata filter for the responses. This is a query parameter used to select
                #   responses.
                #
                #   @return [Object, nil]
                optional :metadata, OpenAI::Internal::Type::Unknown, nil?: true

                # @!attribute model
                #   The name of the model to find responses for. This is a query parameter used to
                #   select responses.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute reasoning_effort
                #   Optional reasoning effort parameter. This is a query parameter used to select
                #   responses.
                #
                #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
                optional :reasoning_effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

                # @!attribute temperature
                #   Sampling temperature. This is a query parameter used to select responses.
                #
                #   @return [Float, nil]
                optional :temperature, Float, nil?: true

                # @!attribute tools
                #   List of tool names. This is a query parameter used to select responses.
                #
                #   @return [Array<String>, nil]
                optional :tools, OpenAI::Internal::Type::ArrayOf[String], nil?: true

                # @!attribute top_p
                #   Nucleus sampling parameter. This is a query parameter used to select responses.
                #
                #   @return [Float, nil]
                optional :top_p, Float, nil?: true

                # @!attribute users
                #   List of user identifiers. This is a query parameter used to select responses.
                #
                #   @return [Array<String>, nil]
                optional :users, OpenAI::Internal::Type::ArrayOf[String], nil?: true

                # @!method initialize(created_after: nil, created_before: nil, instructions_search: nil, metadata: nil, model: nil, reasoning_effort: nil, temperature: nil, tools: nil, top_p: nil, users: nil, type: :responses)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses}
                #   for more details.
                #
                #   A EvalResponsesSource object describing a run data source configuration.
                #
                #   @param created_after [Integer, nil] Only include items created after this timestamp (inclusive). This is a query par
                #
                #   @param created_before [Integer, nil] Only include items created before this timestamp (inclusive). This is a query pa
                #
                #   @param instructions_search [String, nil] Optional string to search the 'instructions' field. This is a query parameter us
                #
                #   @param metadata [Object, nil] Metadata filter for the responses. This is a query parameter used to select resp
                #
                #   @param model [String, nil] The name of the model to find responses for. This is a query parameter used to s
                #
                #   @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] Optional reasoning effort parameter. This is a query parameter used to select re
                #
                #   @param temperature [Float, nil] Sampling temperature. This is a query parameter used to select responses.
                #
                #   @param tools [Array<String>, nil] List of tool names. This is a query parameter used to select responses.
                #
                #   @param top_p [Float, nil] Nucleus sampling parameter. This is a query parameter used to select responses.
                #
                #   @param users [Array<String>, nil] List of user identifiers. This is a query parameter used to select responses.
                #
                #   @param type [Symbol, :responses] The type of run data source. Always `responses`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses)]
            end

            # The type of run data source. Always `responses`.
            #
            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#type
            module Type
              extend OpenAI::Internal::Type::Enum

              RESPONSES = :responses

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # Used when sampling from a model. Dictates the structure of the messages passed
            # into the model. Can either be a reference to a prebuilt trajectory (ie,
            # `item.input_trajectory`), or a template with variable references to the `item`
            # namespace.
            #
            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#input_messages
            module InputMessages
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :template,
                      -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template
                      }

              variant :item_reference,
                      -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                      }

              class Template < OpenAI::Internal::Type::BaseModel
                # @!attribute template
                #   A list of chat messages forming the prompt or context. May include variable
                #   references to the `item` namespace, ie {{item.name}}.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem>]
                required :template,
                         -> do
                           OpenAI::Internal::Type::ArrayOf[
                             union: OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template
                           ]
                         end

                # @!attribute type
                #   The type of input messages. Always `template`.
                #
                #   @return [Symbol, :template]
                required :type, const: :template

                # @!method initialize(template:, type: :template)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template}
                #   for more details.
                #
                #   @param template [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
                #
                #   @param type [Symbol, :template] The type of input messages. Always `template`.

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                module Template
                  extend OpenAI::Internal::Type::Union

                  variant -> {
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage
                  }

                  # A message input to the model with a role indicating instruction following
                  # hierarchy. Instructions given with the `developer` or `system` role take
                  # precedence over instructions given with the `user` role. Messages with the
                  # `assistant` role are presumed to have been generated by the model in previous
                  # interactions.
                  variant -> {
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
                  }

                  class ChatMessage < OpenAI::Internal::Type::BaseModel
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
                    #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, Array<Object>]
                    required :content,
                             union: -> {
                               OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content
                             }

                    # @!attribute role
                    #   The role of the message input. One of `user`, `assistant`, `system`, or
                    #   `developer`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role]
                    required :role,
                             enum: -> {
                               OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role
                             }

                    # @!attribute type
                    #   The type of the message input. Always `message`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type, nil]
                    optional :type,
                             enum: -> {
                               OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type
                             }

                    # @!method initialize(content:, role:, type: nil)
                    #   Some parameter documentations has been truncated, see
                    #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem}
                    #   for more details.
                    #
                    #   A message input to the model with a role indicating instruction following
                    #   hierarchy. Instructions given with the `developer` or `system` role take
                    #   precedence over instructions given with the `user` role. Messages with the
                    #   `assistant` role are presumed to have been generated by the model in previous
                    #   interactions.
                    #
                    #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, Array<Object>] Inputs to the model - can contain template strings.
                    #
                    #   @param role [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role] The role of the message input. One of `user`, `assistant`, `system`, or
                    #
                    #   @param type [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type] The type of the message input. Always `message`.

                    # Inputs to the model - can contain template strings.
                    #
                    # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem#content
                    module Content
                      extend OpenAI::Internal::Type::Union

                      # A text input to the model.
                      variant String

                      # A text input to the model.
                      variant -> { OpenAI::Responses::ResponseInputText }

                      # A text output from the model.
                      variant -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText
                      }

                      # An image input to the model.
                      variant -> {
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage
                      }

                      # A list of inputs, each of which may be either an input text or input image object.
                      variant -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextAndInputImageArray }

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
                        #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText}
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
                        #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage}
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
                      #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, Array<Object>)]

                      # @type [OpenAI::Internal::Type::Converter]
                      AnArrayOfInputTextAndInputImageArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]
                    end

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    #
                    # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem#role
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
                    # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem#type
                    module Type
                      extend OpenAI::Internal::Type::Enum

                      MESSAGE = :message

                      # @!method self.values
                      #   @return [Array<Symbol>]
                    end
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem)]
                end
              end

              class ItemReference < OpenAI::Internal::Type::BaseModel
                # @!attribute item_reference
                #   A reference to a variable in the `item` namespace. Ie, "item.name"
                #
                #   @return [String]
                required :item_reference, String

                # @!attribute type
                #   The type of input messages. Always `item_reference`.
                #
                #   @return [Symbol, :item_reference]
                required :type, const: :item_reference

                # @!method initialize(item_reference:, type: :item_reference)
                #   @param item_reference [String] A reference to a variable in the `item` namespace. Ie, "item.name"
                #
                #   @param type [Symbol, :item_reference] The type of input messages. Always `item_reference`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference)]
            end

            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#sampling_params
            class SamplingParams < OpenAI::Internal::Type::BaseModel
              # @!attribute max_completion_tokens
              #   The maximum number of tokens in the generated output.
              #
              #   @return [Integer, nil]
              optional :max_completion_tokens, Integer

              # @!attribute seed
              #   A seed value to initialize the randomness, during sampling.
              #
              #   @return [Integer, nil]
              optional :seed, Integer

              # @!attribute temperature
              #   A higher temperature increases randomness in the outputs.
              #
              #   @return [Float, nil]
              optional :temperature, Float

              # @!attribute text
              #   Configuration options for a text response from the model. Can be plain text or
              #   structured JSON data. Learn more:
              #
              #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
              #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
              #
              #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text, nil]
              optional :text,
                       -> {
                         OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text
                       }

              # @!attribute tools
              #   An array of tools the model may call while generating a response. You can
              #   specify which tool to use by setting the `tool_choice` parameter.
              #
              #   The two categories of tools you can provide the model are:
              #
              #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
              #     capabilities, like
              #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
              #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
              #     Learn more about
              #     [built-in tools](https://platform.openai.com/docs/guides/tools).
              #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
              #     the model to call your own code. Learn more about
              #     [function calling](https://platform.openai.com/docs/guides/function-calling).
              #
              #   @return [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::WebSearchTool>, nil]
              optional :tools, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::Tool] }

              # @!attribute top_p
              #   An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
              #
              #   @return [Float, nil]
              optional :top_p, Float

              # @!method initialize(max_completion_tokens: nil, seed: nil, temperature: nil, text: nil, tools: nil, top_p: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams}
              #   for more details.
              #
              #   @param max_completion_tokens [Integer] The maximum number of tokens in the generated output.
              #
              #   @param seed [Integer] A seed value to initialize the randomness, during sampling.
              #
              #   @param temperature [Float] A higher temperature increases randomness in the outputs.
              #
              #   @param text [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text] Configuration options for a text response from the model. Can be plain
              #
              #   @param tools [Array<OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::WebSearchTool>] An array of tools the model may call while generating a response. You
              #
              #   @param top_p [Float] An alternative to temperature for nucleus sampling; 1.0 includes all tokens.

              # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams#text
              class Text < OpenAI::Internal::Type::BaseModel
                # @!attribute format_
                #   An object specifying the format that the model must output.
                #
                #   Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
                #   ensures the model will match your supplied JSON schema. Learn more in the
                #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
                #
                #   The default format is `{ "type": "text" }` with no additional options.
                #
                #   **Not recommended for gpt-4o and newer models:**
                #
                #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
                #   ensures the message the model generates is valid JSON. Using `json_schema` is
                #   preferred for models that support it.
                #
                #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject, nil]
                optional :format_,
                         union: -> {
                           OpenAI::Responses::ResponseFormatTextConfig
                         },
                         api_name: :format

                # @!method initialize(format_: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text}
                #   for more details.
                #
                #   Configuration options for a text response from the model. Can be plain text or
                #   structured JSON data. Learn more:
                #
                #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
                #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
                #
                #   @param format_ [OpenAI::Models::ResponseFormatText, OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
              end
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource)]
        end
      end
    end
  end
end

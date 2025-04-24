# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#cancel
      class RunCancelResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the evaluation run.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) when the evaluation run was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute data_source
        #   Information about the run's data source.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions]
        required :data_source, union: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource }

        # @!attribute error
        #   An object representing an error response from the Eval API.
        #
        #   @return [OpenAI::Models::Evals::EvalAPIError]
        required :error, -> { OpenAI::Models::Evals::EvalAPIError }

        # @!attribute eval_id
        #   The identifier of the associated evaluation.
        #
        #   @return [String]
        required :eval_id, String

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

        # @!attribute model
        #   The model that is evaluated, if applicable.
        #
        #   @return [String]
        required :model, String

        # @!attribute name
        #   The name of the evaluation run.
        #
        #   @return [String]
        required :name, String

        # @!attribute object
        #   The type of the object. Always "eval.run".
        #
        #   @return [Symbol, :"eval.run"]
        required :object, const: :"eval.run"

        # @!attribute per_model_usage
        #   Usage statistics for each model during the evaluation run.
        #
        #   @return [Array<OpenAI::Models::Evals::RunCancelResponse::PerModelUsage>]
        required :per_model_usage,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCancelResponse::PerModelUsage] }

        # @!attribute per_testing_criteria_results
        #   Results per testing criteria applied during the evaluation run.
        #
        #   @return [Array<OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult>]
        required :per_testing_criteria_results,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult] }

        # @!attribute report_url
        #   The URL to the rendered evaluation run report on the UI dashboard.
        #
        #   @return [String]
        required :report_url, String

        # @!attribute result_counts
        #   Counters summarizing the outcomes of the evaluation run.
        #
        #   @return [OpenAI::Models::Evals::RunCancelResponse::ResultCounts]
        required :result_counts, -> { OpenAI::Models::Evals::RunCancelResponse::ResultCounts }

        # @!attribute status
        #   The status of the evaluation run.
        #
        #   @return [String]
        required :status, String

        # @!method initialize(id:, created_at:, data_source:, error:, eval_id:, metadata:, model:, name:, per_model_usage:, per_testing_criteria_results:, report_url:, result_counts:, status:, object: :"eval.run")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::RunCancelResponse} for more details.
        #
        #   A schema representing an evaluation run.
        #
        #   @param id [String] Unique identifier for the evaluation run.
        #
        #   @param created_at [Integer] Unix timestamp (in seconds) when the evaluation run was created.
        #
        #   @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions] Information about the run's data source.
        #
        #   @param error [OpenAI::Models::Evals::EvalAPIError] An object representing an error response from the Eval API. ...
        #
        #   @param eval_id [String] The identifier of the associated evaluation.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        #   @param model [String] The model that is evaluated, if applicable.
        #
        #   @param name [String] The name of the evaluation run.
        #
        #   @param per_model_usage [Array<OpenAI::Models::Evals::RunCancelResponse::PerModelUsage>] Usage statistics for each model during the evaluation run.
        #
        #   @param per_testing_criteria_results [Array<OpenAI::Models::Evals::RunCancelResponse::PerTestingCriteriaResult>] Results per testing criteria applied during the evaluation run.
        #
        #   @param report_url [String] The URL to the rendered evaluation run report on the UI dashboard.
        #
        #   @param result_counts [OpenAI::Models::Evals::RunCancelResponse::ResultCounts] Counters summarizing the outcomes of the evaluation run.
        #
        #   @param status [String] The status of the evaluation run.
        #
        #   @param object [Symbol, :"eval.run"] The type of the object. Always "eval.run".

        # Information about the run's data source.
        #
        # @see OpenAI::Models::Evals::RunCancelResponse#data_source
        module DataSource
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant :jsonl, -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant :completions, -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource }

          # A ResponsesRunDataSource object describing a model sampling configuration.
          variant :completions, -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions }

          class Completions < OpenAI::Internal::Type::BaseModel
            # @!attribute source
            #   A EvalResponsesSource object describing a run data source configuration.
            #
            #   @return [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileID, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::Responses]
            required :source, union: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source }

            # @!attribute type
            #   The type of run data source. Always `completions`.
            #
            #   @return [Symbol, :completions]
            required :type, const: :completions

            # @!attribute input_messages
            #
            #   @return [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::ItemReference, nil]
            optional :input_messages,
                     union: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages }

            # @!attribute model
            #   The name of the model to use for generating completions (e.g. "o3-mini").
            #
            #   @return [String, nil]
            optional :model, String

            # @!attribute sampling_params
            #
            #   @return [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::SamplingParams, nil]
            optional :sampling_params,
                     -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::SamplingParams }

            # @!method initialize(source:, input_messages: nil, model: nil, sampling_params: nil, type: :completions)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions} for more
            #   details.
            #
            #   A ResponsesRunDataSource object describing a model sampling configuration.
            #
            #   @param source [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileID, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::Responses] A EvalResponsesSource object describing a run data source configuration. ...
            #
            #   @param input_messages [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::ItemReference]
            #
            #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
            #
            #   @param sampling_params [OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::SamplingParams]
            #
            #   @param type [Symbol, :completions] The type of run data source. Always `completions`.

            # A EvalResponsesSource object describing a run data source configuration.
            #
            # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions#source
            module Source
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :file_content,
                      -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent }

              variant :file_id, -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileID }

              # A EvalResponsesSource object describing a run data source configuration.
              variant :responses,
                      -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::Responses }

              class FileContent < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   The content of the jsonl file.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent::Content>]
                required :content,
                         -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent::Content] }

                # @!attribute type
                #   The type of jsonl source. Always `file_content`.
                #
                #   @return [Symbol, :file_content]
                required :type, const: :file_content

                # @!method initialize(content:, type: :file_content)
                #   @param content [Array<OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent::Content>] The content of the jsonl file.
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

                # @!attribute allow_parallel_tool_calls
                #   Whether to allow parallel tool calls. This is a query parameter used to select
                #   responses.
                #
                #   @return [Boolean, nil]
                optional :allow_parallel_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

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

                # @!attribute has_tool_calls
                #   Whether the response has tool calls. This is a query parameter used to select
                #   responses.
                #
                #   @return [Boolean, nil]
                optional :has_tool_calls, OpenAI::Internal::Type::Boolean, nil?: true

                # @!attribute instructions_search
                #   Optional search string for instructions. This is a query parameter used to
                #   select responses.
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
                optional :reasoning_effort, enum: -> { OpenAI::Models::ReasoningEffort }, nil?: true

                # @!attribute temperature
                #   Sampling temperature. This is a query parameter used to select responses.
                #
                #   @return [Float, nil]
                optional :temperature, Float, nil?: true

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

                # @!method initialize(allow_parallel_tool_calls: nil, created_after: nil, created_before: nil, has_tool_calls: nil, instructions_search: nil, metadata: nil, model: nil, reasoning_effort: nil, temperature: nil, top_p: nil, users: nil, type: :responses)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::Responses}
                #   for more details.
                #
                #   A EvalResponsesSource object describing a run data source configuration.
                #
                #   @param allow_parallel_tool_calls [Boolean, nil] Whether to allow parallel tool calls. This is a query parameter used to select r
                #   ...
                #
                #   @param created_after [Integer, nil] Only include items created after this timestamp (inclusive). This is a query par
                #   ...
                #
                #   @param created_before [Integer, nil] Only include items created before this timestamp (inclusive). This is a query pa
                #   ...
                #
                #   @param has_tool_calls [Boolean, nil] Whether the response has tool calls. This is a query parameter used to select re
                #   ...
                #
                #   @param instructions_search [String, nil] Optional search string for instructions. This is a query parameter used to selec
                #   ...
                #
                #   @param metadata [Object, nil] Metadata filter for the responses. This is a query parameter used to select resp
                #   ...
                #
                #   @param model [String, nil] The name of the model to find responses for. This is a query parameter used to s
                #   ...
                #
                #   @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] Optional reasoning effort parameter. This is a query parameter used to select re
                #   ...
                #
                #   @param temperature [Float, nil] Sampling temperature. This is a query parameter used to select responses.
                #
                #   @param top_p [Float, nil] Nucleus sampling parameter. This is a query parameter used to select responses.
                #
                #   @param users [Array<String>, nil] List of user identifiers. This is a query parameter used to select responses.
                #
                #   @param type [Symbol, :responses] The type of run data source. Always `responses`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileContent, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::FileID, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::Source::Responses)]
            end

            # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions#input_messages
            module InputMessages
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :template,
                      -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template }

              variant :item_reference,
                      -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::ItemReference }

              class Template < OpenAI::Internal::Type::BaseModel
                # @!attribute template
                #   A list of chat messages forming the prompt or context. May include variable
                #   references to the "item" namespace, ie {{item.name}}.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem>]
                required :template,
                         -> do
                           OpenAI::Internal::Type::ArrayOf[
                             union: OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template
                           ]
                         end

                # @!attribute type
                #   The type of input messages. Always `template`.
                #
                #   @return [Symbol, :template]
                required :type, const: :template

                # @!method initialize(template:, type: :template)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template}
                #   for more details.
                #
                #   @param template [Array<OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
                #   ...
                #
                #   @param type [Symbol, :template] The type of input messages. Always `template`.

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                module Template
                  extend OpenAI::Internal::Type::Union

                  variant -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage }

                  # A message input to the model with a role indicating instruction following
                  # hierarchy. Instructions given with the `developer` or `system` role take
                  # precedence over instructions given with the `user` role. Messages with the
                  # `assistant` role are presumed to have been generated by the model in previous
                  # interactions.
                  variant -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem }

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
                    #   Text inputs to the model - can contain template strings.
                    #
                    #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText]
                    required :content,
                             union: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content }

                    # @!attribute role
                    #   The role of the message input. One of `user`, `assistant`, `system`, or
                    #   `developer`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role]
                    required :role,
                             enum: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role }

                    # @!attribute type
                    #   The type of the message input. Always `message`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type, nil]
                    optional :type,
                             enum: -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type }

                    # @!method initialize(content:, role:, type: nil)
                    #   Some parameter documentations has been truncated, see
                    #   {OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem}
                    #   for more details.
                    #
                    #   A message input to the model with a role indicating instruction following
                    #   hierarchy. Instructions given with the `developer` or `system` role take
                    #   precedence over instructions given with the `user` role. Messages with the
                    #   `assistant` role are presumed to have been generated by the model in previous
                    #   interactions.
                    #
                    #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText] Text inputs to the model - can contain template strings. ...
                    #
                    #   @param role [Symbol, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role] The role of the message input. One of `user`, `assistant`, `system`, or ...
                    #
                    #   @param type [Symbol, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type] The type of the message input. Always `message`. ...

                    # Text inputs to the model - can contain template strings.
                    #
                    # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem#content
                    module Content
                      extend OpenAI::Internal::Type::Union

                      # A text input to the model.
                      variant String

                      # A text input to the model.
                      variant -> { OpenAI::Models::Responses::ResponseInputText }

                      # A text output from the model.
                      variant -> { OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText }

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
                        #   {OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText}
                        #   for more details.
                        #
                        #   A text output from the model.
                        #
                        #   @param text [String] The text output from the model. ...
                        #
                        #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`. ...
                      end

                      # @!method self.variants
                      #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText)]
                    end

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    #
                    # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem#role
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
                    # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem#type
                    module Type
                      extend OpenAI::Internal::Type::Enum

                      MESSAGE = :message

                      # @!method self.values
                      #   @return [Array<Symbol>]
                    end
                  end

                  # @!method self.variants
                  #   @return [Array(OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem)]
                end
              end

              class ItemReference < OpenAI::Internal::Type::BaseModel
                # @!attribute item_reference
                #   A reference to a variable in the "item" namespace. Ie, "item.name"
                #
                #   @return [String]
                required :item_reference, String

                # @!attribute type
                #   The type of input messages. Always `item_reference`.
                #
                #   @return [Symbol, :item_reference]
                required :type, const: :item_reference

                # @!method initialize(item_reference:, type: :item_reference)
                #   @param item_reference [String] A reference to a variable in the "item" namespace. Ie, "item.name"
                #
                #   @param type [Symbol, :item_reference] The type of input messages. Always `item_reference`.
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::Template, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions::InputMessages::ItemReference)]
            end

            # @see OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions#sampling_params
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

              # @!attribute top_p
              #   An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
              #
              #   @return [Float, nil]
              optional :top_p, Float

              # @!method initialize(max_completion_tokens: nil, seed: nil, temperature: nil, top_p: nil)
              #   @param max_completion_tokens [Integer] The maximum number of tokens in the generated output.
              #
              #   @param seed [Integer] A seed value to initialize the randomness, during sampling.
              #
              #   @param temperature [Float] A higher temperature increases randomness in the outputs.
              #
              #   @param top_p [Float] An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCancelResponse::DataSource::Completions)]
        end

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
          # @!attribute cached_tokens
          #   The number of tokens retrieved from cache.
          #
          #   @return [Integer]
          required :cached_tokens, Integer

          # @!attribute completion_tokens
          #   The number of completion tokens generated.
          #
          #   @return [Integer]
          required :completion_tokens, Integer

          # @!attribute invocation_count
          #   The number of invocations.
          #
          #   @return [Integer]
          required :invocation_count, Integer

          # @!attribute model_name
          #   The name of the model.
          #
          #   @return [String]
          required :model_name, String

          # @!attribute prompt_tokens
          #   The number of prompt tokens used.
          #
          #   @return [Integer]
          required :prompt_tokens, Integer

          # @!attribute total_tokens
          #   The total number of tokens used.
          #
          #   @return [Integer]
          required :total_tokens, Integer

          # @!method initialize(cached_tokens:, completion_tokens:, invocation_count:, model_name:, prompt_tokens:, total_tokens:)
          #   @param cached_tokens [Integer] The number of tokens retrieved from cache.
          #
          #   @param completion_tokens [Integer] The number of completion tokens generated.
          #
          #   @param invocation_count [Integer] The number of invocations.
          #
          #   @param model_name [String] The name of the model.
          #
          #   @param prompt_tokens [Integer] The number of prompt tokens used.
          #
          #   @param total_tokens [Integer] The total number of tokens used.
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          # @!attribute failed
          #   Number of tests failed for this criteria.
          #
          #   @return [Integer]
          required :failed, Integer

          # @!attribute passed
          #   Number of tests passed for this criteria.
          #
          #   @return [Integer]
          required :passed, Integer

          # @!attribute testing_criteria
          #   A description of the testing criteria.
          #
          #   @return [String]
          required :testing_criteria, String

          # @!method initialize(failed:, passed:, testing_criteria:)
          #   @param failed [Integer] Number of tests failed for this criteria.
          #
          #   @param passed [Integer] Number of tests passed for this criteria.
          #
          #   @param testing_criteria [String] A description of the testing criteria.
        end

        # @see OpenAI::Models::Evals::RunCancelResponse#result_counts
        class ResultCounts < OpenAI::Internal::Type::BaseModel
          # @!attribute errored
          #   Number of output items that resulted in an error.
          #
          #   @return [Integer]
          required :errored, Integer

          # @!attribute failed
          #   Number of output items that failed to pass the evaluation.
          #
          #   @return [Integer]
          required :failed, Integer

          # @!attribute passed
          #   Number of output items that passed the evaluation.
          #
          #   @return [Integer]
          required :passed, Integer

          # @!attribute total
          #   Total number of executed output items.
          #
          #   @return [Integer]
          required :total, Integer

          # @!method initialize(errored:, failed:, passed:, total:)
          #   Counters summarizing the outcomes of the evaluation run.
          #
          #   @param errored [Integer] Number of output items that resulted in an error.
          #
          #   @param failed [Integer] Number of output items that failed to pass the evaluation.
          #
          #   @param passed [Integer] Number of output items that passed the evaluation.
          #
          #   @param total [Integer] Total number of executed output items.
        end
      end
    end
  end
end

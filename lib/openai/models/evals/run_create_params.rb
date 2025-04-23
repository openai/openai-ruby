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
        required :data_source, union: -> { OpenAI::Models::Evals::RunCreateParams::DataSource }

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
        #   @param data_source [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource]
        #   @param metadata [Hash{Symbol=>String}, nil]
        #   @param name [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          # A JsonlRunDataSource object with that specifies a JSONL file that matches the eval
          variant -> { OpenAI::Models::Evals::CreateEvalJSONLRunDataSource }

          # A CompletionsRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource }

          # A ResponsesRunDataSource object describing a model sampling configuration.
          variant -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource }

          class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
            # @!attribute source
            #   A EvalResponsesSource object describing a run data source configuration.
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses]
            required :source,
                     union: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source }

            # @!attribute type
            #   The type of run data source. Always `completions`.
            #
            #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type]
            required :type,
                     enum: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type }

            # @!attribute input_messages
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference, nil]
            optional :input_messages,
                     union: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages }

            # @!attribute model
            #   The name of the model to use for generating completions (e.g. "o3-mini").
            #
            #   @return [String, nil]
            optional :model, String

            # @!attribute sampling_params
            #
            #   @return [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams, nil]
            optional :sampling_params,
                     -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams }

            # @!method initialize(source:, type:, input_messages: nil, model: nil, sampling_params: nil)
            #   A ResponsesRunDataSource object describing a model sampling configuration.
            #
            #   @param source [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses]
            #   @param type [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type]
            #   @param input_messages [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference]
            #   @param model [String]
            #   @param sampling_params [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams]

            # A EvalResponsesSource object describing a run data source configuration.
            #
            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#source
            module Source
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :file_content,
                      -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent }

              variant :file_id,
                      -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID }

              # A EvalResponsesSource object describing a run data source configuration.
              variant :responses,
                      -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses }

              class FileContent < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   The content of the jsonl file.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content>]
                required :content,
                         -> do
                           OpenAI::Internal::Type::ArrayOf[
                             OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content
                           ]
                         end

                # @!attribute type
                #   The type of jsonl source. Always `file_content`.
                #
                #   @return [Symbol, :file_content]
                required :type, const: :file_content

                # @!method initialize(content:, type: :file_content)
                #   @param content [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content>]
                #   @param type [Symbol, :file_content]

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
                #   @param id [String]
                #   @param type [Symbol, :file_id]
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
                #   A EvalResponsesSource object describing a run data source configuration.
                #
                #   @param allow_parallel_tool_calls [Boolean, nil]
                #   @param created_after [Integer, nil]
                #   @param created_before [Integer, nil]
                #   @param has_tool_calls [Boolean, nil]
                #   @param instructions_search [String, nil]
                #   @param metadata [Object, nil]
                #   @param model [String, nil]
                #   @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
                #   @param temperature [Float, nil]
                #   @param top_p [Float, nil]
                #   @param users [Array<String>, nil]
                #   @param type [Symbol, :responses]
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses)]
            end

            # The type of run data source. Always `completions`.
            #
            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#type
            module Type
              extend OpenAI::Internal::Type::Enum

              COMPLETIONS = :completions

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource#input_messages
            module InputMessages
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :template,
                      -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template }

              variant :item_reference,
                      -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference }

              class Template < OpenAI::Internal::Type::BaseModel
                # @!attribute template
                #   A list of chat messages forming the prompt or context. May include variable
                #   references to the "item" namespace, ie {{item.name}}.
                #
                #   @return [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem>]
                required :template,
                         -> do
                           OpenAI::Internal::Type::ArrayOf[
                             union: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template
                           ]
                         end

                # @!attribute type
                #   The type of input messages. Always `template`.
                #
                #   @return [Symbol, :template]
                required :type, const: :template

                # @!method initialize(template:, type: :template)
                #   @param template [Array<OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem>]
                #   @param type [Symbol, :template]

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                module Template
                  extend OpenAI::Internal::Type::Union

                  variant -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage }

                  # A message input to the model with a role indicating instruction following
                  # hierarchy. Instructions given with the `developer` or `system` role take
                  # precedence over instructions given with the `user` role. Messages with the
                  # `assistant` role are presumed to have been generated by the model in previous
                  # interactions.
                  variant -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem }

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
                    #   @param content [String]
                    #   @param role [String]
                  end

                  class EvalItem < OpenAI::Internal::Type::BaseModel
                    # @!attribute content
                    #   Text inputs to the model - can contain template strings.
                    #
                    #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText]
                    required :content,
                             union: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content }

                    # @!attribute role
                    #   The role of the message input. One of `user`, `assistant`, `system`, or
                    #   `developer`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role]
                    required :role,
                             enum: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role }

                    # @!attribute type
                    #   The type of the message input. Always `message`.
                    #
                    #   @return [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type, nil]
                    optional :type,
                             enum: -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type }

                    # @!method initialize(content:, role:, type: nil)
                    #   A message input to the model with a role indicating instruction following
                    #   hierarchy. Instructions given with the `developer` or `system` role take
                    #   precedence over instructions given with the `user` role. Messages with the
                    #   `assistant` role are presumed to have been generated by the model in previous
                    #   interactions.
                    #
                    #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText]
                    #   @param role [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role]
                    #   @param type [Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type]

                    # Text inputs to the model - can contain template strings.
                    #
                    # @see OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem#content
                    module Content
                      extend OpenAI::Internal::Type::Union

                      # A text input to the model.
                      variant String

                      # A text input to the model.
                      variant -> { OpenAI::Models::Responses::ResponseInputText }

                      # A text output from the model.
                      variant -> { OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText }

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
                      #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText)]
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
                #   @param item_reference [String]
                #   @param type [Symbol, :item_reference]
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

              # @!attribute top_p
              #   An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
              #
              #   @return [Float, nil]
              optional :top_p, Float

              # @!method initialize(max_completion_tokens: nil, seed: nil, temperature: nil, top_p: nil)
              #   @param max_completion_tokens [Integer]
              #   @param seed [Integer]
              #   @param temperature [Float]
              #   @param top_p [Float]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource)]
        end
      end
    end
  end
end

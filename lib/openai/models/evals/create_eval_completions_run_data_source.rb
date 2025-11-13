# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        # @!attribute source
        #   Determines what populates the `item` namespace in this run's data source.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
        required :source, union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source }

        # @!attribute type
        #   The type of run data source. Always `completions`.
        #
        #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type]
        required :type, enum: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Type }

        # @!attribute input_messages
        #   Used when sampling from a model. Dictates the structure of the messages passed
        #   into the model. Can either be a reference to a prebuilt trajectory (ie,
        #   `item.input_trajectory`), or a template with variable references to the `item`
        #   namespace.
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference, nil]
        optional :input_messages, union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages }

        # @!attribute model
        #   The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute sampling_params
        #
        #   @return [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams, nil]
        optional :sampling_params, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams }

        # @!method initialize(source:, type:, input_messages: nil, model: nil, sampling_params: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource} for more details.
        #
        #   A CompletionsRunDataSource object describing a model sampling configuration.
        #
        #   @param source [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions] Determines what populates the `item` namespace in this run's data source.
        #
        #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type] The type of run data source. Always `completions`.
        #
        #   @param input_messages [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference] Used when sampling from a model. Dictates the structure of the messages passed i
        #
        #   @param model [String] The name of the model to use for generating completions (e.g. "o3-mini").
        #
        #   @param sampling_params [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams]

        # Determines what populates the `item` namespace in this run's data source.
        #
        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#source
        module Source
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :file_content, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent }

          variant :file_id, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileID }

          # A StoredCompletionsRunDataSource configuration describing a set of filters
          variant :stored_completions,
                  -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions }

          class FileContent < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the jsonl file.
            #
            #   @return [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content] }

            # @!attribute type
            #   The type of jsonl source. Always `file_content`.
            #
            #   @return [Symbol, :file_content]
            required :type, const: :file_content

            # @!method initialize(content:, type: :file_content)
            #   @param content [Array<OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content>] The content of the jsonl file.
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

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of source. Always `stored_completions`.
            #
            #   @return [Symbol, :stored_completions]
            required :type, const: :stored_completions

            # @!attribute created_after
            #   An optional Unix timestamp to filter items created after this time.
            #
            #   @return [Integer, nil]
            optional :created_after, Integer, nil?: true

            # @!attribute created_before
            #   An optional Unix timestamp to filter items created before this time.
            #
            #   @return [Integer, nil]
            optional :created_before, Integer, nil?: true

            # @!attribute limit
            #   An optional maximum number of items to return.
            #
            #   @return [Integer, nil]
            optional :limit, Integer, nil?: true

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

            # @!attribute model
            #   An optional model to filter by (e.g., 'gpt-4o').
            #
            #   @return [String, nil]
            optional :model, String, nil?: true

            # @!method initialize(created_after: nil, created_before: nil, limit: nil, metadata: nil, model: nil, type: :stored_completions)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions}
            #   for more details.
            #
            #   A StoredCompletionsRunDataSource configuration describing a set of filters
            #
            #   @param created_after [Integer, nil] An optional Unix timestamp to filter items created after this time.
            #
            #   @param created_before [Integer, nil] An optional Unix timestamp to filter items created before this time.
            #
            #   @param limit [Integer, nil] An optional maximum number of items to return.
            #
            #   @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
            #
            #   @param model [String, nil] An optional model to filter by (e.g., 'gpt-4o').
            #
            #   @param type [Symbol, :stored_completions] The type of source. Always `stored_completions`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions)]
        end

        # The type of run data source. Always `completions`.
        #
        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPLETIONS = :completions

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Used when sampling from a model. Dictates the structure of the messages passed
        # into the model. Can either be a reference to a prebuilt trajectory (ie,
        # `item.input_trajectory`), or a template with variable references to the `item`
        # namespace.
        #
        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#input_messages
        module InputMessages
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :template, -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template }

          variant :item_reference,
                  -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference }

          class Template < OpenAI::Internal::Type::BaseModel
            # @!attribute template
            #   A list of chat messages forming the prompt or context. May include variable
            #   references to the `item` namespace, ie {{item.name}}.
            #
            #   @return [Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem>]
            required :template,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template] }

            # @!attribute type
            #   The type of input messages. Always `template`.
            #
            #   @return [Symbol, :template]
            required :type, const: :template

            # @!method initialize(template:, type: :template)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template}
            #   for more details.
            #
            #   @param template [Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem>] A list of chat messages forming the prompt or context. May include variable refe
            #
            #   @param type [Symbol, :template] The type of input messages. Always `template`.

            # A message input to the model with a role indicating instruction following
            # hierarchy. Instructions given with the `developer` or `system` role take
            # precedence over instructions given with the `user` role. Messages with the
            # `assistant` role are presumed to have been generated by the model in previous
            # interactions.
            module Template
              extend OpenAI::Internal::Type::Union

              # A message input to the model with a role indicating instruction following
              # hierarchy. Instructions given with the `developer` or `system` role take
              # precedence over instructions given with the `user` role. Messages with the
              # `assistant` role are presumed to have been generated by the model in previous
              # interactions.
              variant -> { OpenAI::Responses::EasyInputMessage }

              # A message input to the model with a role indicating instruction following
              # hierarchy. Instructions given with the `developer` or `system` role take
              # precedence over instructions given with the `user` role. Messages with the
              # `assistant` role are presumed to have been generated by the model in previous
              # interactions.
              variant -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem }

              class EvalItem < OpenAI::Internal::Type::BaseModel
                # @!attribute content
                #   Inputs to the model - can contain template strings.
                #
                #   @return [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, OpenAI::Models::Responses::ResponseInputAudio, Array<Object>]
                required :content,
                         union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content }

                # @!attribute role
                #   The role of the message input. One of `user`, `assistant`, `system`, or
                #   `developer`.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role]
                required :role,
                         enum: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role }

                # @!attribute type
                #   The type of the message input. Always `message`.
                #
                #   @return [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type, nil]
                optional :type,
                         enum: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type }

                # @!method initialize(content:, role:, type: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem}
                #   for more details.
                #
                #   A message input to the model with a role indicating instruction following
                #   hierarchy. Instructions given with the `developer` or `system` role take
                #   precedence over instructions given with the `user` role. Messages with the
                #   `assistant` role are presumed to have been generated by the model in previous
                #   interactions.
                #
                #   @param content [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, OpenAI::Models::Responses::ResponseInputAudio, Array<Object>] Inputs to the model - can contain template strings.
                #
                #   @param role [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Role] The role of the message input. One of `user`, `assistant`, `system`, or
                #
                #   @param type [Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Type] The type of the message input. Always `message`.

                # Inputs to the model - can contain template strings.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem#content
                module Content
                  extend OpenAI::Internal::Type::Union

                  # A text input to the model.
                  variant String

                  # A text input to the model.
                  variant -> { OpenAI::Responses::ResponseInputText }

                  # A text output from the model.
                  variant -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText }

                  # An image input to the model.
                  variant -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage }

                  # An audio input to the model.
                  variant -> { OpenAI::Responses::ResponseInputAudio }

                  # A list of inputs, each of which may be either an input text, input image, or input audio object.
                  variant -> { OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::AnArrayOfInputTextInputImageAndInputAudioArray }

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
                    #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText}
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
                    #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage}
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
                  #   @return [Array(String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage, OpenAI::Models::Responses::ResponseInputAudio, Array<Object>)]

                  # @type [OpenAI::Internal::Type::Converter]
                  AnArrayOfInputTextInputImageAndInputAudioArray =
                    OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::Unknown]
                end

                # The role of the message input. One of `user`, `assistant`, `system`, or
                # `developer`.
                #
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem#role
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
                # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  MESSAGE = :message

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::EvalItem)]
            end
          end

          class ItemReference < OpenAI::Internal::Type::BaseModel
            # @!attribute item_reference
            #   A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
            #
            #   @return [String]
            required :item_reference, String

            # @!attribute type
            #   The type of input messages. Always `item_reference`.
            #
            #   @return [Symbol, :item_reference]
            required :type, const: :item_reference

            # @!method initialize(item_reference:, type: :item_reference)
            #   @param item_reference [String] A reference to a variable in the `item` namespace. Ie, "item.input_trajectory"
            #
            #   @param type [Symbol, :item_reference] The type of input messages. Always `item_reference`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference)]
        end

        # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource#sampling_params
        class SamplingParams < OpenAI::Internal::Type::BaseModel
          # @!attribute max_completion_tokens
          #   The maximum number of tokens in the generated output.
          #
          #   @return [Integer, nil]
          optional :max_completion_tokens, Integer

          # @!attribute reasoning_effort
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `none`, `minimal`, `low`, `medium`, and `high`. Reducing
          #   reasoning effort can result in faster responses and fewer tokens used on
          #   reasoning in a response.
          #
          #   - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
          #     reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
          #     calls are supported for all reasoning values in gpt-5.1.
          #   - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
          #     support `none`.
          #   - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
          #
          #   @return [Symbol, OpenAI::Models::ReasoningEffort, nil]
          optional :reasoning_effort, enum: -> { OpenAI::ReasoningEffort }, nil?: true

          # @!attribute response_format
          #   An object specifying the format that the model must output.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          #   ensures the message the model generates is valid JSON. Using `json_schema` is
          #   preferred for models that support it.
          #
          #   @return [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject, nil]
          optional :response_format,
                   union: -> { OpenAI::Evals::CreateEvalCompletionsRunDataSource::SamplingParams::ResponseFormat }

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

          # @!attribute tools
          #   A list of tools the model may call. Currently, only functions are supported as a
          #   tool. Use this to provide a list of functions the model may generate JSON inputs
          #   for. A max of 128 functions are supported.
          #
          #   @return [Array<OpenAI::Models::Chat::ChatCompletionFunctionTool>, nil]
          optional :tools, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionFunctionTool] }

          # @!attribute top_p
          #   An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
          #
          #   @return [Float, nil]
          optional :top_p, Float

          # @!method initialize(max_completion_tokens: nil, reasoning_effort: nil, response_format: nil, seed: nil, temperature: nil, tools: nil, top_p: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams} for
          #   more details.
          #
          #   @param max_completion_tokens [Integer] The maximum number of tokens in the generated output.
          #
          #   @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] Constrains effort on reasoning for
          #
          #   @param response_format [OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject] An object specifying the format that the model must output.
          #
          #   @param seed [Integer] A seed value to initialize the randomness, during sampling.
          #
          #   @param temperature [Float] A higher temperature increases randomness in the outputs.
          #
          #   @param tools [Array<OpenAI::Models::Chat::ChatCompletionFunctionTool>] A list of tools the model may call. Currently, only functions are supported as a
          #
          #   @param top_p [Float] An alternative to temperature for nucleus sampling; 1.0 includes all tokens.

          # An object specifying the format that the model must output.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
          # ensures the message the model generates is valid JSON. Using `json_schema` is
          # preferred for models that support it.
          #
          # @see OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams#response_format
          module ResponseFormat
            extend OpenAI::Internal::Type::Union

            # Default response format. Used to generate text responses.
            variant -> { OpenAI::ResponseFormatText }

            # JSON Schema response format. Used to generate structured JSON responses.
            # Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
            variant -> { OpenAI::ResponseFormatJSONSchema }

            # JSON object response format. An older method of generating JSON responses.
            # Using `json_schema` is recommended for models that support it. Note that the
            # model will not generate JSON without a system or user message instructing it
            # to do so.
            variant -> { OpenAI::ResponseFormatJSONObject }

            # @!method self.variants
            #   @return [Array(OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONSchema, OpenAI::Models::ResponseFormatJSONObject)]
          end
        end
      end
    end
  end
end

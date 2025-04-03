# typed: strong

module OpenAI
  module Resources
    class Beta
      class Assistants
        # Create an assistant with a model and instructions.
        sig do
          params(
            model: T.any(String, OpenAI::Models::ChatModel::OrSymbol),
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: T.nilable(String),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Internal::Util::AnyHash,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(
              T.any(OpenAI::Models::Beta::AssistantCreateParams::ToolResources, OpenAI::Internal::Util::AnyHash)
            ),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Internal::Util::AnyHash,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def create(
          # ID of the model to use. You can use the
          #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
          #   see all of your available models, or see our
          #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
          #   them.
          model:,
          # The description of the assistant. The maximum length is 512 characters.
          description: nil,
          # The system instructions that the assistant uses. The maximum length is 256,000
          #   characters.
          instructions: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # The name of the assistant. The maximum length is 256 characters.
          name: nil,
          # **o-series models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          reasoning_effort: nil,
          # Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #   [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #   and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #   message the model generates is valid JSON.
          #
          #   **Important:** when using JSON mode, you **must** also instruct the model to
          #   produce JSON yourself via a system or user message. Without this, the model may
          #   generate an unending stream of whitespace until the generation reaches the token
          #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #   the message content may be partially cut off if `finish_reason="length"`, which
          #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #   max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic.
          temperature: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          tool_resources: nil,
          # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
          #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
          #   `function`.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or temperature but not both.
          top_p: nil,
          request_options: {}
        )
        end

        # Retrieves an assistant.
        sig do
          params(
            assistant_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def retrieve(
          # The ID of the assistant to retrieve.
          assistant_id,
          request_options: {}
        )
        end

        # Modifies an assistant.
        sig do
          params(
            assistant_id: String,
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol),
            name: T.nilable(String),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Internal::Util::AnyHash,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(
              T.any(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, OpenAI::Internal::Util::AnyHash)
            ),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Internal::Util::AnyHash,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
          )
            .returns(OpenAI::Models::Beta::Assistant)
        end
        def update(
          # The ID of the assistant to modify.
          assistant_id,
          # The description of the assistant. The maximum length is 512 characters.
          description: nil,
          # The system instructions that the assistant uses. The maximum length is 256,000
          #   characters.
          instructions: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          metadata: nil,
          # ID of the model to use. You can use the
          #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
          #   see all of your available models, or see our
          #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
          #   them.
          model: nil,
          # The name of the assistant. The maximum length is 256 characters.
          name: nil,
          # **o-series models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          reasoning_effort: nil,
          # Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #   [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #   and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #   message the model generates is valid JSON.
          #
          #   **Important:** when using JSON mode, you **must** also instruct the model to
          #   produce JSON yourself via a system or user message. Without this, the model may
          #   generate an unending stream of whitespace until the generation reaches the token
          #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #   the message content may be partially cut off if `finish_reason="length"`, which
          #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #   max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic.
          temperature: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          tool_resources: nil,
          # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
          #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
          #   `function`.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or temperature but not both.
          top_p: nil,
          request_options: {}
        )
        end

        # Returns a list of assistants.
        sig do
          params(
            after: String,
            before: String,
            limit: Integer,
            order: OpenAI::Models::Beta::AssistantListParams::Order::OrSymbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
          )
            .returns(OpenAI::Internal::CursorPage[OpenAI::Models::Beta::Assistant])
        end
        def list(
          # A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          after: nil,
          # A cursor for use in pagination. `before` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   starting with obj_foo, your subsequent call can include before=obj_foo in order
          #   to fetch the previous page of the list.
          before: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          limit: nil,
          # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
          #   order and `desc` for descending order.
          order: nil,
          request_options: {}
        )
        end

        # Delete an assistant.
        sig do
          params(
            assistant_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash))
          )
            .returns(OpenAI::Models::Beta::AssistantDeleted)
        end
        def delete(
          # The ID of the assistant to delete.
          assistant_id,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end

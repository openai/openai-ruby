# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # Build Assistants that can call models and use tools.
      class Assistants
        # @deprecated
        #
        # Create an assistant with a model and instructions.
        #
        # @overload create(model:, description: nil, instructions: nil, metadata: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        #   ID of the model to use. You can use the
        #   [List models](https://developers.openai.com/api/reference/resources/models/methods/list)
        #   API to see all of your available models, or see our
        #   [Model overview](https://developers.openai.com/api/docs/models) for descriptions
        #   of them.
        #
        # @param description [String, nil]
        #   The description of the assistant. The maximum length is 512 characters.
        #
        # @param instructions [String, nil]
        #   The system instructions that the assistant uses. The maximum length is 256,000
        #   characters.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param name [String, nil]
        #   The name of the assistant. The maximum length is 256 characters.
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   Constrains effort on reasoning for reasoning models. Currently supported values
        #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
        #   reasoning effort can result in faster responses and fewer tokens used on
        #   reasoning in a response. Not all reasoning models support every value. See the
        #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
        #   model-specific support.
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   Specifies the format that the model must output. Compatible with
        #   [GPT-4o](https://developers.openai.com/api/docs/models/gpt-4o),
        #   [GPT-4 Turbo](https://developers.openai.com/api/docs/models/gpt-4-turbo), and
        #   all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #   Outputs which ensures the model will match your supplied JSON schema. Learn more
        #   in the
        #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
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
        #
        # @param temperature [Float, nil]
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        # @param tool_resources [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil]
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #   `function`.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        # @see OpenAI::Models::Beta::AssistantCreateParams
        def create(params)
          parsed, options = OpenAI::Beta::AssistantCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "assistants",
            body: parsed,
            model: OpenAI::Beta::Assistant,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated
        #
        # Retrieves an assistant.
        #
        # @overload retrieve(assistant_id, request_options: {})
        #
        # @param assistant_id [String]
        #   The ID of the assistant to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        # @see OpenAI::Models::Beta::AssistantRetrieveParams
        def retrieve(assistant_id, params = {})
          @client.request(
            method: :get,
            path: ["assistants/%1$s", assistant_id],
            model: OpenAI::Beta::Assistant,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # @deprecated
        #
        # Modifies an assistant.
        #
        # @overload update(assistant_id, description: nil, instructions: nil, metadata: nil, model: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param assistant_id [String]
        #   The ID of the assistant to modify.
        #
        # @param description [String, nil]
        #   The description of the assistant. The maximum length is 512 characters.
        #
        # @param instructions [String, nil]
        #   The system instructions that the assistant uses. The maximum length is 256,000
        #   characters.
        #
        # @param metadata [Hash{Symbol=>String}, nil]
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        # @param model [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model]
        #   ID of the model to use. You can use the
        #   [List models](https://developers.openai.com/api/reference/resources/models/methods/list)
        #   API to see all of your available models, or see our
        #   [Model overview](https://developers.openai.com/api/docs/models) for descriptions
        #   of them.
        #
        # @param name [String, nil]
        #   The name of the assistant. The maximum length is 256 characters.
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        #   Constrains effort on reasoning for reasoning models. Currently supported values
        #   are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
        #   reasoning effort can result in faster responses and fewer tokens used on
        #   reasoning in a response. Not all reasoning models support every value. See the
        #   [reasoning guide](https://developers.openai.com/api/docs/guides/reasoning) for
        #   model-specific support.
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        #   Specifies the format that the model must output. Compatible with
        #   [GPT-4o](https://developers.openai.com/api/docs/models/gpt-4o),
        #   [GPT-4 Turbo](https://developers.openai.com/api/docs/models/gpt-4-turbo), and
        #   all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #   Outputs which ensures the model will match your supplied JSON schema. Learn more
        #   in the
        #   [Structured Outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs).
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
        #
        # @param temperature [Float, nil]
        #   What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        #
        # @param tool_resources [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil]
        #   A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        #   A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #   `function`.
        #
        # @param top_p [Float, nil]
        #   An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        # @see OpenAI::Models::Beta::AssistantUpdateParams
        def update(assistant_id, params = {})
          parsed, options = OpenAI::Beta::AssistantUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["assistants/%1$s", assistant_id],
            body: parsed,
            model: OpenAI::Beta::Assistant,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated
        #
        # Returns a list of assistants.
        #
        # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
        #
        # @param after [String]
        #   A cursor for use in pagination. `after` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #   fetch the next page of the list.
        #
        # @param before [String]
        #   A cursor for use in pagination. `before` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   starting with obj_foo, your subsequent call can include before=obj_foo in order
        #   to fetch the previous page of the list.
        #
        # @param limit [Integer]
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        # @param order [Symbol, OpenAI::Models::Beta::AssistantListParams::Order]
        #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Assistant>]
        #
        # @see OpenAI::Models::Beta::AssistantListParams
        def list(params = {})
          parsed, options = OpenAI::Beta::AssistantListParams.dump_request(params)
          query = OpenAI::Internal::Util.encode_query_params(parsed)
          @client.request(
            method: :get,
            path: "assistants",
            query: query,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Beta::Assistant,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **options}
          )
        end

        # @deprecated
        #
        # Delete an assistant.
        #
        # @overload delete(assistant_id, request_options: {})
        #
        # @param assistant_id [String]
        #   The ID of the assistant to delete.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::AssistantDeleted]
        #
        # @see OpenAI::Models::Beta::AssistantDeleteParams
        def delete(assistant_id, params = {})
          @client.request(
            method: :delete,
            path: ["assistants/%1$s", assistant_id],
            model: OpenAI::Beta::AssistantDeleted,
            security: {bearer_auth: true},
            options: {extra_headers: {"OpenAI-Beta" => "assistants=v2"}, **params[:request_options].to_h}
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end

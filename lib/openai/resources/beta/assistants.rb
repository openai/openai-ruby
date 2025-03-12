# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Assistants
        # Create an assistant with a model and instructions.
        #
        # @param params [OpenAI::Models::Beta::AssistantCreateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String, Symbol, OpenAI::Models::ChatModel] :model ID of the model to use. You can use the
        #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #     see all of your available models, or see our
        #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #     them.
        #
        #   @option params [String, nil] :description The description of the assistant. The maximum length is 512 characters.
        #
        #   @option params [String, nil] :instructions The system instructions that the assistant uses. The maximum length is 256,000
        #     characters.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String, nil] :name The name of the assistant. The maximum length is 256 characters.
        #
        #   @option params [Symbol, OpenAI::Models::ReasoningEffort, nil] :reasoning_effort **o-series models only**
        #
        #     Constrains effort on reasoning for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #     result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Specifies the format that the model must output. Compatible with
        #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #     Outputs which ensures the model will match your supplied JSON schema. Learn more
        #     in the
        #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #     message the model generates is valid JSON.
        #
        #     **Important:** when using JSON mode, you **must** also instruct the model to
        #     produce JSON yourself via a system or user message. Without this, the model may
        #     generate an unending stream of whitespace until the generation reaches the token
        #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #     the message content may be partially cut off if `finish_reason="length"`, which
        #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #     max context length.
        #
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic.
        #
        #   @option params [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil] :tool_resources A set of resources that are used by the assistant's tools. The resources are
        #     specific to the type of tool. For example, the `code_interpreter` tool requires
        #     a list of file IDs, while the `file_search` tool requires a list of vector store
        #     IDs.
        #
        #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>] :tools A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #     assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #     `function`.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or temperature but not both.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        def create(params)
          parsed, options = OpenAI::Models::Beta::AssistantCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "assistants",
            body: parsed,
            model: OpenAI::Models::Beta::Assistant,
            options: options
          )
        end

        # Retrieves an assistant.
        #
        # @param assistant_id [String] The ID of the assistant to retrieve.
        #
        # @param params [OpenAI::Models::Beta::AssistantRetrieveParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        def retrieve(assistant_id, params = {})
          @client.request(
            method: :get,
            path: ["assistants/%0s", assistant_id],
            model: OpenAI::Models::Beta::Assistant,
            options: params[:request_options]
          )
        end

        # Modifies an assistant.
        #
        # @param assistant_id [String] The ID of the assistant to modify.
        #
        # @param params [OpenAI::Models::Beta::AssistantUpdateParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String, nil] :description The description of the assistant. The maximum length is 512 characters.
        #
        #   @option params [String, nil] :instructions The system instructions that the assistant uses. The maximum length is 256,000
        #     characters.
        #
        #   @option params [Hash{Symbol=>String}, nil] :metadata Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @option params [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model::AssistantSupportedModels] :model ID of the model to use. You can use the
        #     [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #     see all of your available models, or see our
        #     [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #     them.
        #
        #   @option params [String, nil] :name The name of the assistant. The maximum length is 256 characters.
        #
        #   @option params [Symbol, OpenAI::Models::ReasoningEffort, nil] :reasoning_effort **o-series models only**
        #
        #     Constrains effort on reasoning for
        #     [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #     supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #     result in faster responses and fewer tokens used on reasoning in a response.
        #
        #   @option params [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] :response_format Specifies the format that the model must output. Compatible with
        #     [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        #     [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        #     and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        #     Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        #     Outputs which ensures the model will match your supplied JSON schema. Learn more
        #     in the
        #     [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        #     Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        #     message the model generates is valid JSON.
        #
        #     **Important:** when using JSON mode, you **must** also instruct the model to
        #     produce JSON yourself via a system or user message. Without this, the model may
        #     generate an unending stream of whitespace until the generation reaches the token
        #     limit, resulting in a long-running and seemingly "stuck" request. Also note that
        #     the message content may be partially cut off if `finish_reason="length"`, which
        #     indicates the generation exceeded `max_tokens` or the conversation exceeded the
        #     max context length.
        #
        #   @option params [Float, nil] :temperature What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #     make the output more random, while lower values like 0.2 will make it more
        #     focused and deterministic.
        #
        #   @option params [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil] :tool_resources A set of resources that are used by the assistant's tools. The resources are
        #     specific to the type of tool. For example, the `code_interpreter` tool requires
        #     a list of file IDs, while the `file_search` tool requires a list of vector store
        #     IDs.
        #
        #   @option params [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>] :tools A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #     assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #     `function`.
        #
        #   @option params [Float, nil] :top_p An alternative to sampling with temperature, called nucleus sampling, where the
        #     model considers the results of the tokens with top_p probability mass. So 0.1
        #     means only the tokens comprising the top 10% probability mass are considered.
        #
        #     We generally recommend altering this or temperature but not both.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        def update(assistant_id, params = {})
          parsed, options = OpenAI::Models::Beta::AssistantUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["assistants/%0s", assistant_id],
            body: parsed,
            model: OpenAI::Models::Beta::Assistant,
            options: options
          )
        end

        # Returns a list of assistants.
        #
        # @param params [OpenAI::Models::Beta::AssistantListParams, Hash{Symbol=>Object}] .
        #
        #   @option params [String] :after A cursor for use in pagination. `after` is an object ID that defines your place
        #     in the list. For instance, if you make a list request and receive 100 objects,
        #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #     fetch the next page of the list.
        #
        #   @option params [String] :before A cursor for use in pagination. `before` is an object ID that defines your place
        #     in the list. For instance, if you make a list request and receive 100 objects,
        #     starting with obj_foo, your subsequent call can include before=obj_foo in order
        #     to fetch the previous page of the list.
        #
        #   @option params [Integer] :limit A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
        #
        #   @option params [Symbol, OpenAI::Models::Beta::AssistantListParams::Order] :order Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #     order and `desc` for descending order.
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Assistant>]
        #
        def list(params = {})
          parsed, options = OpenAI::Models::Beta::AssistantListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "assistants",
            query: parsed,
            page: OpenAI::CursorPage,
            model: OpenAI::Models::Beta::Assistant,
            options: options
          )
        end

        # Delete an assistant.
        #
        # @param assistant_id [String] The ID of the assistant to delete.
        #
        # @param params [OpenAI::Models::Beta::AssistantDeleteParams, Hash{Symbol=>Object}] .
        #
        #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
        #
        # @return [OpenAI::Models::Beta::AssistantDeleted]
        #
        def delete(assistant_id, params = {})
          @client.request(
            method: :delete,
            path: ["assistants/%0s", assistant_id],
            model: OpenAI::Models::Beta::AssistantDeleted,
            options: params[:request_options]
          )
        end

        # @param client [OpenAI::Client]
        #
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end

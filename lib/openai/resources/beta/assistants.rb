# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Assistants
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::AssistantCreateParams} for more details.
        #
        # Create an assistant with a model and instructions.
        #
        # @overload create(model:, description: nil, instructions: nil, metadata: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel] ID of the model to use. You can use the [List models](https://platform.openai.co
        # ...
        #
        # @param description [String, nil] The description of the assistant. The maximum length is 512 characters. ...
        #
        # @param instructions [String, nil] The system instructions that the assistant uses. The maximum length is 256,000 c
        # ...
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        # @param name [String, nil] The name of the assistant. The maximum length is 256 characters. ...
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] **o-series models only** ...
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
        # ...
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        # ...
        #
        # @param tool_resources [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil] A set of resources that are used by the assistant's tools. The resources are spe
        # ...
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>] A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        # ...
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
        # ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        # @see OpenAI::Models::Beta::AssistantCreateParams
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
        # @overload retrieve(assistant_id, request_options: {})
        #
        # @param assistant_id [String] The ID of the assistant to retrieve.
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
            model: OpenAI::Models::Beta::Assistant,
            options: params[:request_options]
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::AssistantUpdateParams} for more details.
        #
        # Modifies an assistant.
        #
        # @overload update(assistant_id, description: nil, instructions: nil, metadata: nil, model: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param assistant_id [String] The ID of the assistant to modify.
        #
        # @param description [String, nil] The description of the assistant. The maximum length is 512 characters. ...
        #
        # @param instructions [String, nil] The system instructions that the assistant uses. The maximum length is 256,000 c
        # ...
        #
        # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
        #
        # @param model [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model] ID of the model to use. You can use the [List models](https://platform.openai.co
        # ...
        #
        # @param name [String, nil] The name of the assistant. The maximum length is 256 characters. ...
        #
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil] **o-series models only** ...
        #
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil] Specifies the format that the model must output. Compatible with [GPT-4o](https:
        # ...
        #
        # @param temperature [Float, nil] What sampling temperature to use, between 0 and 2. Higher values like 0.8 will m
        # ...
        #
        # @param tool_resources [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil] A set of resources that are used by the assistant's tools. The resources are spe
        # ...
        #
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>] A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        # ...
        #
        # @param top_p [Float, nil] An alternative to sampling with temperature, called nucleus sampling, where the
        # ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::Assistant]
        #
        # @see OpenAI::Models::Beta::AssistantUpdateParams
        def update(assistant_id, params = {})
          parsed, options = OpenAI::Models::Beta::AssistantUpdateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["assistants/%1$s", assistant_id],
            body: parsed,
            model: OpenAI::Models::Beta::Assistant,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::AssistantListParams} for more details.
        #
        # Returns a list of assistants.
        #
        # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
        #
        # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
        # ...
        #
        # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
        # ...
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
        # ...
        #
        # @param order [Symbol, OpenAI::Models::Beta::AssistantListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
        # ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Assistant>]
        #
        # @see OpenAI::Models::Beta::AssistantListParams
        def list(params = {})
          parsed, options = OpenAI::Models::Beta::AssistantListParams.dump_request(params)
          @client.request(
            method: :get,
            path: "assistants",
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::Beta::Assistant,
            options: options
          )
        end

        # Delete an assistant.
        #
        # @overload delete(assistant_id, request_options: {})
        #
        # @param assistant_id [String] The ID of the assistant to delete.
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
            model: OpenAI::Models::Beta::AssistantDeleted,
            options: params[:request_options]
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

# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Assistants
        # Create an assistant with a model and instructions.
        #
        # @overload create(model:, description: nil, instructions: nil, metadata: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param model [String, Symbol, OpenAI::Models::ChatModel]
        # @param description [String, nil]
        # @param instructions [String, nil]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param name [String, nil]
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        # @param temperature [Float, nil]
        # @param tool_resources [OpenAI::Models::Beta::AssistantCreateParams::ToolResources, nil]
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        # @param top_p [Float, nil]
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
        # @param assistant_id [String]
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

        # Modifies an assistant.
        #
        # @overload update(assistant_id, description: nil, instructions: nil, metadata: nil, model: nil, name: nil, reasoning_effort: nil, response_format: nil, temperature: nil, tool_resources: nil, tools: nil, top_p: nil, request_options: {})
        #
        # @param assistant_id [String]
        # @param description [String, nil]
        # @param instructions [String, nil]
        # @param metadata [Hash{Symbol=>String}, nil]
        # @param model [String, Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model]
        # @param name [String, nil]
        # @param reasoning_effort [Symbol, OpenAI::Models::ReasoningEffort, nil]
        # @param response_format [Symbol, :auto, OpenAI::Models::ResponseFormatText, OpenAI::Models::ResponseFormatJSONObject, OpenAI::Models::ResponseFormatJSONSchema, nil]
        # @param temperature [Float, nil]
        # @param tool_resources [OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, nil]
        # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool>]
        # @param top_p [Float, nil]
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

        # Returns a list of assistants.
        #
        # @overload list(after: nil, before: nil, limit: nil, order: nil, request_options: {})
        #
        # @param after [String]
        # @param before [String]
        # @param limit [Integer]
        # @param order [Symbol, OpenAI::Models::Beta::AssistantListParams::Order]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Assistant>]
        #
        # @see OpenAI::Models::Beta::AssistantListParams
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
        # @overload delete(assistant_id, request_options: {})
        #
        # @param assistant_id [String]
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

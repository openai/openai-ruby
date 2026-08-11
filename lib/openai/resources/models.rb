# frozen_string_literal: true

module OpenAI
  module Resources
    # List and describe the various models available in the API.
    class Models
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [Models::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: Models.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # Retrieves a model instance, providing basic information about the model such as
      # the owner and permissioning.
      #
      # @overload retrieve(model, request_options: {})
      #
      # @param model [String] The ID of the model to use for this request
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Model]
      #
      # @see OpenAI::Models::ModelRetrieveParams
      def retrieve(model, params = {})
        @client.request(
          method: :get,
          path: ["models/%1$s", model],
          model: OpenAI::Model,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Lists the currently available models, and provides basic information about each
      # one such as the owner and availability.
      #
      # @overload list(request_options: {})
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Page<OpenAI::Models::Model>]
      #
      # @see OpenAI::Models::ModelListParams
      def list(params = {})
        @client.request(
          method: :get,
          path: "models",
          page: OpenAI::Internal::Page,
          model: OpenAI::Model,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      # delete a model.
      #
      # @overload delete(model, request_options: {})
      #
      # @param model [String] The model to delete
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ModelDeleted]
      #
      # @see OpenAI::Models::ModelDeleteParams
      def delete(model, params = {})
        @client.request(
          method: :delete,
          path: ["models/%1$s", model],
          model: OpenAI::ModelDeleted,
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
      end

      class WithRawResponse
        def retrieve(model, params = {})
          @resource.retrieve(model, params)
        end

        def list(params = {})
          @resource.list(params)
        end

        def delete(model, params = {})
          @resource.delete(model, params)
        end

        # @api private
        #
        # @param resource [Models]
        def initialize(resource:)
          @resource = resource
        end
      end
    end
  end
end

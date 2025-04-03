# frozen_string_literal: true

module OpenAI
  module Resources
    class Models
      # Retrieves a model instance, providing basic information about the model such as
      #   the owner and permissioning.
      #
      # @overload retrieve(model, request_options: {})
      #
      # @param model [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Model]
      #
      # @see OpenAI::Models::ModelRetrieveParams
      def retrieve(model, params = {})
        @client.request(
          method: :get,
          path: ["models/%1$s", model],
          model: OpenAI::Models::Model,
          options: params[:request_options]
        )
      end

      # Lists the currently available models, and provides basic information about each
      #   one such as the owner and availability.
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
          model: OpenAI::Models::Model,
          options: params[:request_options]
        )
      end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      #   delete a model.
      #
      # @overload delete(model, request_options: {})
      #
      # @param model [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ModelDeleted]
      #
      # @see OpenAI::Models::ModelDeleteParams
      def delete(model, params = {})
        @client.request(
          method: :delete,
          path: ["models/%1$s", model],
          model: OpenAI::Models::ModelDeleted,
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

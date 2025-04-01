# frozen_string_literal: true

module OpenAI
  module Resources
    class Models
      # Retrieves a model instance, providing basic information about the model such as
      #   the owner and permissioning.
      #
      # @param model [String] The ID of the model to use for this request
      #
      # @param params [OpenAI::Models::ModelRetrieveParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Model]
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
      # @param params [OpenAI::Models::ModelListParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Page<OpenAI::Models::Model>]
      def list(params = {})
        @client.request(
          method: :get,
          path: "models",
          page: OpenAI::Page,
          model: OpenAI::Models::Model,
          options: params[:request_options]
        )
      end

      # Delete a fine-tuned model. You must have the Owner role in your organization to
      #   delete a model.
      #
      # @param model [String] The model to delete
      #
      # @param params [OpenAI::Models::ModelDeleteParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::ModelDeleted]
      def delete(model, params = {})
        @client.request(
          method: :delete,
          path: ["models/%1$s", model],
          model: OpenAI::Models::ModelDeleted,
          options: params[:request_options]
        )
      end

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end

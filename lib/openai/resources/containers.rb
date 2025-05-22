# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      # @return [OpenAI::Resources::Containers::Files]
      attr_reader :files

      # Create Container
      #
      # @overload create(name:, expires_after: nil, file_ids: nil, request_options: {})
      #
      # @param name [String] Name of the container to create.
      #
      # @param expires_after [OpenAI::Models::ContainerCreateParams::ExpiresAfter] Container expiration time in seconds relative to the 'anchor' time.
      #
      # @param file_ids [Array<String>] IDs of files to copy to the container.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ContainerCreateResponse]
      #
      # @see OpenAI::Models::ContainerCreateParams
      def create(params)
        parsed, options = OpenAI::ContainerCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "containers",
          body: parsed,
          model: OpenAI::Models::ContainerCreateResponse,
          options: options
        )
      end

      # Retrieve Container
      #
      # @overload retrieve(container_id, request_options: {})
      #
      # @param container_id [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ContainerRetrieveResponse]
      #
      # @see OpenAI::Models::ContainerRetrieveParams
      def retrieve(container_id, params = {})
        @client.request(
          method: :get,
          path: ["containers/%1$s", container_id],
          model: OpenAI::Models::ContainerRetrieveResponse,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ContainerListParams} for more details.
      #
      # List Containers
      #
      # @overload list(after: nil, limit: nil, order: nil, request_options: {})
      #
      # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
      #
      # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
      #
      # @param order [Symbol, OpenAI::Models::ContainerListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::ContainerListResponse>]
      #
      # @see OpenAI::Models::ContainerListParams
      def list(params = {})
        parsed, options = OpenAI::ContainerListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "containers",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Models::ContainerListResponse,
          options: options
        )
      end

      # Delete Container
      #
      # @overload delete(container_id, request_options: {})
      #
      # @param container_id [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [nil]
      #
      # @see OpenAI::Models::ContainerDeleteParams
      def delete(container_id, params = {})
        @client.request(
          method: :delete,
          path: ["containers/%1$s", container_id],
          model: NilClass,
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @files = OpenAI::Resources::Containers::Files.new(client: client)
      end
    end
  end
end

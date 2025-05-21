# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      class Files
        # @return [OpenAI::Resources::Containers::Files::Content]
        attr_reader :content

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Containers::FileCreateParams} for more details.
        #
        # Create a Container File
        #
        # You can send either a multipart/form-data request with the raw file content, or
        # a JSON request with a file ID.
        #
        # @overload create(container_id, file: nil, file_id: nil, request_options: {})
        #
        # @param container_id [String]
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The File object (not file name) to be uploaded.
        #
        # @param file_id [String] Name of the file to create.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Containers::FileCreateResponse]
        #
        # @see OpenAI::Models::Containers::FileCreateParams
        def create(container_id, params = {})
          parsed, options = OpenAI::Containers::FileCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["containers/%1$s/files", container_id],
            body: parsed,
            model: OpenAI::Models::Containers::FileCreateResponse,
            options: options
          )
        end

        # Retrieve Container File
        #
        # @overload retrieve(file_id, container_id:, request_options: {})
        #
        # @param file_id [String]
        # @param container_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Containers::FileRetrieveResponse]
        #
        # @see OpenAI::Models::Containers::FileRetrieveParams
        def retrieve(file_id, params)
          parsed, options = OpenAI::Containers::FileRetrieveParams.dump_request(params)
          container_id =
            parsed.delete(:container_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["containers/%1$s/files/%2$s", container_id, file_id],
            model: OpenAI::Models::Containers::FileRetrieveResponse,
            options: options
          )
        end

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Containers::FileListParams} for more details.
        #
        # List Container files
        #
        # @overload list(container_id, after: nil, limit: nil, order: nil, request_options: {})
        #
        # @param container_id [String]
        #
        # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
        #
        # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
        #
        # @param order [Symbol, OpenAI::Containers::FileListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Containers::FileListResponse>]
        #
        # @see OpenAI::Models::Containers::FileListParams
        def list(container_id, params = {})
          parsed, options = OpenAI::Containers::FileListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["containers/%1$s/files", container_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Models::Containers::FileListResponse,
            options: options
          )
        end

        # Delete Container File
        #
        # @overload delete(file_id, container_id:, request_options: {})
        #
        # @param file_id [String]
        # @param container_id [String]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [nil]
        #
        # @see OpenAI::Models::Containers::FileDeleteParams
        def delete(file_id, params)
          parsed, options = OpenAI::Containers::FileDeleteParams.dump_request(params)
          container_id =
            parsed.delete(:container_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["containers/%1$s/files/%2$s", container_id, file_id],
            model: NilClass,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @content = OpenAI::Resources::Containers::Files::Content.new(client: client)
        end
      end
    end
  end
end

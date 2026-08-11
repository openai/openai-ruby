# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      class Files
        class Content
          # Returns a wrapper that exposes the raw HTTP response for each request.
          #
          # @return [Content::WithRawResponse]
          def with_raw_response
            WithRawResponse.new(
              resource: Content.new(
                client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
              )
            )
          end

          # Retrieve Container File Content
          #
          # @overload retrieve(file_id, container_id:, request_options: {})
          #
          # @param file_id [String]
          # @param container_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [StringIO]
          #
          # @see OpenAI::Models::Containers::Files::ContentRetrieveParams
          def retrieve(file_id, params)
            parsed, options = OpenAI::Containers::Files::ContentRetrieveParams.dump_request(params)
            container_id =
              parsed.delete(:container_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["containers/%1$s/files/%2$s/content", container_id, file_id],
              headers: {"accept" => "application/binary"},
              model: StringIO,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Internal::Transport::RequestClient]
          def initialize(client:)
            @client = client
          end

          class WithRawResponse
            def retrieve(file_id, params)
              @resource.retrieve(file_id, params)
            end

            # @api private
            #
            # @param resource [Content]
            def initialize(resource:)
              @resource = resource
            end
          end
        end
      end
    end
  end
end

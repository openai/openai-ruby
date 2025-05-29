# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      class Files
        class Content
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
              options: options
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
end

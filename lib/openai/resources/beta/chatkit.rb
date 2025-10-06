# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class ChatKit
        # @return [OpenAI::Resources::Beta::ChatKit::Sessions]
        attr_reader :sessions

        # @return [OpenAI::Resources::Beta::ChatKit::Threads]
        attr_reader :threads

        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Beta::ChatKitUploadFileParams} for more details.
        #
        # Upload a ChatKit file
        #
        # @overload upload_file(file:, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] Binary file contents to store with the ChatKit session. Supports PDFs and PNG, J
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Beta::FilePart, OpenAI::Models::Beta::ImagePart]
        #
        # @see OpenAI::Models::Beta::ChatKitUploadFileParams
        def upload_file(params)
          parsed, options = OpenAI::Beta::ChatKitUploadFileParams.dump_request(params)
          @client.request(
            method: :post,
            path: "chatkit/files",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Beta::ChatKitUploadFileResponse,
            options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **options}
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @sessions = OpenAI::Resources::Beta::ChatKit::Sessions.new(client: client)
          @threads = OpenAI::Resources::Beta::ChatKit::Threads.new(client: client)
        end
      end
    end
  end
end

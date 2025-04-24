# frozen_string_literal: true

module OpenAI
  module Resources
    class Uploads
      class Parts
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Uploads::PartCreateParams} for more details.
        #
        # Adds a
        # [Part](https://platform.openai.com/docs/api-reference/uploads/part-object) to an
        # [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object.
        # A Part represents a chunk of bytes from the file you are trying to upload.
        #
        # Each Part can be at most 64 MB, and you can add Parts until you hit the Upload
        # maximum of 8 GB.
        #
        # It is possible to add multiple Parts in parallel. You can decide the intended
        # order of the Parts when you
        # [complete the Upload](https://platform.openai.com/docs/api-reference/uploads/complete).
        #
        # @overload create(upload_id, data:, request_options: {})
        #
        # @param upload_id [String] The ID of the Upload. ...
        #
        # @param data [Pathname, StringIO] The chunk of bytes for this Part. ...
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Uploads::UploadPart]
        #
        # @see OpenAI::Models::Uploads::PartCreateParams
        def create(upload_id, params)
          parsed, options = OpenAI::Models::Uploads::PartCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["uploads/%1$s/parts", upload_id],
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Uploads::UploadPart,
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

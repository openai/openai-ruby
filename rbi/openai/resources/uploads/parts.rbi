# typed: strong

module OpenAI
  module Resources

    class Uploads

      # Use Uploads to upload large files in multiple parts.
      class Parts

        # Adds a
        # [Part](https://developers.openai.com/api/reference/resources/uploads/subresources/parts)
        # to an [Upload](https://developers.openai.com/api/reference/resources/uploads)
        # object. A Part represents a chunk of bytes from the file you are trying to
        # upload.
        #
        # Each Part can be at most 64 MB, and you can add Parts until you hit the Upload
        # maximum of 8 GB.
        #
        # It is possible to add multiple Parts in parallel. You can decide the intended
        # order of the Parts when you
        # [complete the Upload](https://developers.openai.com/api/reference/resources/uploads/methods/complete).
        sig {
          params(upload_id: String, data: OpenAI::Internal::FileInput, request_options: OpenAI::RequestOptions::OrHash)
            .returns(OpenAI::Uploads::UploadPart)
        }
        def create(
          # The ID of the Upload.
          upload_id,
          # The chunk of bytes for this Part.
          #
          # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
          # metadata. Use `OpenAI::FilePart` when you need to override the filename or
          # content type.
          data:,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end

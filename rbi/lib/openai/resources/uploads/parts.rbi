# typed: strong

module OpenAI
  module Resources
    class Uploads
      class Parts
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
        sig do
          params(
            upload_id: String,
            data: T.any(Pathname, StringIO),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
          )
            .returns(OpenAI::Models::Uploads::UploadPart)
        end
        def create(
          # The ID of the Upload.
          upload_id,
          # The chunk of bytes for this Part.
          data:,
          request_options: {}
        ); end
        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:); end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Resources
    class Uploads
      # Use Uploads to upload large files in multiple parts.
      class Parts
        sig { returns(Parts::WithRawResponse) }
        def with_raw_response
        end

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
            data: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Uploads::UploadPart)
        end
        def create(
          # The ID of the Upload.
          upload_id,
          # The chunk of bytes for this Part.
          data:,
          request_options: {}
        )
        end

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { params(upload_id: String, data: OpenAI::Internal::FileInput, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Uploads::UploadPart]) }
          def create(
            # The ID of the Upload.
            upload_id,
            # The chunk of bytes for this Part.
            data:,
            request_options: {}
          )
          end

          # @api private
          sig { params(resource: Parts).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end

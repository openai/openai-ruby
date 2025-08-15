# typed: strong

module OpenAI
  module Resources
    class Uploads
      sig { returns(OpenAI::Resources::Uploads::Parts) }
      attr_reader :parts

      # Creates an intermediate
      # [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object
      # that you can add
      # [Parts](https://platform.openai.com/docs/api-reference/uploads/part-object) to.
      # Currently, an Upload can accept at most 8 GB in total and expires after an hour
      # after you create it.
      #
      # Once you complete the Upload, we will create a
      # [File](https://platform.openai.com/docs/api-reference/files/object) object that
      # contains all the parts you uploaded. This File is usable in the rest of our
      # platform as a regular File object.
      #
      # For certain `purpose` values, the correct `mime_type` must be specified. Please
      # refer to documentation for the
      # [supported MIME types for your use case](https://platform.openai.com/docs/assistants/tools/file-search#supported-files).
      #
      # For guidance on the proper filename extensions for each purpose, please follow
      # the documentation on
      # [creating a File](https://platform.openai.com/docs/api-reference/files/create).
      sig do
        params(
          bytes: Integer,
          filename: String,
          mime_type: String,
          purpose: OpenAI::FilePurpose::OrSymbol,
          expires_after: OpenAI::UploadCreateParams::ExpiresAfter::OrHash,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Upload)
      end
      def create(
        # The number of bytes in the file you are uploading.
        bytes:,
        # The name of the file to upload.
        filename:,
        # The MIME type of the file.
        #
        # This must fall within the supported MIME types for your file purpose. See the
        # supported MIME types for assistants and vision.
        mime_type:,
        # The intended purpose of the uploaded file.
        #
        # See the
        # [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
        purpose:,
        # The expiration policy for a file. By default, files with `purpose=batch` expire
        # after 30 days and all other files are persisted until they are manually deleted.
        expires_after: nil,
        request_options: {}
      )
      end

      # Cancels the Upload. No Parts may be added after an Upload is cancelled.
      sig do
        params(
          upload_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Upload)
      end
      def cancel(
        # The ID of the Upload.
        upload_id,
        request_options: {}
      )
      end

      # Completes the
      # [Upload](https://platform.openai.com/docs/api-reference/uploads/object).
      #
      # Within the returned Upload object, there is a nested
      # [File](https://platform.openai.com/docs/api-reference/files/object) object that
      # is ready to use in the rest of the platform.
      #
      # You can specify the order of the Parts by passing in an ordered list of the Part
      # IDs.
      #
      # The number of bytes uploaded upon completion must match the number of bytes
      # initially specified when creating the Upload object. No Parts may be added after
      # an Upload is completed.
      sig do
        params(
          upload_id: String,
          part_ids: T::Array[String],
          md5: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Upload)
      end
      def complete(
        # The ID of the Upload.
        upload_id,
        # The ordered list of Part IDs.
        part_ids:,
        # The optional md5 checksum for the file contents to verify if the bytes uploaded
        # matches what you expect.
        md5: nil,
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

# frozen_string_literal: true

module OpenAI
  module Resources
    class Uploads
      # @return [OpenAI::Resources::Uploads::Parts]
      attr_reader :parts

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::UploadCreateParams} for more details.
      #
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
      #
      # @overload create(bytes:, filename:, mime_type:, purpose:, expires_after: nil, request_options: {})
      #
      # @param bytes [Integer] The number of bytes in the file you are uploading.
      #
      # @param filename [String] The name of the file to upload.
      #
      # @param mime_type [String] The MIME type of the file.
      #
      # @param purpose [Symbol, OpenAI::Models::FilePurpose] The intended purpose of the uploaded file.
      #
      # @param expires_after [OpenAI::Models::UploadCreateParams::ExpiresAfter] The expiration policy for a file. By default, files with `purpose=batch` expire
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Upload]
      #
      # @see OpenAI::Models::UploadCreateParams
      def create(params)
        parsed, options = OpenAI::UploadCreateParams.dump_request(params)
        @client.request(method: :post, path: "uploads", body: parsed, model: OpenAI::Upload, options: options)
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::UploadCancelParams} for more details.
      #
      # Cancels the Upload. No Parts may be added after an Upload is cancelled.
      #
      # @overload cancel(upload_id, request_options: {})
      #
      # @param upload_id [String] The ID of the Upload.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Upload]
      #
      # @see OpenAI::Models::UploadCancelParams
      def cancel(upload_id, params = {})
        @client.request(
          method: :post,
          path: ["uploads/%1$s/cancel", upload_id],
          model: OpenAI::Upload,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::UploadCompleteParams} for more details.
      #
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
      #
      # @overload complete(upload_id, part_ids:, md5: nil, request_options: {})
      #
      # @param upload_id [String] The ID of the Upload.
      #
      # @param part_ids [Array<String>] The ordered list of Part IDs.
      #
      # @param md5 [String] The optional md5 checksum for the file contents to verify if the bytes uploaded
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Upload]
      #
      # @see OpenAI::Models::UploadCompleteParams
      def complete(upload_id, params)
        parsed, options = OpenAI::UploadCompleteParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["uploads/%1$s/complete", upload_id],
          body: parsed,
          model: OpenAI::Upload,
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @parts = OpenAI::Resources::Uploads::Parts.new(client: client)
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Resources
    # Use Uploads to upload large files in multiple parts.
    class Uploads
      # Use Uploads to upload large files in multiple parts.
      # @return [OpenAI::Resources::Uploads::Parts]
      attr_reader :parts

      # Creates an intermediate
      # [Upload](https://developers.openai.com/api/reference/resources/uploads) object
      # that you can add
      # [Parts](https://developers.openai.com/api/reference/resources/uploads/subresources/parts)
      # to. Currently, an Upload can accept at most 8 GB in total and expires after an
      # hour after you create it.
      #
      # Once you complete the Upload, we will create a
      # [File](https://developers.openai.com/api/reference/resources/files) object that
      # contains all the parts you uploaded. This File is usable in the rest of our
      # platform as a regular File object.
      #
      # For certain `purpose` values, the correct `mime_type` must be specified. Please
      # refer to documentation for the
      # [supported MIME types for your use case](https://developers.openai.com/api/docs/guides/tools-file-search#supported-files).
      #
      # For guidance on the proper filename extensions for each purpose, please follow
      # the documentation on
      # [creating a File](https://developers.openai.com/api/reference/resources/files/methods/create).
      #
      # Returns the Upload object with status `pending`.
      #
      # @overload create(bytes:, filename:, mime_type:, purpose:, expires_after: nil, request_options: {})
      #
      # @param bytes [Integer]
      #   The number of bytes in the file you are uploading.
      #
      # @param filename [String]
      #   The name of the file to upload.
      #
      # @param mime_type [String]
      #   The MIME type of the file.
      #
      #   This must fall within the supported MIME types for your file purpose. See the
      #   supported MIME types for assistants and vision.
      #
      # @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   The intended purpose of the uploaded file.
      #
      #   See the
      #   [documentation on File purposes](https://developers.openai.com/api/reference/resources/files/methods/create#%28resource%29%20files%20%3E%20%28method%29%20create%20%3E%20%28params%29%200%20%3E%20%28param%29%20purpose%20%3E%20%28schema%29).
      #
      # @param expires_after [OpenAI::Models::UploadCreateParams::ExpiresAfter]
      #   The expiration policy for a file. By default, files with `purpose=batch` expire
      #   after 30 days and all other files are persisted until they are manually deleted.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Upload]
      #
      # @see OpenAI::Models::UploadCreateParams
      def create(params)
        parsed, options = OpenAI::UploadCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "uploads",
          body: parsed,
          model: OpenAI::Upload,
          security: {bearer_auth: true},
          options: options
        )
      end

      # Cancels the Upload. No Parts may be added after an Upload is cancelled.
      #
      # Returns the Upload object with status `cancelled`.
      #
      # @overload cancel(upload_id, request_options: {})
      #
      # @param upload_id [String]
      #   The ID of the Upload.
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
          security: {bearer_auth: true},
          options: params[:request_options]
        )
      end

      # Completes the
      # [Upload](https://developers.openai.com/api/reference/resources/uploads).
      #
      # Within the returned Upload object, there is a nested
      # [File](https://developers.openai.com/api/reference/resources/files) object that
      # is ready to use in the rest of the platform.
      #
      # You can specify the order of the Parts by passing in an ordered list of the Part
      # IDs.
      #
      # The number of bytes uploaded upon completion must match the number of bytes
      # initially specified when creating the Upload object. No Parts may be added after
      # an Upload is completed. Returns the Upload object with status `completed`,
      # including an additional `file` property containing the created usable File
      # object.
      #
      # @overload complete(upload_id, part_ids:, md5: nil, request_options: {})
      #
      # @param upload_id [String]
      #   The ID of the Upload.
      #
      # @param part_ids [Array<String>]
      #   The ordered list of Part IDs.
      #
      # @param md5 [String]
      #   The optional md5 checksum for the file contents to verify if the bytes uploaded
      #   matches what you expect.
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
          security: {bearer_auth: true},
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

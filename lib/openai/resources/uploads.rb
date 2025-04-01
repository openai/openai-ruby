# frozen_string_literal: true

module OpenAI
  module Resources
    class Uploads
      # @return [OpenAI::Resources::Uploads::Parts]
      attr_reader :parts

      # Creates an intermediate
      #   [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object
      #   that you can add
      #   [Parts](https://platform.openai.com/docs/api-reference/uploads/part-object) to.
      #   Currently, an Upload can accept at most 8 GB in total and expires after an hour
      #   after you create it.
      #
      #   Once you complete the Upload, we will create a
      #   [File](https://platform.openai.com/docs/api-reference/files/object) object that
      #   contains all the parts you uploaded. This File is usable in the rest of our
      #   platform as a regular File object.
      #
      #   For certain `purpose` values, the correct `mime_type` must be specified. Please
      #   refer to documentation for the
      #   [supported MIME types for your use case](https://platform.openai.com/docs/assistants/tools/file-search#supported-files).
      #
      #   For guidance on the proper filename extensions for each purpose, please follow
      #   the documentation on
      #   [creating a File](https://platform.openai.com/docs/api-reference/files/create).
      #
      # @param params [OpenAI::Models::UploadCreateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [Integer] :bytes The number of bytes in the file you are uploading.
      #
      #   @option params [String] :filename The name of the file to upload.
      #
      #   @option params [String] :mime_type The MIME type of the file.
      #
      #     This must fall within the supported MIME types for your file purpose. See the
      #     supported MIME types for assistants and vision.
      #
      #   @option params [Symbol, OpenAI::Models::FilePurpose] :purpose The intended purpose of the uploaded file.
      #
      #     See the
      #     [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Upload]
      def create(params)
        parsed, options = OpenAI::Models::UploadCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "uploads",
          body: parsed,
          model: OpenAI::Models::Upload,
          options: options
        )
      end

      # Cancels the Upload. No Parts may be added after an Upload is cancelled.
      #
      # @param upload_id [String] The ID of the Upload.
      #
      # @param params [OpenAI::Models::UploadCancelParams, Hash{Symbol=>Object}] .
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Upload]
      def cancel(upload_id, params = {})
        @client.request(
          method: :post,
          path: ["uploads/%1$s/cancel", upload_id],
          model: OpenAI::Models::Upload,
          options: params[:request_options]
        )
      end

      # Completes the
      #   [Upload](https://platform.openai.com/docs/api-reference/uploads/object).
      #
      #   Within the returned Upload object, there is a nested
      #   [File](https://platform.openai.com/docs/api-reference/files/object) object that
      #   is ready to use in the rest of the platform.
      #
      #   You can specify the order of the Parts by passing in an ordered list of the Part
      #   IDs.
      #
      #   The number of bytes uploaded upon completion must match the number of bytes
      #   initially specified when creating the Upload object. No Parts may be added after
      #   an Upload is completed.
      #
      # @param upload_id [String] The ID of the Upload.
      #
      # @param params [OpenAI::Models::UploadCompleteParams, Hash{Symbol=>Object}] .
      #
      #   @option params [Array<String>] :part_ids The ordered list of Part IDs.
      #
      #   @option params [String] :md5 The optional md5 checksum for the file contents to verify if the bytes uploaded
      #     matches what you expect.
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::Upload]
      def complete(upload_id, params)
        parsed, options = OpenAI::Models::UploadCompleteParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["uploads/%1$s/complete", upload_id],
          body: parsed,
          model: OpenAI::Models::Upload,
          options: options
        )
      end

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @parts = OpenAI::Resources::Uploads::Parts.new(client: client)
      end
    end
  end
end

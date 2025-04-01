# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#create
    class UploadCreateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute bytes
      #   The number of bytes in the file you are uploading.
      #
      #   @return [Integer]
      required :bytes, Integer

      # @!attribute filename
      #   The name of the file to upload.
      #
      #   @return [String]
      required :filename, String

      # @!attribute mime_type
      #   The MIME type of the file.
      #
      #     This must fall within the supported MIME types for your file purpose. See the
      #     supported MIME types for assistants and vision.
      #
      #   @return [String]
      required :mime_type, String

      # @!attribute purpose
      #   The intended purpose of the uploaded file.
      #
      #     See the
      #     [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::Models::FilePurpose }

      # @!parse
      #   # @param bytes [Integer]
      #   # @param filename [String]
      #   # @param mime_type [String]
      #   # @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(bytes:, filename:, mime_type:, purpose:, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end

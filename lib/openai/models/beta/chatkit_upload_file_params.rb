# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::ChatKit#upload_file
      class ChatKitUploadFileParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute file
        #   Binary file contents to store with the ChatKit session. Supports PDFs and PNG,
        #   JPG, JPEG, GIF, or WEBP images.
        #
        #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
        required :file, OpenAI::Internal::Type::FileInput

        # @!method initialize(file:, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ChatKitUploadFileParams} for more details.
        #
        #   @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] Binary file contents to store with the ChatKit session. Supports PDFs and PNG, J
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end

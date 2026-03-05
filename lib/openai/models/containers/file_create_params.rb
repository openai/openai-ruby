# frozen_string_literal: true

module OpenAI
  module Models
    module Containers
      # @see OpenAI::Resources::Containers::Files#create
      class FileCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute container_id
        #
        #   @return [String]
        required :container_id, String

        # @!attribute file
        #   The File object (not file name) to be uploaded.
        #
        #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, nil]
        optional :file, OpenAI::Internal::Type::FileInput

        # @!attribute file_id
        #   Name of the file to create.
        #
        #   @return [String, nil]
        optional :file_id, String

        # @!method initialize(container_id:, file: nil, file_id: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Containers::FileCreateParams} for more details.
        #
        #   @param container_id [String]
        #
        #   @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The File object (not file name) to be uploaded.
        #
        #   @param file_id [String] Name of the file to create.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end

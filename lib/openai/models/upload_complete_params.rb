# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#complete
    class UploadCompleteParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute part_ids
      #   The ordered list of Part IDs.
      #
      #   @return [Array<String>]
      required :part_ids, OpenAI::Internal::Type::ArrayOf[String]

      # @!attribute md5
      #   The optional md5 checksum for the file contents to verify if the bytes uploaded
      #   matches what you expect.
      #
      #   @return [String, nil]
      optional :md5, String

      # @!method initialize(part_ids:, md5: nil, request_options: {})
      #   @param part_ids [Array<String>]
      #   @param md5 [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end

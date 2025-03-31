# frozen_string_literal: true

module OpenAI
  module Models
    class UploadCompleteParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute part_ids
      #   The ordered list of Part IDs.
      #
      #   @return [Array<String>]
      required :part_ids, OpenAI::ArrayOf[String]

      # @!attribute [r] md5
      #   The optional md5 checksum for the file contents to verify if the bytes uploaded
      #     matches what you expect.
      #
      #   @return [String, nil]
      optional :md5, String

      # @!parse
      #   # @return [String]
      #   attr_writer :md5

      # @!parse
      #   # @param part_ids [Array<String>]
      #   # @param md5 [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(part_ids:, md5: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end

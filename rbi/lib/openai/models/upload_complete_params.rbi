# typed: strong

module OpenAI
  module Models
    class UploadCompleteParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # The ordered list of Part IDs.
      sig { returns(T::Array[String]) }
      attr_accessor :part_ids

      # The optional md5 checksum for the file contents to verify if the bytes uploaded
      # matches what you expect.
      sig { returns(T.nilable(String)) }
      attr_reader :md5

      sig { params(md5: String).void }
      attr_writer :md5

      sig do
        params(
          part_ids: T::Array[String],
          md5: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        # The ordered list of Part IDs.
        part_ids:,
        # The optional md5 checksum for the file contents to verify if the bytes uploaded
        # matches what you expect.
        md5: nil,
        request_options: {}
      ); end
      sig do
        override.returns({part_ids: T::Array[String], md5: String, request_options: OpenAI::RequestOptions})
      end
      def to_hash; end
    end
  end
end

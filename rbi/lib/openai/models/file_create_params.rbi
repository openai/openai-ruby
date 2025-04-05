# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # The File object (not file name) to be uploaded.
      sig { returns(T.any(IO, StringIO)) }
      attr_accessor :file

      # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      # Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      # fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      # Flexible file type for any purpose - `evals`: Used for eval data sets
      sig { returns(OpenAI::Models::FilePurpose::OrSymbol) }
      attr_accessor :purpose

      sig do
        params(
          file: T.any(IO, StringIO),
          purpose: OpenAI::Models::FilePurpose::OrSymbol,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(file:, purpose:, request_options: {}); end

      sig do
        override
          .returns(
            {
              file: T.any(IO, StringIO),
              purpose: OpenAI::Models::FilePurpose::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end
    end
  end
end

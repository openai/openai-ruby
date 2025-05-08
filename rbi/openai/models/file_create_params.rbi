# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # The File object (not file name) to be uploaded.
      sig { returns(T.any(Pathname, StringIO, IO, OpenAI::FilePart)) }
      attr_accessor :file

      # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      # Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      # fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      # Flexible file type for any purpose - `evals`: Used for eval data sets
      sig { returns(OpenAI::FilePurpose::OrSymbol) }
      attr_accessor :purpose

      sig do
        params(
          file: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
          purpose: OpenAI::FilePurpose::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The File object (not file name) to be uploaded.
        file:,
        # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
        # Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
        # fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
        # Flexible file type for any purpose - `evals`: Used for eval data sets
        purpose:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            file: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
            purpose: OpenAI::FilePurpose::OrSymbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end
    end
  end
end

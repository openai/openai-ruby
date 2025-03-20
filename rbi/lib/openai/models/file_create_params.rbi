# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The File object (not file name) to be uploaded.
      sig { returns(T.any(IO, StringIO)) }
      def file
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def file=(_)
      end

      # The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #   Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #   fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #   Flexible file type for any purpose - `evals`: Used for eval data sets
      sig { returns(Symbol) }
      def purpose
      end

      sig { params(_: Symbol).returns(Symbol) }
      def purpose=(_)
      end

      sig do
        params(
          file: T.any(IO, StringIO),
          purpose: Symbol,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(file:, purpose:, request_options: {})
      end

      sig do
        override.returns(
          {
            file: T.any(IO, StringIO),
            purpose: Symbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end
    end
  end
end

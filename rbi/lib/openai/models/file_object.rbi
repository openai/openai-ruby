# typed: strong

module OpenAI
  module Models
    class FileObject < OpenAI::BaseModel
      # The file identifier, which can be referenced in the API endpoints.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The size of the file, in bytes.
      sig { returns(Integer) }
      def bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def bytes=(_)
      end

      # The Unix timestamp (in seconds) for when the file was created.
      sig { returns(Integer) }
      def created_at
      end

      sig { params(_: Integer).returns(Integer) }
      def created_at=(_)
      end

      # The name of the file.
      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      # The object type, which is always `file`.
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
      sig { returns(OpenAI::Models::FileObject::Purpose::TaggedSymbol) }
      def purpose
      end

      sig do
        params(_: OpenAI::Models::FileObject::Purpose::TaggedSymbol)
          .returns(OpenAI::Models::FileObject::Purpose::TaggedSymbol)
      end
      def purpose=(_)
      end

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      sig { returns(OpenAI::Models::FileObject::Status::TaggedSymbol) }
      def status
      end

      sig do
        params(_: OpenAI::Models::FileObject::Status::TaggedSymbol)
          .returns(OpenAI::Models::FileObject::Status::TaggedSymbol)
      end
      def status=(_)
      end

      # The Unix timestamp (in seconds) for when the file will expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expires_at=(_)
      end

      # Deprecated. For details on why a fine-tuning training file failed validation,
      #   see the `error` field on `fine_tuning.job`.
      sig { returns(T.nilable(String)) }
      def status_details
      end

      sig { params(_: String).returns(String) }
      def status_details=(_)
      end

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig do
        params(
          id: String,
          bytes: Integer,
          created_at: Integer,
          filename: String,
          purpose: OpenAI::Models::FileObject::Purpose::TaggedSymbol,
          status: OpenAI::Models::FileObject::Status::TaggedSymbol,
          expires_at: Integer,
          status_details: String,
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        id:,
        bytes:,
        created_at:,
        filename:,
        purpose:,
        status:,
        expires_at: nil,
        status_details: nil,
        object: :file
      )
      end

      sig do
        override
          .returns(
            {
              id: String,
              bytes: Integer,
              created_at: Integer,
              filename: String,
              object: Symbol,
              purpose: OpenAI::Models::FileObject::Purpose::TaggedSymbol,
              status: OpenAI::Models::FileObject::Status::TaggedSymbol,
              expires_at: Integer,
              status_details: String
            }
          )
      end
      def to_hash
      end

      # The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
      module Purpose
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FileObject::Purpose) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::FileObject::Purpose::TaggedSymbol) }

        ASSISTANTS = T.let(:assistants, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        ASSISTANTS_OUTPUT = T.let(:assistants_output, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        BATCH = T.let(:batch, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        BATCH_OUTPUT = T.let(:batch_output, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE = T.let(:"fine-tune", OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE_RESULTS = T.let(:"fine-tune-results", OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        VISION = T.let(:vision, OpenAI::Models::FileObject::Purpose::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::FileObject::Purpose::TaggedSymbol]) }
          def values
          end
        end
      end

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      module Status
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FileObject::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::FileObject::Status::TaggedSymbol) }

        UPLOADED = T.let(:uploaded, OpenAI::Models::FileObject::Status::TaggedSymbol)
        PROCESSED = T.let(:processed, OpenAI::Models::FileObject::Status::TaggedSymbol)
        ERROR = T.let(:error, OpenAI::Models::FileObject::Status::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::FileObject::Status::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end

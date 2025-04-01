# typed: strong

module OpenAI
  module Models
    class FileObject < OpenAI::BaseModel
      # The file identifier, which can be referenced in the API endpoints.
      sig { returns(String) }
      attr_accessor :id

      # The size of the file, in bytes.
      sig { returns(Integer) }
      attr_accessor :bytes

      # The Unix timestamp (in seconds) for when the file was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The name of the file.
      sig { returns(String) }
      attr_accessor :filename

      # The object type, which is always `file`.
      sig { returns(Symbol) }
      attr_accessor :object

      # The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
      sig { returns(OpenAI::Models::FileObject::Purpose::TaggedSymbol) }
      attr_accessor :purpose

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      sig { returns(OpenAI::Models::FileObject::Status::TaggedSymbol) }
      attr_accessor :status

      # The Unix timestamp (in seconds) for when the file will expire.
      sig { returns(T.nilable(Integer)) }
      attr_reader :expires_at

      sig { params(expires_at: Integer).void }
      attr_writer :expires_at

      # Deprecated. For details on why a fine-tuning training file failed validation,
      #   see the `error` field on `fine_tuning.job`.
      sig { returns(T.nilable(String)) }
      attr_reader :status_details

      sig { params(status_details: String).void }
      attr_writer :status_details

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig do
        params(
          id: String,
          bytes: Integer,
          created_at: Integer,
          filename: String,
          purpose: OpenAI::Models::FileObject::Purpose::OrSymbol,
          status: OpenAI::Models::FileObject::Status::OrSymbol,
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
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::FileObject::Purpose::TaggedSymbol) }

        ASSISTANTS = T.let(:assistants, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        ASSISTANTS_OUTPUT = T.let(:assistants_output, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        BATCH = T.let(:batch, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        BATCH_OUTPUT = T.let(:batch_output, OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE = T.let(:"fine-tune", OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE_RESULTS = T.let(:"fine-tune-results", OpenAI::Models::FileObject::Purpose::TaggedSymbol)
        VISION = T.let(:vision, OpenAI::Models::FileObject::Purpose::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::FileObject::Purpose::TaggedSymbol]) }
        def self.values
        end
      end

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      module Status
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FileObject::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::FileObject::Status::TaggedSymbol) }

        UPLOADED = T.let(:uploaded, OpenAI::Models::FileObject::Status::TaggedSymbol)
        PROCESSED = T.let(:processed, OpenAI::Models::FileObject::Status::TaggedSymbol)
        ERROR = T.let(:error, OpenAI::Models::FileObject::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::FileObject::Status::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end

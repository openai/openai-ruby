# typed: strong

module OpenAI
  module Models
    class FileObject < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::FileObject, OpenAI::Internal::AnyHash) }

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
      # `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`,
      # `vision`, and `user_data`.
      sig { returns(OpenAI::FileObject::Purpose::TaggedSymbol) }
      attr_accessor :purpose

      # Deprecated. The current status of the file, which can be either `uploaded`,
      # `processed`, or `error`.
      sig { returns(OpenAI::FileObject::Status::TaggedSymbol) }
      attr_accessor :status

      # The Unix timestamp (in seconds) for when the file will expire.
      sig { returns(T.nilable(Integer)) }
      attr_reader :expires_at

      sig { params(expires_at: Integer).void }
      attr_writer :expires_at

      # Deprecated. For details on why a fine-tuning training file failed validation,
      # see the `error` field on `fine_tuning.job`.
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
          purpose: OpenAI::FileObject::Purpose::OrSymbol,
          status: OpenAI::FileObject::Status::OrSymbol,
          expires_at: Integer,
          status_details: String,
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # The file identifier, which can be referenced in the API endpoints.
        id:,
        # The size of the file, in bytes.
        bytes:,
        # The Unix timestamp (in seconds) for when the file was created.
        created_at:,
        # The name of the file.
        filename:,
        # The intended purpose of the file. Supported values are `assistants`,
        # `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`,
        # `vision`, and `user_data`.
        purpose:,
        # Deprecated. The current status of the file, which can be either `uploaded`,
        # `processed`, or `error`.
        status:,
        # The Unix timestamp (in seconds) for when the file will expire.
        expires_at: nil,
        # Deprecated. For details on why a fine-tuning training file failed validation,
        # see the `error` field on `fine_tuning.job`.
        status_details: nil,
        # The object type, which is always `file`.
        object: :file
      )
      end

      sig do
        override.returns(
          {
            id: String,
            bytes: Integer,
            created_at: Integer,
            filename: String,
            object: Symbol,
            purpose: OpenAI::FileObject::Purpose::TaggedSymbol,
            status: OpenAI::FileObject::Status::TaggedSymbol,
            expires_at: Integer,
            status_details: String
          }
        )
      end
      def to_hash
      end

      # The intended purpose of the file. Supported values are `assistants`,
      # `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`,
      # `vision`, and `user_data`.
      module Purpose
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::FileObject::Purpose) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        ASSISTANTS =
          T.let(:assistants, OpenAI::FileObject::Purpose::TaggedSymbol)
        ASSISTANTS_OUTPUT =
          T.let(:assistants_output, OpenAI::FileObject::Purpose::TaggedSymbol)
        BATCH = T.let(:batch, OpenAI::FileObject::Purpose::TaggedSymbol)
        BATCH_OUTPUT =
          T.let(:batch_output, OpenAI::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE =
          T.let(:"fine-tune", OpenAI::FileObject::Purpose::TaggedSymbol)
        FINE_TUNE_RESULTS =
          T.let(:"fine-tune-results", OpenAI::FileObject::Purpose::TaggedSymbol)
        VISION = T.let(:vision, OpenAI::FileObject::Purpose::TaggedSymbol)
        USER_DATA = T.let(:user_data, OpenAI::FileObject::Purpose::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::FileObject::Purpose::TaggedSymbol])
        end
        def self.values
        end
      end

      # Deprecated. The current status of the file, which can be either `uploaded`,
      # `processed`, or `error`.
      module Status
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::FileObject::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        UPLOADED = T.let(:uploaded, OpenAI::FileObject::Status::TaggedSymbol)
        PROCESSED = T.let(:processed, OpenAI::FileObject::Status::TaggedSymbol)
        ERROR = T.let(:error, OpenAI::FileObject::Status::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::FileObject::Status::TaggedSymbol])
        end
        def self.values
        end
      end
    end
  end
end

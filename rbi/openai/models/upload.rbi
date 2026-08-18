# typed: strong

module OpenAI
  module Models
    class Upload < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(OpenAI::Upload, OpenAI::Internal::AnyHash) }

      # The Upload unique identifier, which can be referenced in API endpoints.
      sig { returns(String) }
      attr_accessor :id

      # The intended number of bytes to be uploaded.
      sig { returns(Integer) }
      attr_accessor :bytes

      # The Unix timestamp (in seconds) for when the Upload was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The Unix timestamp (in seconds) for when the Upload will expire.
      sig { returns(Integer) }
      attr_accessor :expires_at

      # The name of the file to be uploaded.
      sig { returns(String) }
      attr_accessor :filename

      # The object type, which is always "upload".
      sig { returns(Symbol) }
      attr_accessor :object

      # The intended purpose of the file.
      # [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose)
      # for acceptable values.
      sig { returns(String) }
      attr_accessor :purpose

      # The status of the Upload.
      sig { returns(OpenAI::Upload::Status::TaggedSymbol) }
      attr_accessor :status

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig { returns(T.nilable(OpenAI::FileObject)) }
      attr_reader :file

      sig { params(file: T.nilable(OpenAI::FileObject::OrHash)).void }
      attr_writer :file

      # The Upload object can accept byte chunks in the form of Parts.
      sig do
        params(
          id: String,
          bytes: Integer,
          created_at: Integer,
          expires_at: Integer,
          filename: String,
          purpose: String,
          status: OpenAI::Upload::Status::OrSymbol,
          file: T.nilable(OpenAI::FileObject::OrHash),
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # The Upload unique identifier, which can be referenced in API endpoints.
        id:,
        # The intended number of bytes to be uploaded.
        bytes:,
        # The Unix timestamp (in seconds) for when the Upload was created.
        created_at:,
        # The Unix timestamp (in seconds) for when the Upload will expire.
        expires_at:,
        # The name of the file to be uploaded.
        filename:,
        # The intended purpose of the file.
        # [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose)
        # for acceptable values.
        purpose:,
        # The status of the Upload.
        status:,
        # The `File` object represents a document that has been uploaded to OpenAI.
        file: nil,
        # The object type, which is always "upload".
        object: :upload
      )
      end

      sig do
        override.returns(
          {
            id: String,
            bytes: Integer,
            created_at: Integer,
            expires_at: Integer,
            filename: String,
            object: Symbol,
            purpose: String,
            status: OpenAI::Upload::Status::TaggedSymbol,
            file: T.nilable(OpenAI::FileObject)
          }
        )
      end
      def to_hash
      end

      # The status of the Upload.
      module Status
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Upload::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PENDING = T.let(:pending, OpenAI::Upload::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Upload::Status::TaggedSymbol)
        CANCELLED = T.let(:cancelled, OpenAI::Upload::Status::TaggedSymbol)
        EXPIRED = T.let(:expired, OpenAI::Upload::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Upload::Status::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    class Upload < OpenAI::BaseModel
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
      #   [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose)
      #   for acceptable values.
      sig { returns(String) }
      attr_accessor :purpose

      # The status of the Upload.
      sig { returns(OpenAI::Models::Upload::Status::TaggedSymbol) }
      attr_accessor :status

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig { returns(T.nilable(OpenAI::Models::FileObject)) }
      attr_reader :file

      sig { params(file: T.nilable(T.any(OpenAI::Models::FileObject, OpenAI::Util::AnyHash))).void }
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
          status: OpenAI::Models::Upload::Status::OrSymbol,
          file: T.nilable(T.any(OpenAI::Models::FileObject, OpenAI::Util::AnyHash)),
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        id:,
        bytes:,
        created_at:,
        expires_at:,
        filename:,
        purpose:,
        status:,
        file: nil,
        object: :upload
      )
      end

      sig do
        override
          .returns(
            {
              id: String,
              bytes: Integer,
              created_at: Integer,
              expires_at: Integer,
              filename: String,
              object: Symbol,
              purpose: String,
              status: OpenAI::Models::Upload::Status::TaggedSymbol,
              file: T.nilable(OpenAI::Models::FileObject)
            }
          )
      end
      def to_hash
      end

      # The status of the Upload.
      module Status
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Upload::Status) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::Upload::Status::TaggedSymbol) }

        PENDING = T.let(:pending, OpenAI::Models::Upload::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Models::Upload::Status::TaggedSymbol)
        CANCELLED = T.let(:cancelled, OpenAI::Models::Upload::Status::TaggedSymbol)
        EXPIRED = T.let(:expired, OpenAI::Models::Upload::Status::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Upload::Status::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    class Upload < OpenAI::BaseModel
      # The Upload unique identifier, which can be referenced in API endpoints.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The intended number of bytes to be uploaded.
      sig { returns(Integer) }
      def bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def bytes=(_)
      end

      # The Unix timestamp (in seconds) for when the Upload was created.
      sig { returns(Integer) }
      def created_at
      end

      sig { params(_: Integer).returns(Integer) }
      def created_at=(_)
      end

      # The Unix timestamp (in seconds) for when the Upload will expire.
      sig { returns(Integer) }
      def expires_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expires_at=(_)
      end

      # The name of the file to be uploaded.
      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      # The object type, which is always "upload".
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The intended purpose of the file.
      #   [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose)
      #   for acceptable values.
      sig { returns(String) }
      def purpose
      end

      sig { params(_: String).returns(String) }
      def purpose=(_)
      end

      # The status of the Upload.
      sig { returns(OpenAI::Models::Upload::Status::TaggedSymbol) }
      def status
      end

      sig do
        params(_: OpenAI::Models::Upload::Status::TaggedSymbol)
          .returns(OpenAI::Models::Upload::Status::TaggedSymbol)
      end
      def status=(_)
      end

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig { returns(T.nilable(OpenAI::Models::FileObject)) }
      def file
      end

      sig do
        params(_: T.nilable(T.any(OpenAI::Models::FileObject, OpenAI::Util::AnyHash)))
          .returns(T.nilable(T.any(OpenAI::Models::FileObject, OpenAI::Util::AnyHash)))
      end
      def file=(_)
      end

      # The Upload object can accept byte chunks in the form of Parts.
      sig do
        params(
          id: String,
          bytes: Integer,
          created_at: Integer,
          expires_at: Integer,
          filename: String,
          purpose: String,
          status: OpenAI::Models::Upload::Status::TaggedSymbol,
          file: T.nilable(OpenAI::Models::FileObject),
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(id:, bytes:, created_at:, expires_at:, filename:, purpose:, status:, file: nil, object: :upload)
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
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Upload::Status::TaggedSymbol) }

        PENDING = T.let(:pending, OpenAI::Models::Upload::Status::TaggedSymbol)
        COMPLETED = T.let(:completed, OpenAI::Models::Upload::Status::TaggedSymbol)
        CANCELLED = T.let(:cancelled, OpenAI::Models::Upload::Status::TaggedSymbol)
        EXPIRED = T.let(:expired, OpenAI::Models::Upload::Status::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::Upload::Status::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end

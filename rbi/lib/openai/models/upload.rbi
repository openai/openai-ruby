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

      # The Unix timestamp (in seconds) for when the Upload was created.
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
      sig { returns(Symbol) }
      def status
      end

      sig { params(_: Symbol).returns(Symbol) }
      def status=(_)
      end

      # The `File` object represents a document that has been uploaded to OpenAI.
      sig { returns(T.nilable(OpenAI::Models::FileObject)) }
      def file
      end

      sig { params(_: T.nilable(OpenAI::Models::FileObject)).returns(T.nilable(OpenAI::Models::FileObject)) }
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
          status: Symbol,
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
              status: Symbol,
              file: T.nilable(OpenAI::Models::FileObject)
            }
          )
      end
      def to_hash
      end

      # The status of the Upload.
      class Status < OpenAI::Enum
        abstract!

        PENDING = :pending
        COMPLETED = :completed
        CANCELLED = :cancelled
        EXPIRED = :expired

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end

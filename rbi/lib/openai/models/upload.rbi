# typed: strong

module OpenAI
  module Models
    class Upload < OpenAI::BaseModel
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      sig { returns(Integer) }
      def bytes
      end

      sig { params(_: Integer).returns(Integer) }
      def bytes=(_)
      end

      sig { returns(Integer) }
      def created_at
      end

      sig { params(_: Integer).returns(Integer) }
      def created_at=(_)
      end

      sig { returns(Integer) }
      def expires_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expires_at=(_)
      end

      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      sig { returns(String) }
      def purpose
      end

      sig { params(_: String).returns(String) }
      def purpose=(_)
      end

      sig { returns(Symbol) }
      def status
      end

      sig { params(_: Symbol).returns(Symbol) }
      def status=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::FileObject)) }
      def file
      end

      sig { params(_: T.nilable(OpenAI::Models::FileObject)).returns(T.nilable(OpenAI::Models::FileObject)) }
      def file=(_)
      end

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

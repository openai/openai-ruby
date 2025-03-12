# typed: strong

module OpenAI
  module Models
    class FileObject < OpenAI::BaseModel
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

      sig { returns(Symbol) }
      def purpose
      end

      sig { params(_: Symbol).returns(Symbol) }
      def purpose=(_)
      end

      sig { returns(Symbol) }
      def status
      end

      sig { params(_: Symbol).returns(Symbol) }
      def status=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def expires_at
      end

      sig { params(_: Integer).returns(Integer) }
      def expires_at=(_)
      end

      sig { returns(T.nilable(String)) }
      def status_details
      end

      sig { params(_: String).returns(String) }
      def status_details=(_)
      end

      sig do
        params(
          id: String,
          bytes: Integer,
          created_at: Integer,
          filename: String,
          purpose: Symbol,
          status: Symbol,
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
              purpose: Symbol,
              status: Symbol,
              expires_at: Integer,
              status_details: String
            }
          )
      end
      def to_hash
      end

      class Purpose < OpenAI::Enum
        abstract!

        ASSISTANTS = :assistants
        ASSISTANTS_OUTPUT = :assistants_output
        BATCH = :batch
        BATCH_OUTPUT = :batch_output
        FINE_TUNE = :"fine-tune"
        FINE_TUNE_RESULTS = :"fine-tune-results"
        VISION = :vision

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end

      class Status < OpenAI::Enum
        abstract!

        UPLOADED = :uploaded
        PROCESSED = :processed
        ERROR = :error

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end

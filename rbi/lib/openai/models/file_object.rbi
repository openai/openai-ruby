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
      sig { returns(Symbol) }
      def purpose
      end

      sig { params(_: Symbol).returns(Symbol) }
      def purpose=(_)
      end

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      sig { returns(Symbol) }
      def status
      end

      sig { params(_: Symbol).returns(Symbol) }
      def status=(_)
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
          purpose: Symbol,
          status: Symbol,
          status_details: String,
          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(id:, bytes:, created_at:, filename:, purpose:, status:, status_details: nil, object: :file)
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
              status_details: String
            }
          )
      end
      def to_hash
      end

      # The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
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

      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
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

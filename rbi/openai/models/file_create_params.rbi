# typed: strong

module OpenAI
  module Models
    class FileCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::FileCreateParams, OpenAI::Internal::AnyHash)
        end

      # The File object (not file name) to be uploaded.
      sig { returns(OpenAI::Internal::FileInput) }
      attr_accessor :file

      # The intended purpose of the uploaded file. One of:
      #
      # - `assistants`: Used in the Assistants API
      # - `batch`: Used in the Batch API
      # - `fine-tune`: Used for fine-tuning
      # - `vision`: Images used for vision fine-tuning
      # - `user_data`: Flexible file type for any purpose
      # - `evals`: Used for eval data sets
      sig { returns(OpenAI::FilePurpose::OrSymbol) }
      attr_accessor :purpose

      # The expiration policy for a file. By default, files with `purpose=batch` expire
      # after 30 days and all other files are persisted until they are manually deleted.
      sig { returns(T.nilable(OpenAI::FileCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(
          expires_after: OpenAI::FileCreateParams::ExpiresAfter::OrHash
        ).void
      end
      attr_writer :expires_after

      sig do
        params(
          file: OpenAI::Internal::FileInput,
          purpose: OpenAI::FilePurpose::OrSymbol,
          expires_after: OpenAI::FileCreateParams::ExpiresAfter::OrHash,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The File object (not file name) to be uploaded.
        file:,
        # The intended purpose of the uploaded file. One of:
        #
        # - `assistants`: Used in the Assistants API
        # - `batch`: Used in the Batch API
        # - `fine-tune`: Used for fine-tuning
        # - `vision`: Images used for vision fine-tuning
        # - `user_data`: Flexible file type for any purpose
        # - `evals`: Used for eval data sets
        purpose:,
        # The expiration policy for a file. By default, files with `purpose=batch` expire
        # after 30 days and all other files are persisted until they are manually deleted.
        expires_after: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            file: OpenAI::Internal::FileInput,
            purpose: OpenAI::FilePurpose::OrSymbol,
            expires_after: OpenAI::FileCreateParams::ExpiresAfter,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FileCreateParams::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `created_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of seconds after the anchor time that the file will expire. Must be
        # between 3600 (1 hour) and 2592000 (30 days).
        sig { returns(Integer) }
        attr_accessor :seconds

        # The expiration policy for a file. By default, files with `purpose=batch` expire
        # after 30 days and all other files are persisted until they are manually deleted.
        sig do
          params(seconds: Integer, anchor: Symbol).returns(T.attached_class)
        end
        def self.new(
          # The number of seconds after the anchor time that the file will expire. Must be
          # between 3600 (1 hour) and 2592000 (30 days).
          seconds:,
          # Anchor timestamp after which the expiration policy applies. Supported anchors:
          # `created_at`.
          anchor: :created_at
        )
        end

        sig { override.returns({ anchor: Symbol, seconds: Integer }) }
        def to_hash
        end
      end
    end
  end
end

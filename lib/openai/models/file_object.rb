# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#create
    class FileObject < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   The file identifier, which can be referenced in the API endpoints.
      #
      #   @return [String]
      required :id, String

      # @!attribute bytes
      #   The size of the file, in bytes.
      #
      #   @return [Integer]
      required :bytes, Integer

      # @!attribute created_at
      #   The Unix timestamp (in seconds) for when the file was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute filename
      #   The name of the file.
      #
      #   @return [String]
      required :filename, String

      # @!attribute object
      #   The object type, which is always `file`.
      #
      #   @return [Symbol, :file]
      required :object, const: :file

      # @!attribute purpose
      #   The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
      #
      #   @return [Symbol, OpenAI::Models::FileObject::Purpose]
      required :purpose, enum: -> { OpenAI::FileObject::Purpose }

      # @!attribute status
      #   @deprecated
      #
      #   Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      #
      #   @return [Symbol, OpenAI::Models::FileObject::Status]
      required :status, enum: -> { OpenAI::FileObject::Status }

      # @!attribute expires_at
      #   The Unix timestamp (in seconds) for when the file will expire.
      #
      #   @return [Integer, nil]
      optional :expires_at, Integer

      # @!attribute status_details
      #   @deprecated
      #
      #   Deprecated. For details on why a fine-tuning training file failed validation,
      #   see the `error` field on `fine_tuning.job`.
      #
      #   @return [String, nil]
      optional :status_details, String

      # @!method initialize(id:, bytes:, created_at:, filename:, purpose:, status:, expires_at: nil, status_details: nil, object: :file)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::FileObject} for more details.
      #
      #   The `File` object represents a document that has been uploaded to OpenAI.
      #
      #   @param id [String] The file identifier, which can be referenced in the API endpoints.
      #
      #   @param bytes [Integer] The size of the file, in bytes.
      #
      #   @param created_at [Integer] The Unix timestamp (in seconds) for when the file was created.
      #
      #   @param filename [String] The name of the file.
      #
      #   @param purpose [Symbol, OpenAI::Models::FileObject::Purpose] The intended purpose of the file. Supported values are `assistants`, `assistants
      #
      #   @param status [Symbol, OpenAI::Models::FileObject::Status] Deprecated. The current status of the file, which can be either `uploaded`, `pro
      #
      #   @param expires_at [Integer] The Unix timestamp (in seconds) for when the file will expire.
      #
      #   @param status_details [String] Deprecated. For details on why a fine-tuning training file failed validation, se
      #
      #   @param object [Symbol, :file] The object type, which is always `file`.

      # The intended purpose of the file. Supported values are `assistants`,
      # `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      # and `vision`.
      #
      # @see OpenAI::Models::FileObject#purpose
      module Purpose
        extend OpenAI::Internal::Type::Enum

        ASSISTANTS = :assistants
        ASSISTANTS_OUTPUT = :assistants_output
        BATCH = :batch
        BATCH_OUTPUT = :batch_output
        FINE_TUNE = :"fine-tune"
        FINE_TUNE_RESULTS = :"fine-tune-results"
        VISION = :vision

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @deprecated
      #
      # Deprecated. The current status of the file, which can be either `uploaded`,
      # `processed`, or `error`.
      #
      # @see OpenAI::Models::FileObject#status
      module Status
        extend OpenAI::Internal::Type::Enum

        UPLOADED = :uploaded
        PROCESSED = :processed
        ERROR = :error

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

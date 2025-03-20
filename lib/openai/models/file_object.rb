# frozen_string_literal: true

module OpenAI
  module Models
    class FileObject < OpenAI::BaseModel
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
      #     `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #     and `vision`.
      #
      #   @return [Symbol, OpenAI::Models::FileObject::Purpose]
      required :purpose, enum: -> { OpenAI::Models::FileObject::Purpose }

      # @!attribute status
      #   Deprecated. The current status of the file, which can be either `uploaded`,
      #     `processed`, or `error`.
      #
      #   @return [Symbol, OpenAI::Models::FileObject::Status]
      required :status, enum: -> { OpenAI::Models::FileObject::Status }

      # @!attribute [r] expires_at
      #   The Unix timestamp (in seconds) for when the file will expire.
      #
      #   @return [Integer, nil]
      optional :expires_at, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :expires_at

      # @!attribute [r] status_details
      #   Deprecated. For details on why a fine-tuning training file failed validation,
      #     see the `error` field on `fine_tuning.job`.
      #
      #   @return [String, nil]
      optional :status_details, String

      # @!parse
      #   # @return [String]
      #   attr_writer :status_details

      # @!parse
      #   # The `File` object represents a document that has been uploaded to OpenAI.
      #   #
      #   # @param id [String]
      #   # @param bytes [Integer]
      #   # @param created_at [Integer]
      #   # @param filename [String]
      #   # @param purpose [Symbol, OpenAI::Models::FileObject::Purpose]
      #   # @param status [Symbol, OpenAI::Models::FileObject::Status]
      #   # @param expires_at [Integer]
      #   # @param status_details [String]
      #   # @param object [Symbol, :file]
      #   #
      #   def initialize(
      #     id:,
      #     bytes:,
      #     created_at:,
      #     filename:,
      #     purpose:,
      #     status:,
      #     expires_at: nil,
      #     status_details: nil,
      #     object: :file,
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # The intended purpose of the file. Supported values are `assistants`,
      #   `assistants_output`, `batch`, `batch_output`, `fine-tune`, `fine-tune-results`
      #   and `vision`.
      module Purpose
        extend OpenAI::Enum

        ASSISTANTS = :assistants
        ASSISTANTS_OUTPUT = :assistants_output
        BATCH = :batch
        BATCH_OUTPUT = :batch_output
        FINE_TUNE = :"fine-tune"
        FINE_TUNE_RESULTS = :"fine-tune-results"
        VISION = :vision

        finalize!

        class << self
          # @!parse
          #   # @return [Array<Symbol>]
          #   def values; end
        end
      end

      # @deprecated
      #
      # Deprecated. The current status of the file, which can be either `uploaded`,
      #   `processed`, or `error`.
      module Status
        extend OpenAI::Enum

        UPLOADED = :uploaded
        PROCESSED = :processed
        ERROR = :error

        finalize!

        class << self
          # @!parse
          #   # @return [Array<Symbol>]
          #   def values; end
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#create
    class Upload < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #   The Upload unique identifier, which can be referenced in API endpoints.
      #
      #   @return [String]
      required :id, String

      # @!attribute bytes
      #   The intended number of bytes to be uploaded.
      #
      #   @return [Integer]
      required :bytes, Integer

      # @!attribute created_at
      #   The Unix timestamp (in seconds) for when the Upload was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute expires_at
      #   The Unix timestamp (in seconds) for when the Upload will expire.
      #
      #   @return [Integer]
      required :expires_at, Integer

      # @!attribute filename
      #   The name of the file to be uploaded.
      #
      #   @return [String]
      required :filename, String

      # @!attribute object
      #   The object type, which is always "upload".
      #
      #   @return [Symbol, :upload]
      required :object, const: :upload

      # @!attribute purpose
      #   The intended purpose of the file.
      #   [Please refer here](https://platform.openai.com/docs/api-reference/files/object#files/object-purpose)
      #   for acceptable values.
      #
      #   @return [String]
      required :purpose, String

      # @!attribute status
      #   The status of the Upload.
      #
      #   @return [Symbol, OpenAI::Models::Upload::Status]
      required :status, enum: -> { OpenAI::Models::Upload::Status }

      # @!attribute file
      #   The `File` object represents a document that has been uploaded to OpenAI.
      #
      #   @return [OpenAI::Models::FileObject, nil]
      optional :file, -> { OpenAI::Models::FileObject }, nil?: true

      # @!method initialize(id:, bytes:, created_at:, expires_at:, filename:, purpose:, status:, file: nil, object: :upload)
      #   The Upload object can accept byte chunks in the form of Parts.
      #
      #   @param id [String]
      #   @param bytes [Integer]
      #   @param created_at [Integer]
      #   @param expires_at [Integer]
      #   @param filename [String]
      #   @param purpose [String]
      #   @param status [Symbol, OpenAI::Models::Upload::Status]
      #   @param file [OpenAI::Models::FileObject, nil]
      #   @param object [Symbol, :upload]

      # The status of the Upload.
      #
      # @see OpenAI::Models::Upload#status
      module Status
        extend OpenAI::Internal::Type::Enum

        PENDING = :pending
        COMPLETED = :completed
        CANCELLED = :cancelled
        EXPIRED = :expired

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end

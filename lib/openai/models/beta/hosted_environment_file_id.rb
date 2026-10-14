# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class HostedEnvironmentFileID < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The session-scoped ID of the file in the execution environment.
        #
        #   @return [String]
        required :id, String

        # @!attribute file_id
        #   The ID of the uploaded file.
        #
        #   @return [String]
        required :file_id, String

        # @!attribute path
        #   The file's absolute path inside the environment.
        #
        #   @return [String]
        required :path, String

        # @!attribute size_bytes
        #   The decoded file size in bytes.
        #
        #   @return [Integer]
        required :size_bytes, Integer

        # @!attribute type
        #   The type of the object. Always `file_id`.
        #
        #   @return [Symbol, :file_id]
        required :type, const: :file_id

        # @!method initialize(id:, file_id:, path:, size_bytes:, type: :file_id)
        #   A file copied from the OpenAI Files API.
        #
        #   @param id [String]
        #     The session-scoped ID of the file in the execution environment.
        #
        #   @param file_id [String]
        #     The ID of the uploaded file.
        #
        #   @param path [String]
        #     The file's absolute path inside the environment.
        #
        #   @param size_bytes [Integer]
        #     The decoded file size in bytes.
        #
        #   @param type [Symbol, :file_id]
        #     The type of the object. Always `file_id`.
      end
    end
  end
end

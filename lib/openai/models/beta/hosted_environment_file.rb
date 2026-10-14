# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Metadata for a file materialized in an OpenAI-hosted execution environment.
      module HostedEnvironmentFile
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A file copied from the OpenAI Files API.
        variant :file_id, -> { OpenAI::Beta::HostedEnvironmentFileID }

        # A file supplied inline when the session was created.
        variant :inline, -> { OpenAI::Beta::HostedEnvironmentFile::Inline }

        class Inline < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The session-scoped ID of the file in the execution environment.
          #
          #   @return [String]
          required :id, String

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
          #   The type of the object. Always `inline`.
          #
          #   @return [Symbol, :inline]
          required :type, const: :inline

          # @!method initialize(id:, path:, size_bytes:, type: :inline)
          #   A file supplied inline when the session was created.
          #
          #   @param id [String]
          #     The session-scoped ID of the file in the execution environment.
          #
          #   @param path [String]
          #     The file's absolute path inside the environment.
          #
          #   @param size_bytes [Integer]
          #     The decoded file size in bytes.
          #
          #   @param type [Symbol, :inline]
          #     The type of the object. Always `inline`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::HostedEnvironmentFileID, OpenAI::Models::Beta::HostedEnvironmentFile::Inline)]
      end
    end
  end
end

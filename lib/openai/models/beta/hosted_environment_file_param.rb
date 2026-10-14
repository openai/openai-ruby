# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A file materialized in an OpenAI-hosted execution environment.
      module HostedEnvironmentFileParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A file previously uploaded through the OpenAI Files API.
        variant :file_id, -> { OpenAI::Beta::HostedEnvironmentFileParam::FileID }

        # A file supplied directly as standard-base64 data.
        variant :inline, -> { OpenAI::Beta::HostedEnvironmentFileParam::Inline }

        class FileID < OpenAI::Internal::Type::BaseModel
          # @!attribute file_id
          #   The ID of the uploaded file.
          #
          #   @return [String]
          required :file_id, String

          # @!attribute path
          #   The absolute destination path inside `/workspace`.
          #
          #   @return [String]
          required :path, String

          # @!attribute type
          #   The type of the object. Always `file_id`.
          #
          #   @return [Symbol, :file_id]
          required :type, const: :file_id

          # @!method initialize(file_id:, path:, type: :file_id)
          #   A file previously uploaded through the OpenAI Files API.
          #
          #   @param file_id [String]
          #     The ID of the uploaded file.
          #
          #   @param path [String]
          #     The absolute destination path inside `/workspace`.
          #
          #   @param type [Symbol, :file_id]
          #     The type of the object. Always `file_id`.
        end

        class Inline < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   The standard-base64-encoded file contents.
          #
          #   @return [String]
          required :data, String

          # @!attribute path
          #   The absolute destination path inside `/workspace`.
          #
          #   @return [String]
          required :path, String

          # @!attribute type
          #   The type of the object. Always `inline`.
          #
          #   @return [Symbol, :inline]
          required :type, const: :inline

          # @!method initialize(data:, path:, type: :inline)
          #   A file supplied directly as standard-base64 data.
          #
          #   @param data [String]
          #     The standard-base64-encoded file contents.
          #
          #   @param path [String]
          #     The absolute destination path inside `/workspace`.
          #
          #   @param type [Symbol, :inline]
          #     The type of the object. Always `inline`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline)]
      end
    end
  end
end

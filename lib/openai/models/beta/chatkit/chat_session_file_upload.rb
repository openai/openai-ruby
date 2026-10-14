# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionFileUpload < OpenAI::Internal::Type::BaseModel
          # @!attribute enabled
          #   Indicates if uploads are enabled for the session.
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute max_file_size
          #   Maximum upload size in megabytes.
          #
          #   @return [Integer, nil]
          required :max_file_size, Integer, nil?: true

          # @!attribute max_files
          #   Maximum number of uploads allowed during the session.
          #
          #   @return [Integer, nil]
          required :max_files, Integer, nil?: true

          # @!method initialize(enabled:, max_file_size:, max_files:)
          #   Upload permissions and limits applied to the session.
          #
          #   @param enabled [Boolean] Indicates if uploads are enabled for the session.
          #
          #   @param max_file_size [Integer, nil] Maximum upload size in megabytes.
          #
          #   @param max_files [Integer, nil] Maximum number of uploads allowed during the session.
        end
      end
    end
  end
end

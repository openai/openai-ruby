# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionChatKitConfiguration < OpenAI::Internal::Type::BaseModel
          # @!attribute automatic_thread_titling
          #   Automatic thread titling preferences.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionAutomaticThreadTitling]
          required :automatic_thread_titling, -> { OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling }

          # @!attribute file_upload
          #   Upload settings for the session.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionFileUpload]
          required :file_upload, -> { OpenAI::Beta::ChatKit::ChatSessionFileUpload }

          # @!attribute history
          #   History retention configuration.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionHistory]
          required :history, -> { OpenAI::Beta::ChatKit::ChatSessionHistory }

          # @!method initialize(automatic_thread_titling:, file_upload:, history:)
          #   ChatKit configuration for the session.
          #
          #   @param automatic_thread_titling [OpenAI::Models::Beta::ChatKit::ChatSessionAutomaticThreadTitling] Automatic thread titling preferences.
          #
          #   @param file_upload [OpenAI::Models::Beta::ChatKit::ChatSessionFileUpload] Upload settings for the session.
          #
          #   @param history [OpenAI::Models::Beta::ChatKit::ChatSessionHistory] History retention configuration.
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionChatKitConfigurationParam < OpenAI::Internal::Type::BaseModel
          # @!attribute automatic_thread_titling
          #   Configuration for automatic thread titling. When omitted, automatic thread
          #   titling is enabled by default.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling, nil]
          optional :automatic_thread_titling,
                   -> { OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling }

          # @!attribute file_upload
          #   Configuration for upload enablement and limits. When omitted, uploads are
          #   disabled by default (max_files 10, max_file_size 512 MB).
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload, nil]
          optional :file_upload, -> { OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload }

          # @!attribute history
          #   Configuration for chat history retention. When omitted, history is enabled by
          #   default with no limit on recent_threads (null).
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History, nil]
          optional :history, -> { OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History }

          # @!method initialize(automatic_thread_titling: nil, file_upload: nil, history: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam} for more
          #   details.
          #
          #   Optional per-session configuration settings for ChatKit behavior.
          #
          #   @param automatic_thread_titling [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling] Configuration for automatic thread titling. When omitted, automatic thread titli
          #
          #   @param file_upload [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload] Configuration for upload enablement and limits. When omitted, uploads are disabl
          #
          #   @param history [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History] Configuration for chat history retention. When omitted, history is enabled by de

          # @see OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam#automatic_thread_titling
          class AutomaticThreadTitling < OpenAI::Internal::Type::BaseModel
            # @!attribute enabled
            #   Enable automatic thread title generation. Defaults to true.
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!method initialize(enabled: nil)
            #   Configuration for automatic thread titling. When omitted, automatic thread
            #   titling is enabled by default.
            #
            #   @param enabled [Boolean] Enable automatic thread title generation. Defaults to true.
          end

          # @see OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam#file_upload
          class FileUpload < OpenAI::Internal::Type::BaseModel
            # @!attribute enabled
            #   Enable uploads for this session. Defaults to false.
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute max_file_size
            #   Maximum size in megabytes for each uploaded file. Defaults to 512 MB, which is
            #   the maximum allowable size.
            #
            #   @return [Integer, nil]
            optional :max_file_size, Integer

            # @!attribute max_files
            #   Maximum number of files that can be uploaded to the session. Defaults to 10.
            #
            #   @return [Integer, nil]
            optional :max_files, Integer

            # @!method initialize(enabled: nil, max_file_size: nil, max_files: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload}
            #   for more details.
            #
            #   Configuration for upload enablement and limits. When omitted, uploads are
            #   disabled by default (max_files 10, max_file_size 512 MB).
            #
            #   @param enabled [Boolean] Enable uploads for this session. Defaults to false.
            #
            #   @param max_file_size [Integer] Maximum size in megabytes for each uploaded file. Defaults to 512 MB, which is t
            #
            #   @param max_files [Integer] Maximum number of files that can be uploaded to the session. Defaults to 10.
          end

          # @see OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam#history
          class History < OpenAI::Internal::Type::BaseModel
            # @!attribute enabled
            #   Enables chat users to access previous ChatKit threads. Defaults to true.
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!attribute recent_threads
            #   Number of recent ChatKit threads users have access to. Defaults to unlimited
            #   when unset.
            #
            #   @return [Integer, nil]
            optional :recent_threads, Integer

            # @!method initialize(enabled: nil, recent_threads: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History}
            #   for more details.
            #
            #   Configuration for chat history retention. When omitted, history is enabled by
            #   default with no limit on recent_threads (null).
            #
            #   @param enabled [Boolean] Enables chat users to access previous ChatKit threads. Defaults to true.
            #
            #   @param recent_threads [Integer] Number of recent ChatKit threads users have access to. Defaults to unlimited whe
          end
        end
      end
    end
  end
end

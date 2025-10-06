# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionChatKitConfigurationParam < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam,
                OpenAI::Internal::AnyHash
              )
            end

          # Configuration for automatic thread titling. When omitted, automatic thread
          # titling is enabled by default.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling
              )
            )
          end
          attr_reader :automatic_thread_titling

          sig do
            params(
              automatic_thread_titling:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling::OrHash
            ).void
          end
          attr_writer :automatic_thread_titling

          # Configuration for upload enablement and limits. When omitted, uploads are
          # disabled by default (max_files 10, max_file_size 512 MB).
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload
              )
            )
          end
          attr_reader :file_upload

          sig do
            params(
              file_upload:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload::OrHash
            ).void
          end
          attr_writer :file_upload

          # Configuration for chat history retention. When omitted, history is enabled by
          # default with no limit on recent_threads (null).
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History
              )
            )
          end
          attr_reader :history

          sig do
            params(
              history:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History::OrHash
            ).void
          end
          attr_writer :history

          # Optional per-session configuration settings for ChatKit behavior.
          sig do
            params(
              automatic_thread_titling:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling::OrHash,
              file_upload:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload::OrHash,
              history:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Configuration for automatic thread titling. When omitted, automatic thread
            # titling is enabled by default.
            automatic_thread_titling: nil,
            # Configuration for upload enablement and limits. When omitted, uploads are
            # disabled by default (max_files 10, max_file_size 512 MB).
            file_upload: nil,
            # Configuration for chat history retention. When omitted, history is enabled by
            # default with no limit on recent_threads (null).
            history: nil
          )
          end

          sig do
            override.returns(
              {
                automatic_thread_titling:
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling,
                file_upload:
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload,
                history:
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History
              }
            )
          end
          def to_hash
          end

          class AutomaticThreadTitling < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::AutomaticThreadTitling,
                  OpenAI::Internal::AnyHash
                )
              end

            # Enable automatic thread title generation. Defaults to true.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            # Configuration for automatic thread titling. When omitted, automatic thread
            # titling is enabled by default.
            sig { params(enabled: T::Boolean).returns(T.attached_class) }
            def self.new(
              # Enable automatic thread title generation. Defaults to true.
              enabled: nil
            )
            end

            sig { override.returns({ enabled: T::Boolean }) }
            def to_hash
            end
          end

          class FileUpload < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::FileUpload,
                  OpenAI::Internal::AnyHash
                )
              end

            # Enable uploads for this session. Defaults to false.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            # Maximum size in megabytes for each uploaded file. Defaults to 512 MB, which is
            # the maximum allowable size.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_file_size

            sig { params(max_file_size: Integer).void }
            attr_writer :max_file_size

            # Maximum number of files that can be uploaded to the session. Defaults to 10.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_files

            sig { params(max_files: Integer).void }
            attr_writer :max_files

            # Configuration for upload enablement and limits. When omitted, uploads are
            # disabled by default (max_files 10, max_file_size 512 MB).
            sig do
              params(
                enabled: T::Boolean,
                max_file_size: Integer,
                max_files: Integer
              ).returns(T.attached_class)
            end
            def self.new(
              # Enable uploads for this session. Defaults to false.
              enabled: nil,
              # Maximum size in megabytes for each uploaded file. Defaults to 512 MB, which is
              # the maximum allowable size.
              max_file_size: nil,
              # Maximum number of files that can be uploaded to the session. Defaults to 10.
              max_files: nil
            )
            end

            sig do
              override.returns(
                {
                  enabled: T::Boolean,
                  max_file_size: Integer,
                  max_files: Integer
                }
              )
            end
            def to_hash
            end
          end

          class History < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::History,
                  OpenAI::Internal::AnyHash
                )
              end

            # Enables chat users to access previous ChatKit threads. Defaults to true.
            sig { returns(T.nilable(T::Boolean)) }
            attr_reader :enabled

            sig { params(enabled: T::Boolean).void }
            attr_writer :enabled

            # Number of recent ChatKit threads users have access to. Defaults to unlimited
            # when unset.
            sig { returns(T.nilable(Integer)) }
            attr_reader :recent_threads

            sig { params(recent_threads: Integer).void }
            attr_writer :recent_threads

            # Configuration for chat history retention. When omitted, history is enabled by
            # default with no limit on recent_threads (null).
            sig do
              params(enabled: T::Boolean, recent_threads: Integer).returns(
                T.attached_class
              )
            end
            def self.new(
              # Enables chat users to access previous ChatKit threads. Defaults to true.
              enabled: nil,
              # Number of recent ChatKit threads users have access to. Defaults to unlimited
              # when unset.
              recent_threads: nil
            )
            end

            sig do
              override.returns({ enabled: T::Boolean, recent_threads: Integer })
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionChatKitConfiguration < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration,
                OpenAI::Internal::AnyHash
              )
            end

          # Automatic thread titling preferences.
          sig do
            returns(OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling)
          end
          attr_reader :automatic_thread_titling

          sig do
            params(
              automatic_thread_titling:
                OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling::OrHash
            ).void
          end
          attr_writer :automatic_thread_titling

          # Upload settings for the session.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionFileUpload) }
          attr_reader :file_upload

          sig do
            params(
              file_upload: OpenAI::Beta::ChatKit::ChatSessionFileUpload::OrHash
            ).void
          end
          attr_writer :file_upload

          # History retention configuration.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionHistory) }
          attr_reader :history

          sig do
            params(
              history: OpenAI::Beta::ChatKit::ChatSessionHistory::OrHash
            ).void
          end
          attr_writer :history

          # ChatKit configuration for the session.
          sig do
            params(
              automatic_thread_titling:
                OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling::OrHash,
              file_upload: OpenAI::Beta::ChatKit::ChatSessionFileUpload::OrHash,
              history: OpenAI::Beta::ChatKit::ChatSessionHistory::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Automatic thread titling preferences.
            automatic_thread_titling:,
            # Upload settings for the session.
            file_upload:,
            # History retention configuration.
            history:
          )
          end

          sig do
            override.returns(
              {
                automatic_thread_titling:
                  OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling,
                file_upload: OpenAI::Beta::ChatKit::ChatSessionFileUpload,
                history: OpenAI::Beta::ChatKit::ChatSessionHistory
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end

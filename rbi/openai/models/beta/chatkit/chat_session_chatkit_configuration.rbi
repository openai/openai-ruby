# typed: strong

module OpenAI
  module Models

    module Beta

      module ChatKit

        class ChatSessionChatKitConfiguration < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration,
              OpenAI::Internal::AnyHash
            )
          end

          # Automatic thread titling preferences.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling) }
          attr_reader :automatic_thread_titling

          sig {
            params(automatic_thread_titling: OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling::OrHash).void
          }
          attr_writer :automatic_thread_titling

          # Upload settings for the session.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionFileUpload) }
          attr_reader :file_upload

          sig { params(file_upload: OpenAI::Beta::ChatKit::ChatSessionFileUpload::OrHash).void }
          attr_writer :file_upload

          # History retention configuration.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionHistory) }
          attr_reader :history

          sig { params(history: OpenAI::Beta::ChatKit::ChatSessionHistory::OrHash).void }
          attr_writer :history

          # ChatKit configuration for the session.
          sig do
            params(

              automatic_thread_titling: OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling::OrHash,

              file_upload: OpenAI::Beta::ChatKit::ChatSessionFileUpload::OrHash,

              history: OpenAI::Beta::ChatKit::ChatSessionHistory::OrHash
            )
              .returns(T.attached_class)
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
                automatic_thread_titling: OpenAI::Beta::ChatKit::ChatSessionAutomaticThreadTitling,
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

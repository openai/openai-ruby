# typed: strong

module OpenAI
  module Resources
    class Realtime
      class Translations
        class ClientSecrets
          sig do
            params(
              session:
                OpenAI::Realtime::RealtimeTranslationSessionCreateRequest::OrHash,
              expires_after:
                T.nilable(
                  OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::OrHash
                ),
              request_options: T.nilable(OpenAI::RequestOptions::OrHash)
            ).returns(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse
            )
          end
          def create(session:, expires_after: nil, request_options: nil)
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end

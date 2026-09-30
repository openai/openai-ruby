# typed: strong

module OpenAI
  module Models

    module Realtime

      module Translations

        class ClientSecretCreateParams < OpenAI::Models::Realtime::RealtimeTranslationClientSecretCreateRequest

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::Translations::ClientSecretCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig do
            params(

              session: OpenAI::Realtime::RealtimeTranslationSessionCreateRequest::OrHash,

              expires_after: OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::OrHash,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Realtime translation session configuration. Translation sessions stream source
            # audio in and translated audio plus transcript deltas out continuously.
            session:,

            # Configuration for the client secret expiration. Expiration refers to the time
            # after which a client secret will no longer be valid for creating sessions. The
            # session itself may continue after that time once started. A secret can be used
            # to create multiple sessions until it expires.
            expires_after: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                session: OpenAI::Realtime::RealtimeTranslationSessionCreateRequest,
                expires_after: OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter,
                request_options: OpenAI::RequestOptions
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

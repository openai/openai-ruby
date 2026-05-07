# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationClientSecretCreateResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Expiration timestamp for the client secret, in seconds since epoch.
        sig { returns(Integer) }
        attr_accessor :expires_at

        # A Realtime translation session. Translation sessions continuously translate
        # input audio into the configured output language.
        sig { returns(OpenAI::Realtime::RealtimeTranslationSession) }
        attr_reader :session

        sig do
          params(
            session: OpenAI::Realtime::RealtimeTranslationSession::OrHash
          ).void
        end
        attr_writer :session

        # The generated client secret value.
        sig { returns(String) }
        attr_accessor :value

        # Response from creating a translation session and client secret for the Realtime
        # API.
        sig do
          params(
            expires_at: Integer,
            session: OpenAI::Realtime::RealtimeTranslationSession::OrHash,
            value: String
          ).returns(T.attached_class)
        end
        def self.new(
          # Expiration timestamp for the client secret, in seconds since epoch.
          expires_at:,
          # A Realtime translation session. Translation sessions continuously translate
          # input audio into the configured output language.
          session:,
          # The generated client secret value.
          value:
        )
        end

        sig do
          override.returns(
            {
              expires_at: Integer,
              session: OpenAI::Realtime::RealtimeTranslationSession,
              value: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Realtime
      class ClientSecretCreateResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::Realtime::ClientSecretCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Expiration timestamp for the client secret, in seconds since epoch.
        sig { returns(Integer) }
        attr_accessor :expires_at

        # The session configuration for either a realtime or transcription session.
        sig do
          returns(
            OpenAI::Models::Realtime::ClientSecretCreateResponse::Session::Variants
          )
        end
        attr_accessor :session

        # The generated client secret value.
        sig { returns(String) }
        attr_accessor :value

        # Response from creating a session and client secret for the Realtime API.
        sig do
          params(
            expires_at: Integer,
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateResponse::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse::OrHash
              ),
            value: String
          ).returns(T.attached_class)
        end
        def self.new(
          # Expiration timestamp for the client secret, in seconds since epoch.
          expires_at:,
          # The session configuration for either a realtime or transcription session.
          session:,
          # The generated client secret value.
          value:
        )
        end

        sig do
          override.returns(
            {
              expires_at: Integer,
              session:
                OpenAI::Models::Realtime::ClientSecretCreateResponse::Session::Variants,
              value: String
            }
          )
        end
        def to_hash
        end

        # The session configuration for either a realtime or transcription session.
        module Session
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateResponse,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Models::Realtime::ClientSecretCreateResponse::Session::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end

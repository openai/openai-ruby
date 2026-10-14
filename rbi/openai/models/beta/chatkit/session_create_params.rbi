# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class SessionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::SessionCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # A free-form string that identifies your end user; ensures this Session can
          # access other objects that have the same `user` scope.
          sig { returns(String) }
          attr_accessor :user

          # Workflow that powers the session.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionWorkflowParam) }
          attr_reader :workflow

          sig do
            params(
              workflow: OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::OrHash
            ).void
          end
          attr_writer :workflow

          # Optional overrides for ChatKit runtime configuration features
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam
              )
            )
          end
          attr_reader :chatkit_configuration

          sig do
            params(
              chatkit_configuration:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::OrHash
            ).void
          end
          attr_writer :chatkit_configuration

          # Optional override for session expiration timing in seconds from creation.
          # Defaults to 10 minutes.
          sig do
            returns(
              T.nilable(OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam)
            )
          end
          attr_reader :expires_after

          sig do
            params(
              expires_after:
                OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam::OrHash
            ).void
          end
          attr_writer :expires_after

          # Optional override for per-minute request limits. When omitted, defaults to 10.
          sig do
            returns(
              T.nilable(OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam)
            )
          end
          attr_reader :rate_limits

          sig do
            params(
              rate_limits:
                OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam::OrHash
            ).void
          end
          attr_writer :rate_limits

          sig do
            params(
              user: String,
              workflow: OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::OrHash,
              chatkit_configuration:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam::OrHash,
              expires_after:
                OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam::OrHash,
              rate_limits:
                OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam::OrHash,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # A free-form string that identifies your end user; ensures this Session can
            # access other objects that have the same `user` scope.
            user:,
            # Workflow that powers the session.
            workflow:,
            # Optional overrides for ChatKit runtime configuration features
            chatkit_configuration: nil,
            # Optional override for session expiration timing in seconds from creation.
            # Defaults to 10 minutes.
            expires_after: nil,
            # Optional override for per-minute request limits. When omitted, defaults to 10.
            rate_limits: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                user: String,
                workflow: OpenAI::Beta::ChatKit::ChatSessionWorkflowParam,
                chatkit_configuration:
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam,
                expires_after:
                  OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam,
                rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam,
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

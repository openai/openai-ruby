# typed: strong

module OpenAI
  module Resources
    class Beta
      class ChatKit
        class Sessions
          # Create a ChatKit session
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
            ).returns(OpenAI::Beta::ChatKit::ChatSession)
          end
          def create(
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

          # Cancel a ChatKit session
          sig do
            params(
              session_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::ChatKit::ChatSession)
          end
          def cancel(
            # Unique identifier for the ChatKit session to cancel.
            session_id,
            request_options: {}
          )
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

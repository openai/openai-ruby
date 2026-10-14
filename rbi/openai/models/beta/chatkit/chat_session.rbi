# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSession < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatSession,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the ChatKit session.
          sig { returns(String) }
          attr_accessor :id

          # Resolved ChatKit feature configuration for the session.
          sig do
            returns(OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration)
          end
          attr_reader :chatkit_configuration

          sig do
            params(
              chatkit_configuration:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration::OrHash
            ).void
          end
          attr_writer :chatkit_configuration

          # Ephemeral client secret that authenticates session requests.
          sig { returns(String) }
          attr_accessor :client_secret

          # Unix timestamp (in seconds) for when the session expires.
          sig { returns(Integer) }
          attr_accessor :expires_at

          # Convenience copy of the per-minute request limit.
          sig { returns(Integer) }
          attr_accessor :max_requests_per_1_minute

          # Type discriminator that is always `chatkit.session`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Resolved rate limit values.
          sig { returns(OpenAI::Beta::ChatKit::ChatSessionRateLimits) }
          attr_reader :rate_limits

          sig do
            params(
              rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimits::OrHash
            ).void
          end
          attr_writer :rate_limits

          # Current lifecycle state of the session.
          sig do
            returns(OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol)
          end
          attr_accessor :status

          # User identifier associated with the session.
          sig { returns(String) }
          attr_accessor :user

          # Workflow metadata for the session.
          sig { returns(OpenAI::Beta::ChatKitWorkflow) }
          attr_reader :workflow

          sig { params(workflow: OpenAI::Beta::ChatKitWorkflow::OrHash).void }
          attr_writer :workflow

          # Represents a ChatKit session and its resolved configuration.
          sig do
            params(
              id: String,
              chatkit_configuration:
                OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration::OrHash,
              client_secret: String,
              expires_at: Integer,
              max_requests_per_1_minute: Integer,
              rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimits::OrHash,
              status: OpenAI::Beta::ChatKit::ChatSessionStatus::OrSymbol,
              user: String,
              workflow: OpenAI::Beta::ChatKitWorkflow::OrHash,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the ChatKit session.
            id:,
            # Resolved ChatKit feature configuration for the session.
            chatkit_configuration:,
            # Ephemeral client secret that authenticates session requests.
            client_secret:,
            # Unix timestamp (in seconds) for when the session expires.
            expires_at:,
            # Convenience copy of the per-minute request limit.
            max_requests_per_1_minute:,
            # Resolved rate limit values.
            rate_limits:,
            # Current lifecycle state of the session.
            status:,
            # User identifier associated with the session.
            user:,
            # Workflow metadata for the session.
            workflow:,
            # Type discriminator that is always `chatkit.session`.
            object: :"chatkit.session"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                chatkit_configuration:
                  OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration,
                client_secret: String,
                expires_at: Integer,
                max_requests_per_1_minute: Integer,
                object: Symbol,
                rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimits,
                status: OpenAI::Beta::ChatKit::ChatSessionStatus::TaggedSymbol,
                user: String,
                workflow: OpenAI::Beta::ChatKitWorkflow
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

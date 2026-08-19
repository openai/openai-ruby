# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSession < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier for the ChatKit session.
          #
          #   @return [String]
          required :id, String

          # @!attribute chatkit_configuration
          #   Resolved ChatKit feature configuration for the session.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfiguration]
          required :chatkit_configuration, -> { OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration }

          # @!attribute client_secret
          #   Ephemeral client secret that authenticates session requests.
          #
          #   @return [String]
          required :client_secret, String

          # @!attribute expires_at
          #   Unix timestamp (in seconds) for when the session expires.
          #
          #   @return [Integer]
          required :expires_at, Integer

          # @!attribute max_requests_per_1_minute
          #   Convenience copy of the per-minute request limit.
          #
          #   @return [Integer]
          required :max_requests_per_1_minute, Integer

          # @!attribute object
          #   Type discriminator that is always `chatkit.session`.
          #
          #   @return [Symbol, :"chatkit.session"]
          required :object, const: :"chatkit.session"

          # @!attribute rate_limits
          #   Resolved rate limit values.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionRateLimits]
          required :rate_limits, -> { OpenAI::Beta::ChatKit::ChatSessionRateLimits }

          # @!attribute status
          #   Current lifecycle state of the session.
          #
          #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ChatSessionStatus]
          required :status, enum: -> { OpenAI::Beta::ChatKit::ChatSessionStatus }

          # @!attribute user
          #   User identifier associated with the session.
          #
          #   @return [String]
          required :user, String

          # @!attribute workflow
          #   Workflow metadata for the session.
          #
          #   @return [OpenAI::Models::Beta::ChatKitWorkflow]
          required :workflow, -> { OpenAI::Beta::ChatKitWorkflow }

          # @!method initialize(id:, chatkit_configuration:, client_secret:, expires_at:, max_requests_per_1_minute:, rate_limits:, status:, user:, workflow:, object: :"chatkit.session")
          #   Represents a ChatKit session and its resolved configuration.
          #
          #   @param id [String] Identifier for the ChatKit session.
          #
          #   @param chatkit_configuration [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfiguration] Resolved ChatKit feature configuration for the session.
          #
          #   @param client_secret [String] Ephemeral client secret that authenticates session requests.
          #
          #   @param expires_at [Integer] Unix timestamp (in seconds) for when the session expires.
          #
          #   @param max_requests_per_1_minute [Integer] Convenience copy of the per-minute request limit.
          #
          #   @param rate_limits [OpenAI::Models::Beta::ChatKit::ChatSessionRateLimits] Resolved rate limit values.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::ChatKit::ChatSessionStatus] Current lifecycle state of the session.
          #
          #   @param user [String] User identifier associated with the session.
          #
          #   @param workflow [OpenAI::Models::Beta::ChatKitWorkflow] Workflow metadata for the session.
          #
          #   @param object [Symbol, :"chatkit.session"] Type discriminator that is always `chatkit.session`.
        end
      end
    end
  end
end

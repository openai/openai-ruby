# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        # @see OpenAI::Resources::Beta::ChatKit::Sessions#create
        class SessionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute user
          #   A free-form string that identifies your end user; ensures this Session can
          #   access other objects that have the same `user` scope.
          #
          #   @return [String]
          required :user, String

          # @!attribute workflow
          #   Workflow that powers the session.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam]
          required :workflow, -> { OpenAI::Beta::ChatKit::ChatSessionWorkflowParam }

          # @!attribute chatkit_configuration
          #   Optional overrides for ChatKit runtime configuration features
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam, nil]
          optional :chatkit_configuration, -> { OpenAI::Beta::ChatKit::ChatSessionChatKitConfigurationParam }

          # @!attribute expires_after
          #   Optional override for session expiration timing in seconds from creation.
          #   Defaults to 10 minutes.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionExpiresAfterParam, nil]
          optional :expires_after, -> { OpenAI::Beta::ChatKit::ChatSessionExpiresAfterParam }

          # @!attribute rate_limits
          #   Optional override for per-minute request limits. When omitted, defaults to 10.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionRateLimitsParam, nil]
          optional :rate_limits, -> { OpenAI::Beta::ChatKit::ChatSessionRateLimitsParam }

          # @!method initialize(user:, workflow:, chatkit_configuration: nil, expires_after: nil, rate_limits: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::SessionCreateParams} for more details.
          #
          #   @param user [String] A free-form string that identifies your end user; ensures this Session can acces
          #
          #   @param workflow [OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam] Workflow that powers the session.
          #
          #   @param chatkit_configuration [OpenAI::Models::Beta::ChatKit::ChatSessionChatKitConfigurationParam] Optional overrides for ChatKit runtime configuration features
          #
          #   @param expires_after [OpenAI::Models::Beta::ChatKit::ChatSessionExpiresAfterParam] Optional override for session expiration timing in seconds from creation. Defaul
          #
          #   @param rate_limits [OpenAI::Models::Beta::ChatKit::ChatSessionRateLimitsParam] Optional override for per-minute request limits. When omitted, defaults to 10.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end

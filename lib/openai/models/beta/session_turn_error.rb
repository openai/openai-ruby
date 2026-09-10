# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class SessionTurnError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   A stable, machine-readable failure category.
        #
        #   @return [Symbol, OpenAI::Models::Beta::SessionTurnError::Code]
        required :code, enum: -> { OpenAI::Beta::SessionTurnError::Code }

        # @!attribute message
        #   A customer-safe explanation of the failure.
        #
        #   @return [String]
        required :message, String

        # @!method initialize(code:, message:)
        #   A customer-safe error describing why a session request failed.
        #
        #   @param code [Symbol, OpenAI::Models::Beta::SessionTurnError::Code]
        #     A stable, machine-readable failure category.
        #
        #   @param message [String]
        #     A customer-safe explanation of the failure.

        # A stable, machine-readable failure category.
        #
        # @see OpenAI::Models::Beta::SessionTurnError#code
        module Code
          extend OpenAI::Internal::Type::Enum

          # The request exceeds the model's context window.
          CONTEXT_LENGTH_EXCEEDED = :context_length_exceeded

          # The session has reached its usage budget.
          SESSION_BUDGET_EXCEEDED = :session_budget_exceeded

          # The organization has reached a usage, plan, or billing limit.
          USAGE_LIMIT_EXCEEDED = :usage_limit_exceeded

          # The request exceeds the available rate limit.
          RATE_LIMIT_EXCEEDED = :rate_limit_exceeded

          # The model service is temporarily overloaded.
          SERVER_OVERLOADED = :server_overloaded

          # The request was rejected by a safety policy.
          CYBER_POLICY = :cyber_policy

          # The request could not connect to the model service.
          CONNECTION_FAILED = :connection_failed

          # The model service encountered an unexpected error.
          SERVER_ERROR = :server_error

          # The API credentials are invalid or lack the required access.
          AUTHENTICATION_ERROR = :authentication_error

          # The request contains invalid input or configuration.
          INVALID_REQUEST = :invalid_request

          # The requested model or resource is unavailable.
          RESOURCE_NOT_FOUND = :resource_not_found

          # The request could not complete in its execution environment.
          SANDBOX_ERROR = :sandbox_error

          # The executor must be upgraded before it can run this turn.
          EXECUTOR_VERSION_INCOMPATIBLE = :executor_version_incompatible

          # The session cannot accept additional input while a request is running.
          ACTIVE_TURN_NOT_STEERABLE = :active_turn_not_steerable

          # The request timed out before the model service responded.
          REQUEST_TIMEOUT = :request_timeout

          # An unexpected internal error prevented the session request from completing.
          INTERNAL_ERROR = :internal_error

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

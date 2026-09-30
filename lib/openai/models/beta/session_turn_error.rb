# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class SessionTurnError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   A stable, machine-readable failure category.
        #
        #   @return [Symbol, OpenAI::Models::Beta::SessionTurnError::Code]
        required :code, union: -> { OpenAI::Beta::SessionTurnError::Code }

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
          extend OpenAI::Internal::Type::Union

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::CONTEXT_LENGTH_EXCEEDED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::SESSION_BUDGET_EXCEEDED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::USAGE_LIMIT_EXCEEDED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::CREDIT_BALANCE_EXHAUSTED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::RATE_LIMIT_EXCEEDED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::FLEX_UNAVAILABLE }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::SERVER_OVERLOADED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::CYBER_POLICY }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::MISALIGNMENT_POLICY_VIOLATION }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::CONNECTION_FAILED }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::SERVER_ERROR }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::AUTHENTICATION_ERROR }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::INVALID_REQUEST }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::RESOURCE_NOT_FOUND }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::SANDBOX_ERROR }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::EXECUTOR_VERSION_INCOMPATIBLE }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::ACTIVE_TURN_NOT_STEERABLE }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::REQUEST_TIMEOUT }

          variant const: -> { OpenAI::Models::Beta::SessionTurnError::Code::INTERNAL_ERROR }

          # @!method self.variants
          #   @return [Array(Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { OpenAI::Beta::SessionTurnError::Code::TaggedSymbol }
          end

          # @!group

          CONTEXT_LENGTH_EXCEEDED = :context_length_exceeded
          SESSION_BUDGET_EXCEEDED = :session_budget_exceeded
          USAGE_LIMIT_EXCEEDED = :usage_limit_exceeded
          CREDIT_BALANCE_EXHAUSTED = :credit_balance_exhausted
          RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
          FLEX_UNAVAILABLE = :flex_unavailable
          SERVER_OVERLOADED = :server_overloaded
          CYBER_POLICY = :cyber_policy
          MISALIGNMENT_POLICY_VIOLATION = :misalignment_policy_violation
          CONNECTION_FAILED = :connection_failed
          SERVER_ERROR = :server_error
          AUTHENTICATION_ERROR = :authentication_error
          INVALID_REQUEST = :invalid_request
          RESOURCE_NOT_FOUND = :resource_not_found
          SANDBOX_ERROR = :sandbox_error
          EXECUTOR_VERSION_INCOMPATIBLE = :executor_version_incompatible
          ACTIVE_TURN_NOT_STEERABLE = :active_turn_not_steerable
          REQUEST_TIMEOUT = :request_timeout
          INTERNAL_ERROR = :internal_error

          # @!endgroup
        end
      end
    end
  end
end

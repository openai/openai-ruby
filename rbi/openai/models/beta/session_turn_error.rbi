# typed: strong

module OpenAI
  module Models

    module Beta

      class SessionTurnError < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::SessionTurnError,
            OpenAI::Internal::AnyHash
          )
        end

        # A stable, machine-readable failure category.
        sig { returns(OpenAI::Beta::SessionTurnError::Code::TaggedSymbol) }
        attr_accessor :code

        # A customer-safe explanation of the failure.
        sig { returns(String) }
        attr_accessor :message

        # A customer-safe error describing why a session request failed.
        sig do
          params(

            code: OpenAI::Beta::SessionTurnError::Code::OrSymbol,

            message: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A stable, machine-readable failure category.
          code:,

          # A customer-safe explanation of the failure.

          message:
        )
        end

        sig do
          override.returns(
            {code: OpenAI::Beta::SessionTurnError::Code::TaggedSymbol, message: String}
          )
        end
        def to_hash
        end

        # A stable, machine-readable failure category.
        module Code
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::SessionTurnError::Code) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # The request exceeds the model's context window.
          CONTEXT_LENGTH_EXCEEDED = T.let(:context_length_exceeded, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The session has reached its usage budget.
          SESSION_BUDGET_EXCEEDED = T.let(:session_budget_exceeded, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The organization has reached a usage, plan, or billing limit.
          USAGE_LIMIT_EXCEEDED = T.let(:usage_limit_exceeded, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The request exceeds the available rate limit.
          RATE_LIMIT_EXCEEDED = T.let(:rate_limit_exceeded, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The model service is temporarily overloaded.
          SERVER_OVERLOADED = T.let(:server_overloaded, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The request was rejected by a safety policy.
          CYBER_POLICY = T.let(:cyber_policy, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The request could not connect to the model service.
          CONNECTION_FAILED = T.let(:connection_failed, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The model service encountered an unexpected error.
          SERVER_ERROR = T.let(:server_error, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The API credentials are invalid or lack the required access.
          AUTHENTICATION_ERROR = T.let(:authentication_error, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The request contains invalid input or configuration.
          INVALID_REQUEST = T.let(:invalid_request, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The requested model or resource is unavailable.
          RESOURCE_NOT_FOUND = T.let(:resource_not_found, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The request could not complete in its execution environment.
          SANDBOX_ERROR = T.let(:sandbox_error, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # The executor must be upgraded before it can run this turn.
          EXECUTOR_VERSION_INCOMPATIBLE = T.let(
            :executor_version_incompatible,
            OpenAI::Beta::SessionTurnError::Code::TaggedSymbol
          )

          # The session cannot accept additional input while a request is running.
          ACTIVE_TURN_NOT_STEERABLE = T.let(
            :active_turn_not_steerable,
            OpenAI::Beta::SessionTurnError::Code::TaggedSymbol
          )

          # The request timed out before the model service responded.
          REQUEST_TIMEOUT = T.let(:request_timeout, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          # An unexpected internal error prevented the session request from completing.
          INTERNAL_ERROR = T.let(:internal_error, OpenAI::Beta::SessionTurnError::Code::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::SessionTurnError::Code::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end

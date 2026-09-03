# typed: strong

module OpenAI
  module Models

    BetaResponseSteerErrorCode = Beta::BetaResponseSteerErrorCode

    module Beta

      # A machine-readable steering error code. Clients should handle unknown values
      # because additional codes may be introduced. Known values include:
      #
      # - `response_not_found`: The target response is not available on this connection.
      # - `invalid_input`: The event or input failed validation.
      # - `steering_not_supported`: The model or response execution mode does not
      #   support steering.
      # - `too_many_pending_steers`: Too much steering input is pending for the
      #   response.
      # - `response_already_completed`: The response completed and is no longer
      #   accepting steering input.
      # - `response_not_active`: The response is no longer accepting steering input.
      # - `successor_creation_failed`: The successor response could not be created.
      module BetaResponseSteerErrorCode
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol,
            String
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::BetaResponseSteerErrorCode::Variants]) }
        def self.variants
        end

        TaggedSymbol = T.type_alias do
          T.all(Symbol, OpenAI::Beta::BetaResponseSteerErrorCode)
        end

        OrSymbol = T.type_alias { T.any(Symbol, String) }

        RESPONSE_NOT_FOUND = T.let(:response_not_found, OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol)
        INVALID_INPUT = T.let(:invalid_input, OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol)
        STEERING_NOT_SUPPORTED = T.let(:steering_not_supported, OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol)
        TOO_MANY_PENDING_STEERS = T.let(
          :too_many_pending_steers,
          OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol
        )
        RESPONSE_ALREADY_COMPLETED = T.let(
          :response_already_completed,
          OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol
        )
        RESPONSE_NOT_ACTIVE = T.let(:response_not_active, OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol)
        SUCCESSOR_CREATION_FAILED = T.let(
          :successor_creation_failed,
          OpenAI::Beta::BetaResponseSteerErrorCode::TaggedSymbol
        )

      end

    end

  end
end

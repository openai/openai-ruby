# typed: strong

module OpenAI
  module Models

    module Responses

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
      module ResponseSteerErrorCode
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol,
            String
          )
        end

        sig { override.returns(T::Array[OpenAI::Responses::ResponseSteerErrorCode::Variants]) }
        def self.variants
        end

        TaggedSymbol = T.type_alias do
          T.all(Symbol, OpenAI::Responses::ResponseSteerErrorCode)
        end

        OrSymbol = T.type_alias { T.any(Symbol, String) }

        RESPONSE_NOT_FOUND = T.let(:response_not_found, OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol)
        INVALID_INPUT = T.let(:invalid_input, OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol)
        STEERING_NOT_SUPPORTED = T.let(:steering_not_supported, OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol)
        TOO_MANY_PENDING_STEERS = T.let(
          :too_many_pending_steers,
          OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol
        )
        RESPONSE_ALREADY_COMPLETED = T.let(
          :response_already_completed,
          OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol
        )
        RESPONSE_NOT_ACTIVE = T.let(:response_not_active, OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol)
        SUCCESSOR_CREATION_FAILED = T.let(
          :successor_creation_failed,
          OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol
        )

      end

    end

  end
end

# frozen_string_literal: true

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

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::RESPONSE_NOT_FOUND }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::INVALID_INPUT }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::STEERING_NOT_SUPPORTED }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::TOO_MANY_PENDING_STEERS }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::RESPONSE_ALREADY_COMPLETED }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::RESPONSE_NOT_ACTIVE }

        variant const: -> { OpenAI::Models::Responses::ResponseSteerErrorCode::SUCCESSOR_CREATION_FAILED }

        variant String

        # @!method self.variants
        #   @return [Array(Symbol, String)]

        define_sorbet_constant!(:Variants) do
          T.type_alias { T.any(OpenAI::Responses::ResponseSteerErrorCode::TaggedSymbol, String) }
        end

        # @!group

        RESPONSE_NOT_FOUND = :response_not_found
        INVALID_INPUT = :invalid_input
        STEERING_NOT_SUPPORTED = :steering_not_supported
        TOO_MANY_PENDING_STEERS = :too_many_pending_steers
        RESPONSE_ALREADY_COMPLETED = :response_already_completed
        RESPONSE_NOT_ACTIVE = :response_not_active
        SUCCESSOR_CREATION_FAILED = :successor_creation_failed

        # @!endgroup
      end
    end
  end
end

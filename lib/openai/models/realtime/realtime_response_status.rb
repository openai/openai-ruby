# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseStatus < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   A description of the error that caused the response to fail, populated when the
        #   `status` is `failed`.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseStatus::Error, nil]
        optional :error, -> { OpenAI::Realtime::RealtimeResponseStatus::Error }

        # @!attribute reason
        #   The reason the Response did not complete. For a `cancelled` Response, one of
        #   `turn_detected` (the server VAD detected a new start of speech) or
        #   `client_cancelled` (the client sent a cancel event). For an `incomplete`
        #   Response, one of `max_output_tokens` or `content_filter` (the server-side safety
        #   filter activated and cut off the response).
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeResponseStatus::Reason, nil]
        optional :reason, enum: -> { OpenAI::Realtime::RealtimeResponseStatus::Reason }

        # @!attribute type
        #   The type of error that caused the response to fail, corresponding with the
        #   `status` field (`completed`, `cancelled`, `incomplete`, `failed`).
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeResponseStatus::Type, nil]
        optional :type, enum: -> { OpenAI::Realtime::RealtimeResponseStatus::Type }

        # @!method initialize(error: nil, reason: nil, type: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeResponseStatus} for more details.
        #
        #   Additional details about the status.
        #
        #   @param error [OpenAI::Models::Realtime::RealtimeResponseStatus::Error] A description of the error that caused the response to fail,
        #
        #   @param reason [Symbol, OpenAI::Models::Realtime::RealtimeResponseStatus::Reason] The reason the Response did not complete. For a `cancelled` Response, one of `t
        #
        #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeResponseStatus::Type] The type of error that caused the response to fail, corresponding

        # @see OpenAI::Models::Realtime::RealtimeResponseStatus#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   Error code, if any.
          #
          #   @return [String, nil]
          optional :code, String

          # @!attribute type
          #   The type of error.
          #
          #   @return [String, nil]
          optional :type, String

          # @!method initialize(code: nil, type: nil)
          #   A description of the error that caused the response to fail, populated when the
          #   `status` is `failed`.
          #
          #   @param code [String] Error code, if any.
          #
          #   @param type [String] The type of error.
        end

        # The reason the Response did not complete. For a `cancelled` Response, one of
        # `turn_detected` (the server VAD detected a new start of speech) or
        # `client_cancelled` (the client sent a cancel event). For an `incomplete`
        # Response, one of `max_output_tokens` or `content_filter` (the server-side safety
        # filter activated and cut off the response).
        #
        # @see OpenAI::Models::Realtime::RealtimeResponseStatus#reason
        module Reason
          extend OpenAI::Internal::Type::Enum

          TURN_DETECTED = :turn_detected
          CLIENT_CANCELLED = :client_cancelled
          MAX_OUTPUT_TOKENS = :max_output_tokens
          CONTENT_FILTER = :content_filter

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of error that caused the response to fail, corresponding with the
        # `status` field (`completed`, `cancelled`, `incomplete`, `failed`).
        #
        # @see OpenAI::Models::Realtime::RealtimeResponseStatus#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPLETED = :completed
          CANCELLED = :cancelled
          INCOMPLETE = :incomplete
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

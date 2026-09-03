# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseSteerFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   Information about why the input could not be committed.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Error]
        required :error, -> { OpenAI::Beta::BetaResponseSteerFailedEvent::Error }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute steer
        #   The steering submission that could not be committed.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Steer]
        required :steer, -> { OpenAI::Beta::BetaResponseSteerFailedEvent::Steer }

        # @!attribute type
        #   The event discriminator. Always `response.steer.failed`.
        #
        #   @return [Symbol, :"response.steer.failed"]
        required :type, const: :"response.steer.failed"

        # @!attribute stream_id
        #   The WebSocket lane that emitted this event, when the target response is
        #   available and its `response.create` event supplied a `stream_id`.
        #
        #   @return [String, nil]
        optional :stream_id, String

        # @!method initialize(error:, sequence_number:, steer:, stream_id: nil, type: :"response.steer.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseSteerFailedEvent} for more details.
        #
        #   Emitted when steering input is rejected or cannot be committed to a successor
        #   response. Returns the original, uncommitted input so the client can carry it
        #   into `response.create` when appropriate. Invalid input must be corrected before
        #   retrying.
        #
        #   Failures after acceptance include the same steering ID. Failures before an ID is
        #   allocated omit `steer.id`. A lost connection or missing acknowledgement leaves
        #   the outcome unknown; it is not proof that the input was rejected.
        #
        #   @param error [OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Error] Information about why the input could not be committed.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param steer [OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Steer] The steering submission that could not be committed.
        #
        #   @param stream_id [String] The WebSocket lane that emitted this event, when the target response is
        #
        #   @param type [Symbol, :"response.steer.failed"] The event discriminator. Always `response.steer.failed`.

        # @see OpenAI::Models::Beta::BetaResponseSteerFailedEvent#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   A machine-readable steering error code. Clients should handle unknown values
          #   because additional codes may be introduced. Known values include:
          #
          #   - `response_not_found`: The target response is not available on this connection.
          #   - `invalid_input`: The event or input failed validation.
          #   - `steering_not_supported`: The model or response execution mode does not
          #     support steering.
          #   - `too_many_pending_steers`: Too much steering input is pending for the
          #     response.
          #   - `response_already_completed`: The response completed and is no longer
          #     accepting steering input.
          #   - `response_not_active`: The response is no longer accepting steering input.
          #   - `successor_creation_failed`: The successor response could not be created.
          #
          #   @return [Symbol, String, OpenAI::Models::Beta::BetaResponseSteerErrorCode]
          required :code, union: -> { OpenAI::Beta::BetaResponseSteerErrorCode }

          # @!attribute message
          #   A human-readable description of the error.
          #
          #   @return [String]
          required :message, String

          # @!attribute type
          #   The error type. Always `invalid_request_error`.
          #
          #   @return [Symbol, :invalid_request_error]
          required :type, const: :invalid_request_error

          # @!method initialize(code:, message:, type: :invalid_request_error)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Error} for more details.
          #
          #   Information about why the input could not be committed.
          #
          #   @param code [Symbol, String, OpenAI::Models::Beta::BetaResponseSteerErrorCode] A machine-readable steering error code. Clients should handle unknown
          #
          #   @param message [String] A human-readable description of the error.
          #
          #   @param type [Symbol, :invalid_request_error] The error type. Always `invalid_request_error`.
        end

        # @see OpenAI::Models::Beta::BetaResponseSteerFailedEvent#steer
        class Steer < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   Input to queue for a continuation of the response. Uses the same string or
          #   input-item shape as `response.create.input`, with a non-empty array when
          #   supplying input items.
          #
          #   Steering accepts only messages with the `user` role. Each message may contain
          #   only `type`, `role`, and `content`, with `content` as a string or an array of
          #   `input_text`, `input_image`, and `input_file` parts. The optional `type` must be
          #   `message`. Other roles, tool outputs, and item types are not supported for
          #   steering.
          #
          #   @return [String, Array<Hash{Symbol=>Object}>]
          required :input, union: -> { OpenAI::Beta::BetaResponseSteerInput }

          # @!attribute previous_response_id
          #   The ID of the response that was targeted for steering.
          #
          #   @return [String]
          required :previous_response_id, String

          # @!attribute id
          #   The ID assigned to the steering submission, if one was allocated.
          #
          #   @return [String, nil]
          optional :id, String

          # @!method initialize(input:, previous_response_id:, id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseSteerFailedEvent::Steer} for more details.
          #
          #   The steering submission that could not be committed.
          #
          #   @param input [String, Array<Hash{Symbol=>Object}>] Input to queue for a continuation of the response. Uses the same string or
          #
          #   @param previous_response_id [String] The ID of the response that was targeted for steering.
          #
          #   @param id [String] The ID assigned to the steering submission, if one was allocated.
        end
      end
    end

    BetaResponseSteerFailedEvent = Beta::BetaResponseSteerFailedEvent
  end
end

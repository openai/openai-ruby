# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseSteerPendingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute reason
        #   An extensible enum describing why accepted steering input is still queued.
        #   Clients should handle unknown values because additional reasons may be
        #   introduced. Known values include:
        #
        #   - `waiting_for_required_input`: The response is waiting for the tool results or
        #     approval decisions identified by `required_input`.
        #
        #   @return [Symbol, :waiting_for_required_input, String]
        required :reason, union: -> { OpenAI::Responses::ResponseSteerPendingReason }

        # @!attribute required_input
        #   Input stubs identifying outstanding client-owned tool results or approval
        #   decisions. Each stub contains identifying fields only; the client supplies the
        #   result before including it in `response.create`.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseSteerRequiredInput::FunctionCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::CustomToolCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ComputerCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ShellCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ToolSearchOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::McpApprovalResponse>]
        required(
          :required_input,
          -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseSteerRequiredInput] }
        )

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute steer
        #   The steering submission that remains queued.
        #
        #   @return [OpenAI::Models::Responses::ResponseSteerPendingEvent::Steer]
        required :steer, -> { OpenAI::Responses::ResponseSteerPendingEvent::Steer }

        # @!attribute type
        #   The event discriminator. Always `response.steer.pending`.
        #
        #   @return [Symbol, :"response.steer.pending"]
        required :type, const: :"response.steer.pending"

        # @!attribute stream_id
        #   The WebSocket lane that emitted this event. This field is present when the
        #   target response's `response.create` event supplied a `stream_id`.
        #
        #   @return [String, nil]
        optional :stream_id, String

        # @!method initialize(reason:, required_input:, sequence_number:, steer:, stream_id: nil, type: :"response.steer.pending")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseSteerPendingEvent} for more details.
        #
        #   Emitted when accepted steering input remains queued after the target response
        #   completes. The server still owns the input. Do not resend it. The successor's
        #   `response.created` event is the commit point.
        #
        #   When `reason` is `waiting_for_required_input`, this event follows
        #   `response.completed` while the response waits for the tool results or approval
        #   decisions identified by `required_input`. Copy those stubs, fill their result
        #   fields using the ordinary `response.create` input schemas, and submit one
        #   continuation per parent with the same `previous_response_id` and WebSocket lane.
        #   Use saved results without rerunning tools. The queued steering input is
        #   prepended in submission order to the continuation's input. That explicit request
        #   retains its own settings.
        #
        #   This notification is emitted at most once per steering submission. Multiple
        #   submissions for the same parent can report the same required inputs; they do not
        #   each require a separate continuation.
        #
        #   @param reason [Symbol, :waiting_for_required_input, String] An extensible enum describing why accepted steering input is still queued.
        #
        #   @param required_input [Array<OpenAI::Models::Responses::ResponseSteerRequiredInput::FunctionCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::CustomToolCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ComputerCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ShellCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::ToolSearchOutput, OpenAI::Models::Responses::ResponseSteerRequiredInput::McpApprovalResponse>] Input stubs identifying outstanding client-owned tool results or
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param steer [OpenAI::Models::Responses::ResponseSteerPendingEvent::Steer] The steering submission that remains queued.
        #
        #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present when
        #
        #   @param type [Symbol, :"response.steer.pending"] The event discriminator. Always `response.steer.pending`.

        # @see OpenAI::Models::Responses::ResponseSteerPendingEvent#steer
        class Steer < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID assigned to the steering submission.
          #
          #   @return [String]
          required :id, String

          # @!attribute previous_response_id
          #   The ID of the response being steered.
          #
          #   @return [String]
          required :previous_response_id, String

          # @!method initialize(id:, previous_response_id:)
          #   The steering submission that remains queued.
          #
          #   @param id [String] The ID assigned to the steering submission.
          #
          #   @param previous_response_id [String] The ID of the response being steered.
        end
      end
    end
  end
end

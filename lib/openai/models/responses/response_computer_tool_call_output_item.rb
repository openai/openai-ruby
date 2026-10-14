# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the computer call tool output.
        #
        #   @return [String]
        required :id, String

        # @!attribute call_id
        #   The ID of the computer tool call that produced the output.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute output
        #   A computer screenshot image used with the computer use tool.
        #
        #   @return [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot]
        required :output, -> { OpenAI::Responses::ResponseComputerToolCallOutputScreenshot }

        # @!attribute status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseComputerToolCallOutputItem::Status }

        # @!attribute type
        #   The type of the computer tool call output. Always `computer_call_output`.
        #
        #   @return [Symbol, :computer_call_output]
        required :type, const: :computer_call_output

        # @!attribute acknowledged_safety_checks
        #   The safety checks reported by the API that have been acknowledged by the
        #   developer.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>, nil]
        optional :acknowledged_safety_checks,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck] }

        # @!attribute created_by
        #   The identifier of the actor that created the item.
        #
        #   @return [String, nil]
        optional :created_by, String

        # @!method initialize(id:, call_id:, output:, status:, acknowledged_safety_checks: nil, created_by: nil, type: :computer_call_output)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseComputerToolCallOutputItem} for more
        #   details.
        #
        #   @param id [String] The unique ID of the computer call tool output.
        #
        #   @param call_id [String] The ID of the computer tool call that produced the output.
        #
        #   @param output [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot] A computer screenshot image used with the computer use tool.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status] The status of the message input. One of `in_progress`, `completed`, or
        #
        #   @param acknowledged_safety_checks [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>] The safety checks reported by the API that have been acknowledged by the
        #
        #   @param created_by [String] The identifier of the actor that created the item.
        #
        #   @param type [Symbol, :computer_call_output] The type of the computer tool call output. Always `computer_call_output`.

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseComputerToolCallOutputItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          COMPLETED = :completed
          INCOMPLETE = :incomplete
          FAILED = :failed
          IN_PROGRESS = :in_progress

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the pending safety check.
          #
          #   @return [String]
          required :id, String

          # @!attribute code
          #   The type of the pending safety check.
          #
          #   @return [String, nil]
          optional :code, String, nil?: true

          # @!attribute message
          #   Details about the pending safety check.
          #
          #   @return [String, nil]
          optional :message, String, nil?: true

          # @!method initialize(id:, code: nil, message: nil)
          #   A pending safety check for the computer call.
          #
          #   @param id [String] The ID of the pending safety check.
          #
          #   @param code [String, nil] The type of the pending safety check.
          #
          #   @param message [String, nil] Details about the pending safety check.
        end
      end
    end
  end
end

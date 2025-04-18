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
        required :output, -> { OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot }

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
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck] }

        # @!attribute status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status }

        # @!method initialize(id:, call_id:, output:, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output)
        #   @param id [String]
        #   @param call_id [String]
        #   @param output [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot]
        #   @param acknowledged_safety_checks [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>]
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status]
        #   @param type [Symbol, :computer_call_output]

        class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the pending safety check.
          #
          #   @return [String]
          required :id, String

          # @!attribute code
          #   The type of the pending safety check.
          #
          #   @return [String]
          required :code, String

          # @!attribute message
          #   Details about the pending safety check.
          #
          #   @return [String]
          required :message, String

          # @!method initialize(id:, code:, message:)
          #   A pending safety check for the computer call.
          #
          #   @param id [String]
          #   @param code [String]
          #   @param message [String]
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseComputerToolCallOutputItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end

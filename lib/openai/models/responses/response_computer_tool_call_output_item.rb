# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputItem < OpenAI::BaseModel
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

        # @!attribute [r] acknowledged_safety_checks
        #   The safety checks reported by the API that have been acknowledged by the
        #     developer.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>, nil]
        optional :acknowledged_safety_checks,
                 -> { OpenAI::ArrayOf[OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>]
        #   attr_writer :acknowledged_safety_checks

        # @!attribute [r] status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #     `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status]
        #   attr_writer :status

        # @!parse
        #   # @param id [String]
        #   # @param call_id [String]
        #   # @param output [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot]
        #   # @param acknowledged_safety_checks [Array<OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem::Status]
        #   # @param type [Symbol, :computer_call_output]
        #   #
        #   def initialize(id:, call_id:, output:, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class AcknowledgedSafetyCheck < OpenAI::BaseModel
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

          # @!parse
          #   # A pending safety check for the computer call.
          #   #
          #   # @param id [String]
          #   # @param code [String]
          #   # @param message [String]
          #   #
          #   def initialize(id:, code:, message:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        module Status
          extend OpenAI::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end

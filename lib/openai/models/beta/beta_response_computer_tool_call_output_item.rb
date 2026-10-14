# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseComputerToolCallOutputItem < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Beta::BetaResponseComputerToolCallOutputScreenshot]
        required :output, -> { OpenAI::Beta::BetaResponseComputerToolCallOutputScreenshot }

        # @!attribute status
        #   The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Status }

        # @!attribute type
        #   The type of the computer tool call output. Always `computer_call_output`.
        #
        #   @return [Symbol, :computer_call_output]
        required :type, const: :computer_call_output

        # @!attribute acknowledged_safety_checks
        #   The safety checks reported by the API that have been acknowledged by the
        #   developer.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>, nil]
        optional :acknowledged_safety_checks,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck] }

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseComputerToolCallOutputItem::Agent }, nil?: true

        # @!attribute created_by
        #   The identifier of the actor that created the item.
        #
        #   @return [String, nil]
        optional :created_by, String

        # @!method initialize(id:, call_id:, output:, status:, acknowledged_safety_checks: nil, agent: nil, created_by: nil, type: :computer_call_output)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem} for more details.
        #
        #   @param id [String] The unique ID of the computer call tool output.
        #
        #   @param call_id [String] The ID of the computer tool call that produced the output.
        #
        #   @param output [OpenAI::Models::Beta::BetaResponseComputerToolCallOutputScreenshot] A computer screenshot image used with the computer use tool.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::Status] The status of the message input. One of `in_progress`, `completed`, or
        #
        #   @param acknowledged_safety_checks [Array<OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::AcknowledgedSafetyCheck>] The safety checks reported by the API that have been acknowledged by the
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem::Agent, nil] The agent that produced this item.
        #
        #   @param created_by [String] The identifier of the actor that created the item.
        #
        #   @param type [Symbol, :computer_call_output] The type of the computer tool call output. Always `computer_call_output`.

        # The status of the message input. One of `in_progress`, `completed`, or
        # `incomplete`. Populated when input items are returned via API.
        #
        # @see OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem#status
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

        # @see OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseComputerToolCallOutputItem = Beta::BetaResponseComputerToolCallOutputItem
  end
end

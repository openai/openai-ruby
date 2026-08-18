# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseComputerToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the computer call.
        #
        #   @return [String]
        required :id, String

        # @!attribute call_id
        #   An identifier used when responding to the tool call with output.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute pending_safety_checks
        #   The pending safety checks for the computer call.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseComputerToolCall::PendingSafetyCheck>]
        required :pending_safety_checks,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseComputerToolCall::PendingSafetyCheck] }

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCall::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseComputerToolCall::Status }

        # @!attribute type
        #   The type of the computer call. Always `computer_call`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCall::Type]
        required :type, enum: -> { OpenAI::Beta::BetaResponseComputerToolCall::Type }

        # @!attribute action
        #   A click action.
        #
        #   @return [OpenAI::Models::Beta::BetaComputerAction::Click, OpenAI::Models::Beta::BetaComputerAction::DoubleClick, OpenAI::Models::Beta::BetaComputerAction::Drag, OpenAI::Models::Beta::BetaComputerAction::Keypress, OpenAI::Models::Beta::BetaComputerAction::Move, OpenAI::Models::Beta::BetaComputerAction::Screenshot, OpenAI::Models::Beta::BetaComputerAction::Scroll, OpenAI::Models::Beta::BetaComputerAction::Type, OpenAI::Models::Beta::BetaComputerAction::Wait, nil]
        optional :action, union: -> { OpenAI::Beta::BetaComputerAction }

        # @!attribute actions
        #   Flattened batched actions for `computer_use`. Each action includes an `type`
        #   discriminator and action-specific fields.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaComputerAction::Click, OpenAI::Models::Beta::BetaComputerAction::DoubleClick, OpenAI::Models::Beta::BetaComputerAction::Drag, OpenAI::Models::Beta::BetaComputerAction::Keypress, OpenAI::Models::Beta::BetaComputerAction::Move, OpenAI::Models::Beta::BetaComputerAction::Screenshot, OpenAI::Models::Beta::BetaComputerAction::Scroll, OpenAI::Models::Beta::BetaComputerAction::Type, OpenAI::Models::Beta::BetaComputerAction::Wait>, nil]
        optional :actions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaComputerAction] }

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseComputerToolCall::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseComputerToolCall::Agent }, nil?: true

        # @!method initialize(id:, call_id:, pending_safety_checks:, status:, type:, action: nil, actions: nil, agent: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseComputerToolCall} for more details.
        #
        #   A tool call to a computer use tool. See the
        #   [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        #   for more information.
        #
        #   @param id [String] The unique ID of the computer call.
        #
        #   @param call_id [String] An identifier used when responding to the tool call with output.
        #
        #   @param pending_safety_checks [Array<OpenAI::Models::Beta::BetaResponseComputerToolCall::PendingSafetyCheck>] The pending safety checks for the computer call.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCall::Status] The status of the item. One of `in_progress`, `completed`, or
        #
        #   @param type [Symbol, OpenAI::Models::Beta::BetaResponseComputerToolCall::Type] The type of the computer call. Always `computer_call`.
        #
        #   @param action [OpenAI::Models::Beta::BetaComputerAction::Click, OpenAI::Models::Beta::BetaComputerAction::DoubleClick, OpenAI::Models::Beta::BetaComputerAction::Drag, OpenAI::Models::Beta::BetaComputerAction::Keypress, OpenAI::Models::Beta::BetaComputerAction::Move, OpenAI::Models::Beta::BetaComputerAction::Screenshot, OpenAI::Models::Beta::BetaComputerAction::Scroll, OpenAI::Models::Beta::BetaComputerAction::Type, OpenAI::Models::Beta::BetaComputerAction::Wait] A click action.
        #
        #   @param actions [Array<OpenAI::Models::Beta::BetaComputerAction::Click, OpenAI::Models::Beta::BetaComputerAction::DoubleClick, OpenAI::Models::Beta::BetaComputerAction::Drag, OpenAI::Models::Beta::BetaComputerAction::Keypress, OpenAI::Models::Beta::BetaComputerAction::Move, OpenAI::Models::Beta::BetaComputerAction::Screenshot, OpenAI::Models::Beta::BetaComputerAction::Scroll, OpenAI::Models::Beta::BetaComputerAction::Type, OpenAI::Models::Beta::BetaComputerAction::Wait>] Flattened batched actions for `computer_use`. Each action includes an
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseComputerToolCall::Agent, nil] The agent that produced this item.

        class PendingSafetyCheck < OpenAI::Internal::Type::BaseModel
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

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Beta::BetaResponseComputerToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of the computer call. Always `computer_call`.
        #
        # @see OpenAI::Models::Beta::BetaResponseComputerToolCall#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPUTER_CALL = :computer_call

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseComputerToolCall#agent
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

    BetaResponseComputerToolCall = Beta::BetaResponseComputerToolCall
  end
end

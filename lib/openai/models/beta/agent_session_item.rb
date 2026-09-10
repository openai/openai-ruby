# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An item associated with a session turn.
      module AgentSessionItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A user or assistant message recorded in a session.
        variant :message, -> { OpenAI::Beta::AgentSessionMessage }

        # A reasoning item produced by the agent.
        variant :reasoning, -> { OpenAI::Beta::AgentReasoningItem }

        # A function call produced by the agent.
        variant :function_call, -> { OpenAI::Beta::AgentFunctionCallItem }

        # The result supplied for a function call.
        variant :function_call_output, -> { OpenAI::Beta::AgentSessionItem::FunctionCallOutput }

        # A message exchanged between agent threads.
        variant :agent_message, -> { OpenAI::Beta::AgentSessionItem::AgentMessage }

        # A call to a tool on an MCP server.
        variant :mcp_call, -> { OpenAI::Beta::AgentMcpCallItem }

        # A web search call produced by the agent.
        variant :web_search_call, -> { OpenAI::Beta::AgentWebSearchCallItem }

        # A command execution produced by the agent.
        variant :command_execution, -> { OpenAI::Beta::AgentCommandExecutionItem }

        # A request to spawn a subagent.
        variant :create_subagent_call, -> { OpenAI::Beta::AgentCreateSubagentCallItem }

        # A request to send input to another agent.
        variant :send_subagent_input_call, -> { OpenAI::Beta::AgentSendSubagentInputCallItem }

        # A request to resume a subagent.
        variant :resume_subagent_call, -> { OpenAI::Beta::AgentResumeSubagentCallItem }

        # A request to wait for one or more subagents.
        variant :wait_for_subagents_call, -> { OpenAI::Beta::AgentWaitForSubagentsCallItem }

        # A request to interrupt a subagent's current turn. The subagent remains available.
        variant :interrupt_subagent_call, -> { OpenAI::Beta::AgentInterruptSubagentCallItem }

        # A request to close a subagent.
        variant :close_subagent_call, -> { OpenAI::Beta::AgentCloseSubagentCallItem }

        class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the function call output item.
          #
          #   @return [String]
          required :id, String

          # @!attribute call_id
          #   The ID of the function call that produced this output.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute error
          #   The error message, if the call failed.
          #
          #   @return [String, nil]
          required :error, String, nil?: true

          # @!attribute output
          #   The text or model-input content supplied as a function result.
          #
          #   @return [String, Array<OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage>, nil]
          required :output, union: -> { OpenAI::Beta::AgentFunctionCallOutput }, nil?: true

          # @!attribute status
          #   The status of the function call.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
          required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

          # @!attribute turn_id
          #   The ID of the turn that contains this item.
          #
          #   @return [String]
          required :turn_id, String

          # @!attribute type
          #   The item type. Always `function_call_output`.
          #
          #   @return [Symbol, :function_call_output]
          required :type, const: :function_call_output

          # @!method initialize(id:, call_id:, error:, output:, status:, turn_id:, type: :function_call_output)
          #   The result supplied for a function call.
          #
          #   @param id [String]
          #     The ID of the function call output item.
          #
          #   @param call_id [String]
          #     The ID of the function call that produced this output.
          #
          #   @param error [String, nil]
          #     The error message, if the call failed.
          #
          #   @param output [String, Array<OpenAI::Models::Beta::InputContent::InputText, OpenAI::Models::Beta::InputContent::InputImage>, nil]
          #     The text or model-input content supplied as a function result.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
          #     The status of the function call.
          #
          #   @param turn_id [String]
          #     The ID of the turn that contains this item.
          #
          #   @param type [Symbol, :function_call_output]
          #     The item type. Always `function_call_output`.
        end

        class AgentMessage < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the message.
          #
          #   @return [String]
          required :id, String

          # @!attribute content
          #   The content exchanged between the agents.
          #
          #   @return [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
          required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent] }

          # @!attribute recipient_agent_id
          #   The ID or name of the receiving agent.
          #
          #   @return [String]
          required :recipient_agent_id, String

          # @!attribute sender_agent_id
          #   The ID or name of the sending agent.
          #
          #   @return [String]
          required :sender_agent_id, String

          # @!attribute turn_id
          #   The ID of the turn that contains this item.
          #
          #   @return [String]
          required :turn_id, String

          # @!attribute type
          #   The item type. Always `agent_message`.
          #
          #   @return [Symbol, :agent_message]
          required :type, const: :agent_message

          # @!method initialize(id:, content:, recipient_agent_id:, sender_agent_id:, turn_id:, type: :agent_message)
          #   A message exchanged between agent threads.
          #
          #   @param id [String]
          #     The ID of the message.
          #
          #   @param content [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>]
          #     The content exchanged between the agents.
          #
          #   @param recipient_agent_id [String]
          #     The ID or name of the receiving agent.
          #
          #   @param sender_agent_id [String]
          #     The ID or name of the sending agent.
          #
          #   @param turn_id [String]
          #     The ID of the turn that contains this item.
          #
          #   @param type [Symbol, :agent_message]
          #     The item type. Always `agent_message`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentSessionItem::FunctionCallOutput, OpenAI::Models::Beta::AgentSessionItem::AgentMessage, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem)]
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An output item produced by an agent.
      module AgentOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # An assistant message produced by the agent.
        variant :message, -> { OpenAI::Beta::AgentSessionAssistantMessage }

        # A reasoning item produced by the agent.
        variant :reasoning, -> { OpenAI::Beta::AgentReasoningItem }

        # A function call produced by the agent.
        variant :function_call, -> { OpenAI::Beta::AgentFunctionCallItem }

        # A call to a tool on an MCP server.
        variant :mcp_call, -> { OpenAI::Beta::AgentMcpCallItem }

        # One execution of the platform-provided computer-use capability.
        variant :computer_use_call, -> { OpenAI::Beta::AgentOutputItem::ComputerUseCall }

        # A credential-free history record of the emitted login request.
        variant :computer_use_approval_request, -> { OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest }

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

        class ComputerUseCall < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the activity item.
          #
          #   @return [String]
          required :id, String

          # @!attribute output
          #   The last screenshot emitted by the model. Null when screenshot inclusion is
          #   disabled or the call emitted no screenshot.
          #
          #   @return [OpenAI::Models::Beta::AgentOutputItem::ComputerUseCall::Output, nil]
          required :output, -> { OpenAI::Beta::AgentOutputItem::ComputerUseCall::Output }, nil?: true

          # @!attribute status
          #   The execution status of the activity.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
          required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

          # @!attribute title
          #   A model-generated description of the activity, when available.
          #
          #   @return [String, nil]
          required :title, String, nil?: true

          # @!attribute turn_id
          #   The ID of the turn that contains this item.
          #
          #   @return [String]
          required :turn_id, String

          # @!attribute type
          #   The item type. Always `computer_use_call`.
          #
          #   @return [Symbol, :computer_use_call]
          required :type, const: :computer_use_call

          # @!method initialize(id:, output:, status:, title:, turn_id:, type: :computer_use_call)
          #   One execution of the platform-provided computer-use capability.
          #
          #   @param id [String]
          #     The ID of the activity item.
          #
          #   @param output [OpenAI::Models::Beta::AgentOutputItem::ComputerUseCall::Output, nil]
          #     The last screenshot emitted by the model. Null when screenshot inclusion is
          #     disabled or the call emitted no screenshot.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
          #     The execution status of the activity.
          #
          #   @param title [String, nil]
          #     A model-generated description of the activity, when available.
          #
          #   @param turn_id [String]
          #     The ID of the turn that contains this item.
          #
          #   @param type [Symbol, :computer_use_call]
          #     The item type. Always `computer_use_call`.

          # @see OpenAI::Models::Beta::AgentOutputItem::ComputerUseCall#output
          class Output < OpenAI::Internal::Type::BaseModel
            # @!attribute image_url
            #   The complete JPEG image as a base64 data URL.
            #
            #   @return [String]
            required :image_url, String

            # @!attribute type
            #   The content type. Always `computer_screenshot`.
            #
            #   @return [Symbol, :computer_screenshot]
            required :type, const: :computer_screenshot

            # @!method initialize(image_url:, type: :computer_screenshot)
            #   The last screenshot emitted by the model. Null when screenshot inclusion is
            #   disabled or the call emitted no screenshot.
            #
            #   @param image_url [String]
            #     The complete JPEG image as a base64 data URL.
            #
            #   @param type [Symbol, :computer_screenshot]
            #     The content type. Always `computer_screenshot`.
          end
        end

        class ComputerUseApprovalRequest < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The stable history item ID.
          #
          #   @return [String]
          required :id, String

          # @!attribute request
          #   A registered form awaiting the application's response.
          #
          #   @return [OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request]
          required :request, -> { OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request }

          # @!attribute request_id
          #
          #   @return [String]
          required :request_id, String

          # @!attribute turn_id
          #
          #   @return [String]
          required :turn_id, String

          # @!attribute type
          #   The item type. Always computer_use_approval_request.
          #
          #   @return [Symbol, :computer_use_approval_request]
          required :type, const: :computer_use_approval_request

          # @!method initialize(id:, request:, request_id:, turn_id:, type: :computer_use_approval_request)
          #   A credential-free history record of the emitted login request.
          #
          #   @param id [String]
          #     The stable history item ID.
          #
          #   @param request [OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request]
          #     A registered form awaiting the application's response.
          #
          #   @param request_id [String]
          #
          #   @param turn_id [String]
          #
          #   @param type [Symbol, :computer_use_approval_request]
          #     The item type. Always computer_use_approval_request.

          # @see OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest#request
          class Request < OpenAI::Internal::Type::BaseModel
            # @!attribute credential_origin
            #   The registered form or frame origin where values will be entered.
            #
            #   @return [String, nil]
            required :credential_origin, String, nil?: true

            # @!attribute fields
            #   Controls to render. All submitted values are sensitive.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field>]
            required(
              :fields,
              -> {
                OpenAI::Internal::Type::ArrayOf[
                  OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field
                ]
              }
            )

            # @!attribute options
            #   Sign-in methods. Empty for a plain form.
            #
            #   @return [Array<OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option>]
            required(
              :options,
              -> {
                OpenAI::Internal::Type::ArrayOf[
                  OpenAI::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option
                ]
              }
            )

            # @!attribute reason
            #   Why the agent needs the user to sign in.
            #
            #   @return [String, nil]
            required :reason, String, nil?: true

            # @!attribute type
            #   The type of the object. Always `browser_authentication`.
            #
            #   @return [Symbol, :browser_authentication]
            required :type, const: :browser_authentication

            # @!method initialize(credential_origin:, fields:, options:, reason:, type: :browser_authentication)
            #   A registered form awaiting the application's response.
            #
            #   @param credential_origin [String, nil]
            #     The registered form or frame origin where values will be entered.
            #
            #   @param fields [Array<OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Field>]
            #     Controls to render. All submitted values are sensitive.
            #
            #   @param options [Array<OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest::Request::Option>]
            #     Sign-in methods. Empty for a plain form.
            #
            #   @param reason [String, nil]
            #     Why the agent needs the user to sign in.
            #
            #   @param type [Symbol, :browser_authentication]
            #     The type of the object. Always `browser_authentication`.
            class Field < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The field ID to submit as field_id in a fields entry.
              #
              #   @return [String]
              required :id, String

              # @!attribute label
              #   The label to display beside the control.
              #
              #   @return [String]
              required :label, String

              # @!attribute required
              #   Whether this control requires a nonempty value.
              #
              #   @return [Boolean]
              required :required, OpenAI::Internal::Type::Boolean

              # @!attribute type
              #   The rendering type, such as email, password, or text.
              #
              #   @return [String]
              required :type, String

              # @!method initialize(id:, label:, required:, type:)
              #   A control in a registered browser-login form.
              #
              #   @param id [String]
              #     The field ID to submit as field_id in a fields entry.
              #
              #   @param label [String]
              #     The label to display beside the control.
              #
              #   @param required [Boolean]
              #     Whether this control requires a nonempty value.
              #
              #   @param type [String]
              #     The rendering type, such as email, password, or text.
            end

            class Option < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The option ID to submit as selected_option.
              #
              #   @return [String]
              required :id, String

              # @!attribute field_ids
              #   IDs from the registered fields that this method accepts.
              #
              #   @return [Array<String>]
              required :field_ids, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute label
              #   The method label to display.
              #
              #   @return [String]
              required :label, String

              # @!method initialize(id:, field_ids:, label:)
              #   A sign-in method and the fields that belong to it.
              #
              #   @param id [String]
              #     The option ID to submit as selected_option.
              #
              #   @param field_ids [Array<String>]
              #     IDs from the registered fields that this method accepts.
              #
              #   @param label [String]
              #     The method label to display.
            end
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentSessionAssistantMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentOutputItem::ComputerUseCall, OpenAI::Models::Beta::AgentOutputItem::ComputerUseApprovalRequest, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem)]
      end
    end
  end
end

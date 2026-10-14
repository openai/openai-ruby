# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # An input stub identifying an outstanding client-owned tool result or approval
      # decision. Copy the stub and fill the result fields using the corresponding
      # `response.create` input schema. Use saved results without rerunning the tool.
      # The server does not supply results, approval decisions, or safety
      # acknowledgements in these stubs.
      module BetaResponseSteerRequiredInput
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Supply `output` using the function tool call output input schema.
        variant :function_call_output, -> { OpenAI::Beta::BetaResponseSteerRequiredInput::FunctionCallOutput }

        # Supply `output` using the custom tool call output input schema. The
        # original custom tool call supplies the tool's name.
        variant(
          :custom_tool_call_output,
          -> { OpenAI::Beta::BetaResponseSteerRequiredInput::CustomToolCallOutput }
        )

        # Supply `output` using the computer tool call output input schema,
        # including any required `acknowledged_safety_checks`.
        variant :computer_call_output, -> { OpenAI::Beta::BetaResponseSteerRequiredInput::ComputerCallOutput }

        # Supply `output` using the shell tool call output input schema. Each
        # output entry includes `stdout`, `stderr`, and `outcome`.
        variant :shell_call_output, -> { OpenAI::Beta::BetaResponseSteerRequiredInput::ShellCallOutput }

        # Supply `status` and optional `output` using the apply patch tool call
        # output input schema.
        variant(
          :apply_patch_call_output,
          -> { OpenAI::Beta::BetaResponseSteerRequiredInput::ApplyPatchCallOutput }
        )

        # Supply `tools` using the tool search output input schema, retaining
        # `execution: "client"`.
        variant :tool_search_output, -> { OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput }

        # Supply `approve` using the MCP approval response input schema. An
        # optional `reason` can be supplied when denying the request. The original
        # approval request identifies the tool and server.
        variant :mcp_approval_response, -> { OpenAI::Beta::BetaResponseSteerRequiredInput::McpApprovalResponse }

        class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!attribute type
          #
          #   @return [Symbol, :function_call_output]
          required :type, const: :function_call_output

          # @!method initialize(call_id:, name:, type: :function_call_output)
          #   Supply `output` using the function tool call output input schema.
          #
          #   @param call_id [String]
          #   @param name [String]
          #   @param type [Symbol, :function_call_output]
        end

        class CustomToolCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute type
          #
          #   @return [Symbol, :custom_tool_call_output]
          required :type, const: :custom_tool_call_output

          # @!method initialize(call_id:, type: :custom_tool_call_output)
          #   Supply `output` using the custom tool call output input schema. The original
          #   custom tool call supplies the tool's name.
          #
          #   @param call_id [String]
          #   @param type [Symbol, :custom_tool_call_output]
        end

        class ComputerCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute type
          #
          #   @return [Symbol, :computer_call_output]
          required :type, const: :computer_call_output

          # @!method initialize(call_id:, type: :computer_call_output)
          #   Supply `output` using the computer tool call output input schema, including any
          #   required `acknowledged_safety_checks`.
          #
          #   @param call_id [String]
          #   @param type [Symbol, :computer_call_output]
        end

        class ShellCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute type
          #
          #   @return [Symbol, :shell_call_output]
          required :type, const: :shell_call_output

          # @!method initialize(call_id:, type: :shell_call_output)
          #   Supply `output` using the shell tool call output input schema. Each output entry
          #   includes `stdout`, `stderr`, and `outcome`.
          #
          #   @param call_id [String]
          #   @param type [Symbol, :shell_call_output]
        end

        class ApplyPatchCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute type
          #
          #   @return [Symbol, :apply_patch_call_output]
          required :type, const: :apply_patch_call_output

          # @!method initialize(call_id:, type: :apply_patch_call_output)
          #   Supply `status` and optional `output` using the apply patch tool call output
          #   input schema.
          #
          #   @param call_id [String]
          #   @param type [Symbol, :apply_patch_call_output]
        end

        class ToolSearchOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #
          #   @return [String]
          required :call_id, String

          # @!attribute execution
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution]
          required(
            :execution,
            enum: -> { OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution }
          )

          # @!attribute type
          #
          #   @return [Symbol, :tool_search_output]
          required :type, const: :tool_search_output

          # @!method initialize(call_id:, execution:, type: :tool_search_output)
          #   Supply `tools` using the tool search output input schema, retaining
          #   `execution: "client"`.
          #
          #   @param call_id [String]
          #   @param execution [Symbol, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution]
          #   @param type [Symbol, :tool_search_output]

          # @see OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput#execution
          module Execution
            extend OpenAI::Internal::Type::Enum

            CLIENT = :client

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class McpApprovalResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute approval_request_id
          #
          #   @return [String]
          required :approval_request_id, String

          # @!attribute type
          #
          #   @return [Symbol, :mcp_approval_response]
          required :type, const: :mcp_approval_response

          # @!method initialize(approval_request_id:, type: :mcp_approval_response)
          #   Supply `approve` using the MCP approval response input schema. An optional
          #   `reason` can be supplied when denying the request. The original approval request
          #   identifies the tool and server.
          #
          #   @param approval_request_id [String]
          #   @param type [Symbol, :mcp_approval_response]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponseSteerRequiredInput::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::CustomToolCallOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ShellCallOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput, OpenAI::Models::Beta::BetaResponseSteerRequiredInput::McpApprovalResponse)]
      end
    end

    BetaResponseSteerRequiredInput = Beta::BetaResponseSteerRequiredInput
  end
end

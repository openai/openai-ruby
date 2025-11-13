# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # An output message from the model.
        variant :message, -> { OpenAI::Responses::ResponseOutputMessage }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Responses::ResponseFileSearchToolCall }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Responses::ResponseFunctionToolCall }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Responses::ResponseFunctionWebSearch }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Responses::ResponseComputerToolCall }

        # A description of the chain of thought used by a reasoning model while generating
        # a response. Be sure to include these items in your `input` to the Responses API
        # for subsequent turns of a conversation if you are manually
        # [managing context](https://platform.openai.com/docs/guides/conversation-state).
        variant :reasoning, -> { OpenAI::Responses::ResponseReasoningItem }

        # An image generation request made by the model.
        variant :image_generation_call, -> { OpenAI::Responses::ResponseOutputItem::ImageGenerationCall }

        # A tool call to run code.
        variant :code_interpreter_call, -> { OpenAI::Responses::ResponseCodeInterpreterToolCall }

        # A tool call to run a command on the local shell.
        variant :local_shell_call, -> { OpenAI::Responses::ResponseOutputItem::LocalShellCall }

        # A tool call that executes one or more shell commands in a managed environment.
        variant :shell_call, -> { OpenAI::Responses::ResponseFunctionShellToolCall }

        # The output of a shell tool call.
        variant :shell_call_output, -> { OpenAI::Responses::ResponseFunctionShellToolCallOutput }

        # A tool call that applies file diffs by creating, deleting, or updating files.
        variant :apply_patch_call, -> { OpenAI::Responses::ResponseApplyPatchToolCall }

        # The output emitted by an apply patch tool call.
        variant :apply_patch_call_output, -> { OpenAI::Responses::ResponseApplyPatchToolCallOutput }

        # An invocation of a tool on an MCP server.
        variant :mcp_call, -> { OpenAI::Responses::ResponseOutputItem::McpCall }

        # A list of tools available on an MCP server.
        variant :mcp_list_tools, -> { OpenAI::Responses::ResponseOutputItem::McpListTools }

        # A request for human approval of a tool invocation.
        variant :mcp_approval_request, -> { OpenAI::Responses::ResponseOutputItem::McpApprovalRequest }

        # A call to a custom tool created by the model.
        variant :custom_tool_call, -> { OpenAI::Responses::ResponseCustomToolCall }

        class ImageGenerationCall < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the image generation call.
          #
          #   @return [String]
          required :id, String

          # @!attribute result
          #   The generated image encoded in base64.
          #
          #   @return [String, nil]
          required :result, String, nil?: true

          # @!attribute status
          #   The status of the image generation call.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall::Status]
          required :status, enum: -> { OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status }

          # @!attribute type
          #   The type of the image generation call. Always `image_generation_call`.
          #
          #   @return [Symbol, :image_generation_call]
          required :type, const: :image_generation_call

          # @!method initialize(id:, result:, status:, type: :image_generation_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall} for more
          #   details.
          #
          #   An image generation request made by the model.
          #
          #   @param id [String] The unique ID of the image generation call.
          #
          #   @param result [String, nil] The generated image encoded in base64.
          #
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall::Status] The status of the image generation call.
          #
          #   @param type [Symbol, :image_generation_call] The type of the image generation call. Always `image_generation_call`.

          # The status of the image generation call.
          #
          # @see OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            GENERATING = :generating
            FAILED = :failed

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class LocalShellCall < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the local shell call.
          #
          #   @return [String]
          required :id, String

          # @!attribute action
          #   Execute a shell command on the server.
          #
          #   @return [OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall::Action]
          required :action, -> { OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action }

          # @!attribute call_id
          #   The unique ID of the local shell tool call generated by the model.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute status
          #   The status of the local shell call.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall::Status]
          required :status, enum: -> { OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status }

          # @!attribute type
          #   The type of the local shell call. Always `local_shell_call`.
          #
          #   @return [Symbol, :local_shell_call]
          required :type, const: :local_shell_call

          # @!method initialize(id:, action:, call_id:, status:, type: :local_shell_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall} for more
          #   details.
          #
          #   A tool call to run a command on the local shell.
          #
          #   @param id [String] The unique ID of the local shell call.
          #
          #   @param action [OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall::Action] Execute a shell command on the server.
          #
          #   @param call_id [String] The unique ID of the local shell tool call generated by the model.
          #
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall::Status] The status of the local shell call.
          #
          #   @param type [Symbol, :local_shell_call] The type of the local shell call. Always `local_shell_call`.

          # @see OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall#action
          class Action < OpenAI::Internal::Type::BaseModel
            # @!attribute command
            #   The command to run.
            #
            #   @return [Array<String>]
            required :command, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute env
            #   Environment variables to set for the command.
            #
            #   @return [Hash{Symbol=>String}]
            required :env, OpenAI::Internal::Type::HashOf[String]

            # @!attribute type
            #   The type of the local shell action. Always `exec`.
            #
            #   @return [Symbol, :exec]
            required :type, const: :exec

            # @!attribute timeout_ms
            #   Optional timeout in milliseconds for the command.
            #
            #   @return [Integer, nil]
            optional :timeout_ms, Integer, nil?: true

            # @!attribute user
            #   Optional user to run the command as.
            #
            #   @return [String, nil]
            optional :user, String, nil?: true

            # @!attribute working_directory
            #   Optional working directory to run the command in.
            #
            #   @return [String, nil]
            optional :working_directory, String, nil?: true

            # @!method initialize(command:, env:, timeout_ms: nil, user: nil, working_directory: nil, type: :exec)
            #   Execute a shell command on the server.
            #
            #   @param command [Array<String>] The command to run.
            #
            #   @param env [Hash{Symbol=>String}] Environment variables to set for the command.
            #
            #   @param timeout_ms [Integer, nil] Optional timeout in milliseconds for the command.
            #
            #   @param user [String, nil] Optional user to run the command as.
            #
            #   @param working_directory [String, nil] Optional working directory to run the command in.
            #
            #   @param type [Symbol, :exec] The type of the local shell action. Always `exec`.
          end

          # The status of the local shell call.
          #
          # @see OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class McpCall < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the tool call.
          #
          #   @return [String]
          required :id, String

          # @!attribute arguments
          #   A JSON string of the arguments passed to the tool.
          #
          #   @return [String]
          required :arguments, String

          # @!attribute name
          #   The name of the tool that was run.
          #
          #   @return [String]
          required :name, String

          # @!attribute server_label
          #   The label of the MCP server running the tool.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute type
          #   The type of the item. Always `mcp_call`.
          #
          #   @return [Symbol, :mcp_call]
          required :type, const: :mcp_call

          # @!attribute approval_request_id
          #   Unique identifier for the MCP tool call approval request. Include this value in
          #   a subsequent `mcp_approval_response` input to approve or reject the
          #   corresponding tool call.
          #
          #   @return [String, nil]
          optional :approval_request_id, String, nil?: true

          # @!attribute error
          #   The error from the tool call, if any.
          #
          #   @return [String, nil]
          optional :error, String, nil?: true

          # @!attribute output
          #   The output from the tool call.
          #
          #   @return [String, nil]
          optional :output, String, nil?: true

          # @!attribute status
          #   The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
          #   `calling`, or `failed`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseOutputItem::McpCall::Status, nil]
          optional :status, enum: -> { OpenAI::Responses::ResponseOutputItem::McpCall::Status }

          # @!method initialize(id:, arguments:, name:, server_label:, approval_request_id: nil, error: nil, output: nil, status: nil, type: :mcp_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseOutputItem::McpCall} for more details.
          #
          #   An invocation of a tool on an MCP server.
          #
          #   @param id [String] The unique ID of the tool call.
          #
          #   @param arguments [String] A JSON string of the arguments passed to the tool.
          #
          #   @param name [String] The name of the tool that was run.
          #
          #   @param server_label [String] The label of the MCP server running the tool.
          #
          #   @param approval_request_id [String, nil] Unique identifier for the MCP tool call approval request.
          #
          #   @param error [String, nil] The error from the tool call, if any.
          #
          #   @param output [String, nil] The output from the tool call.
          #
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseOutputItem::McpCall::Status] The status of the tool call. One of `in_progress`, `completed`, `incomplete`, `c
          #
          #   @param type [Symbol, :mcp_call] The type of the item. Always `mcp_call`.

          # The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
          # `calling`, or `failed`.
          #
          # @see OpenAI::Models::Responses::ResponseOutputItem::McpCall#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete
            CALLING = :calling
            FAILED = :failed

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class McpListTools < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the list.
          #
          #   @return [String]
          required :id, String

          # @!attribute server_label
          #   The label of the MCP server.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute tools
          #   The tools available on the server.
          #
          #   @return [Array<OpenAI::Models::Responses::ResponseOutputItem::McpListTools::Tool>]
          required :tools,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseOutputItem::McpListTools::Tool] }

          # @!attribute type
          #   The type of the item. Always `mcp_list_tools`.
          #
          #   @return [Symbol, :mcp_list_tools]
          required :type, const: :mcp_list_tools

          # @!attribute error
          #   Error message if the server could not list tools.
          #
          #   @return [String, nil]
          optional :error, String, nil?: true

          # @!method initialize(id:, server_label:, tools:, error: nil, type: :mcp_list_tools)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseOutputItem::McpListTools} for more details.
          #
          #   A list of tools available on an MCP server.
          #
          #   @param id [String] The unique ID of the list.
          #
          #   @param server_label [String] The label of the MCP server.
          #
          #   @param tools [Array<OpenAI::Models::Responses::ResponseOutputItem::McpListTools::Tool>] The tools available on the server.
          #
          #   @param error [String, nil] Error message if the server could not list tools.
          #
          #   @param type [Symbol, :mcp_list_tools] The type of the item. Always `mcp_list_tools`.

          class Tool < OpenAI::Internal::Type::BaseModel
            # @!attribute input_schema
            #   The JSON schema describing the tool's input.
            #
            #   @return [Object]
            required :input_schema, OpenAI::Internal::Type::Unknown

            # @!attribute name
            #   The name of the tool.
            #
            #   @return [String]
            required :name, String

            # @!attribute annotations
            #   Additional annotations about the tool.
            #
            #   @return [Object, nil]
            optional :annotations, OpenAI::Internal::Type::Unknown, nil?: true

            # @!attribute description
            #   The description of the tool.
            #
            #   @return [String, nil]
            optional :description, String, nil?: true

            # @!method initialize(input_schema:, name:, annotations: nil, description: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseOutputItem::McpListTools::Tool} for more
            #   details.
            #
            #   A tool available on an MCP server.
            #
            #   @param input_schema [Object] The JSON schema describing the tool's input.
            #
            #   @param name [String] The name of the tool.
            #
            #   @param annotations [Object, nil] Additional annotations about the tool.
            #
            #   @param description [String, nil] The description of the tool.
          end
        end

        class McpApprovalRequest < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the approval request.
          #
          #   @return [String]
          required :id, String

          # @!attribute arguments
          #   A JSON string of arguments for the tool.
          #
          #   @return [String]
          required :arguments, String

          # @!attribute name
          #   The name of the tool to run.
          #
          #   @return [String]
          required :name, String

          # @!attribute server_label
          #   The label of the MCP server making the request.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute type
          #   The type of the item. Always `mcp_approval_request`.
          #
          #   @return [Symbol, :mcp_approval_request]
          required :type, const: :mcp_approval_request

          # @!method initialize(id:, arguments:, name:, server_label:, type: :mcp_approval_request)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest} for more
          #   details.
          #
          #   A request for human approval of a tool invocation.
          #
          #   @param id [String] The unique ID of the approval request.
          #
          #   @param arguments [String] A JSON string of arguments for the tool.
          #
          #   @param name [String] The name of the tool to run.
          #
          #   @param server_label [String] The label of the MCP server making the request.
          #
          #   @param type [Symbol, :mcp_approval_request] The type of the item. Always `mcp_approval_request`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseCustomToolCall)]
      end
    end
  end
end

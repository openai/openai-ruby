# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # A single item within a conversation. The set of possible types are the same as
      # the `output` type of a
      # [Response object](https://platform.openai.com/docs/api-reference/responses/object#responses/object-output).
      #
      # @see OpenAI::Resources::Conversations::Items#retrieve
      module ConversationItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A message to or from the model.
        variant :message, -> { OpenAI::Conversations::Message }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Responses::ResponseFunctionToolCallItem }

        variant :function_call_output, -> { OpenAI::Responses::ResponseFunctionToolCallOutputItem }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Responses::ResponseFileSearchToolCall }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Responses::ResponseFunctionWebSearch }

        # An image generation request made by the model.
        variant :image_generation_call, -> { OpenAI::Conversations::ConversationItem::ImageGenerationCall }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Responses::ResponseComputerToolCall }

        variant :computer_call_output, -> { OpenAI::Responses::ResponseComputerToolCallOutputItem }

        # A description of the chain of thought used by a reasoning model while generating
        # a response. Be sure to include these items in your `input` to the Responses API
        # for subsequent turns of a conversation if you are manually
        # [managing context](https://platform.openai.com/docs/guides/conversation-state).
        variant :reasoning, -> { OpenAI::Responses::ResponseReasoningItem }

        # A tool call to run code.
        variant :code_interpreter_call, -> { OpenAI::Responses::ResponseCodeInterpreterToolCall }

        # A tool call to run a command on the local shell.
        variant :local_shell_call, -> { OpenAI::Conversations::ConversationItem::LocalShellCall }

        # The output of a local shell tool call.
        variant :local_shell_call_output, -> { OpenAI::Conversations::ConversationItem::LocalShellCallOutput }

        # A list of tools available on an MCP server.
        variant :mcp_list_tools, -> { OpenAI::Conversations::ConversationItem::McpListTools }

        # A request for human approval of a tool invocation.
        variant :mcp_approval_request, -> { OpenAI::Conversations::ConversationItem::McpApprovalRequest }

        # A response to an MCP approval request.
        variant :mcp_approval_response, -> { OpenAI::Conversations::ConversationItem::McpApprovalResponse }

        # An invocation of a tool on an MCP server.
        variant :mcp_call, -> { OpenAI::Conversations::ConversationItem::McpCall }

        # A call to a custom tool created by the model.
        variant :custom_tool_call, -> { OpenAI::Responses::ResponseCustomToolCall }

        # The output of a custom tool call from your code, being sent back to the model.
        variant :custom_tool_call_output, -> { OpenAI::Responses::ResponseCustomToolCallOutput }

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
          #   @return [Symbol, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall::Status]
          required :status, enum: -> { OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status }

          # @!attribute type
          #   The type of the image generation call. Always `image_generation_call`.
          #
          #   @return [Symbol, :image_generation_call]
          required :type, const: :image_generation_call

          # @!method initialize(id:, result:, status:, type: :image_generation_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall} for more
          #   details.
          #
          #   An image generation request made by the model.
          #
          #   @param id [String] The unique ID of the image generation call.
          #
          #   @param result [String, nil] The generated image encoded in base64.
          #
          #   @param status [Symbol, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall::Status] The status of the image generation call.
          #
          #   @param type [Symbol, :image_generation_call] The type of the image generation call. Always `image_generation_call`.

          # The status of the image generation call.
          #
          # @see OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall#status
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
          #   @return [OpenAI::Models::Conversations::ConversationItem::LocalShellCall::Action]
          required :action, -> { OpenAI::Conversations::ConversationItem::LocalShellCall::Action }

          # @!attribute call_id
          #   The unique ID of the local shell tool call generated by the model.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute status
          #   The status of the local shell call.
          #
          #   @return [Symbol, OpenAI::Models::Conversations::ConversationItem::LocalShellCall::Status]
          required :status, enum: -> { OpenAI::Conversations::ConversationItem::LocalShellCall::Status }

          # @!attribute type
          #   The type of the local shell call. Always `local_shell_call`.
          #
          #   @return [Symbol, :local_shell_call]
          required :type, const: :local_shell_call

          # @!method initialize(id:, action:, call_id:, status:, type: :local_shell_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Conversations::ConversationItem::LocalShellCall} for more
          #   details.
          #
          #   A tool call to run a command on the local shell.
          #
          #   @param id [String] The unique ID of the local shell call.
          #
          #   @param action [OpenAI::Models::Conversations::ConversationItem::LocalShellCall::Action] Execute a shell command on the server.
          #
          #   @param call_id [String] The unique ID of the local shell tool call generated by the model.
          #
          #   @param status [Symbol, OpenAI::Models::Conversations::ConversationItem::LocalShellCall::Status] The status of the local shell call.
          #
          #   @param type [Symbol, :local_shell_call] The type of the local shell call. Always `local_shell_call`.

          # @see OpenAI::Models::Conversations::ConversationItem::LocalShellCall#action
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
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Conversations::ConversationItem::LocalShellCall::Action} for
            #   more details.
            #
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
          # @see OpenAI::Models::Conversations::ConversationItem::LocalShellCall#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class LocalShellCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the local shell tool call generated by the model.
          #
          #   @return [String]
          required :id, String

          # @!attribute output
          #   A JSON string of the output of the local shell tool call.
          #
          #   @return [String]
          required :output, String

          # @!attribute type
          #   The type of the local shell tool call output. Always `local_shell_call_output`.
          #
          #   @return [Symbol, :local_shell_call_output]
          required :type, const: :local_shell_call_output

          # @!attribute status
          #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #
          #   @return [Symbol, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput::Status, nil]
          optional :status,
                   enum: -> { OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status },
                   nil?: true

          # @!method initialize(id:, output:, status: nil, type: :local_shell_call_output)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput} for more
          #   details.
          #
          #   The output of a local shell tool call.
          #
          #   @param id [String] The unique ID of the local shell tool call generated by the model.
          #
          #   @param output [String] A JSON string of the output of the local shell tool call.
          #
          #   @param status [Symbol, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput::Status, nil] The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #
          #   @param type [Symbol, :local_shell_call_output] The type of the local shell tool call output. Always `local_shell_call_output`.

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #
          # @see OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

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
          #   @return [Array<OpenAI::Models::Conversations::ConversationItem::McpListTools::Tool>]
          required :tools,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::ConversationItem::McpListTools::Tool] }

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
          #   {OpenAI::Models::Conversations::ConversationItem::McpListTools} for more
          #   details.
          #
          #   A list of tools available on an MCP server.
          #
          #   @param id [String] The unique ID of the list.
          #
          #   @param server_label [String] The label of the MCP server.
          #
          #   @param tools [Array<OpenAI::Models::Conversations::ConversationItem::McpListTools::Tool>] The tools available on the server.
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
            #   {OpenAI::Models::Conversations::ConversationItem::McpListTools::Tool} for more
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
          #   {OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest} for more
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

        class McpApprovalResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The unique ID of the approval response
          #
          #   @return [String]
          required :id, String

          # @!attribute approval_request_id
          #   The ID of the approval request being answered.
          #
          #   @return [String]
          required :approval_request_id, String

          # @!attribute approve
          #   Whether the request was approved.
          #
          #   @return [Boolean]
          required :approve, OpenAI::Internal::Type::Boolean

          # @!attribute type
          #   The type of the item. Always `mcp_approval_response`.
          #
          #   @return [Symbol, :mcp_approval_response]
          required :type, const: :mcp_approval_response

          # @!attribute reason
          #   Optional reason for the decision.
          #
          #   @return [String, nil]
          optional :reason, String, nil?: true

          # @!method initialize(id:, approval_request_id:, approve:, reason: nil, type: :mcp_approval_response)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse} for more
          #   details.
          #
          #   A response to an MCP approval request.
          #
          #   @param id [String] The unique ID of the approval response
          #
          #   @param approval_request_id [String] The ID of the approval request being answered.
          #
          #   @param approve [Boolean] Whether the request was approved.
          #
          #   @param reason [String, nil] Optional reason for the decision.
          #
          #   @param type [Symbol, :mcp_approval_response] The type of the item. Always `mcp_approval_response`.
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
          #   @return [Symbol, OpenAI::Models::Conversations::ConversationItem::McpCall::Status, nil]
          optional :status, enum: -> { OpenAI::Conversations::ConversationItem::McpCall::Status }

          # @!method initialize(id:, arguments:, name:, server_label:, approval_request_id: nil, error: nil, output: nil, status: nil, type: :mcp_call)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Conversations::ConversationItem::McpCall} for more details.
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
          #   @param status [Symbol, OpenAI::Models::Conversations::ConversationItem::McpCall::Status] The status of the tool call. One of `in_progress`, `completed`, `incomplete`, `c
          #
          #   @param type [Symbol, :mcp_call] The type of the item. Always `mcp_call`.

          # The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
          # `calling`, or `failed`.
          #
          # @see OpenAI::Models::Conversations::ConversationItem::McpCall#status
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

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Conversations::Message, OpenAI::Models::Responses::ResponseFunctionToolCallItem, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Conversations::ConversationItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCall, OpenAI::Models::Conversations::ConversationItem::LocalShellCallOutput, OpenAI::Models::Conversations::ConversationItem::McpListTools, OpenAI::Models::Conversations::ConversationItem::McpApprovalRequest, OpenAI::Models::Conversations::ConversationItem::McpApprovalResponse, OpenAI::Models::Conversations::ConversationItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput)]
      end
    end

    ConversationItem = Conversations::ConversationItem
  end
end

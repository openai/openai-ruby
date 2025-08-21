# typed: strong

module OpenAI
  module Models
    ConversationItem = Conversations::ConversationItem

    module Conversations
      # A single item within a conversation. The set of possible types are the same as
      # the `output` type of a
      # [Response object](https://platform.openai.com/docs/api-reference/responses/object#responses/object-output).
      module ConversationItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Conversations::Message,
              OpenAI::Responses::ResponseFunctionToolCallItem,
              OpenAI::Responses::ResponseFunctionToolCallOutputItem,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Conversations::ConversationItem::ImageGenerationCall,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseComputerToolCallOutputItem,
              OpenAI::Responses::ResponseReasoningItem,
              OpenAI::Responses::ResponseCodeInterpreterToolCall,
              OpenAI::Conversations::ConversationItem::LocalShellCall,
              OpenAI::Conversations::ConversationItem::LocalShellCallOutput,
              OpenAI::Conversations::ConversationItem::McpListTools,
              OpenAI::Conversations::ConversationItem::McpApprovalRequest,
              OpenAI::Conversations::ConversationItem::McpApprovalResponse,
              OpenAI::Conversations::ConversationItem::McpCall,
              OpenAI::Responses::ResponseCustomToolCall,
              OpenAI::Responses::ResponseCustomToolCallOutput
            )
          end

        class ImageGenerationCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::ImageGenerationCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the image generation call.
          sig { returns(String) }
          attr_accessor :id

          # The generated image encoded in base64.
          sig { returns(T.nilable(String)) }
          attr_accessor :result

          # The status of the image generation call.
          sig do
            returns(
              OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
            )
          end
          attr_accessor :status

          # The type of the image generation call. Always `image_generation_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # An image generation request made by the model.
          sig do
            params(
              id: String,
              result: T.nilable(String),
              status:
                OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::OrSymbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the image generation call.
            id:,
            # The generated image encoded in base64.
            result:,
            # The status of the image generation call.
            status:,
            # The type of the image generation call. Always `image_generation_call`.
            type: :image_generation_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                result: T.nilable(String),
                status:
                  OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # The status of the image generation call.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
              )
            GENERATING =
              T.let(
                :generating,
                OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
              )
            FAILED =
              T.let(
                :failed,
                OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Conversations::ConversationItem::ImageGenerationCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class LocalShellCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::LocalShellCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the local shell call.
          sig { returns(String) }
          attr_accessor :id

          # Execute a shell command on the server.
          sig do
            returns(
              OpenAI::Conversations::ConversationItem::LocalShellCall::Action
            )
          end
          attr_reader :action

          sig do
            params(
              action:
                OpenAI::Conversations::ConversationItem::LocalShellCall::Action::OrHash
            ).void
          end
          attr_writer :action

          # The unique ID of the local shell tool call generated by the model.
          sig { returns(String) }
          attr_accessor :call_id

          # The status of the local shell call.
          sig do
            returns(
              OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol
            )
          end
          attr_accessor :status

          # The type of the local shell call. Always `local_shell_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A tool call to run a command on the local shell.
          sig do
            params(
              id: String,
              action:
                OpenAI::Conversations::ConversationItem::LocalShellCall::Action::OrHash,
              call_id: String,
              status:
                OpenAI::Conversations::ConversationItem::LocalShellCall::Status::OrSymbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the local shell call.
            id:,
            # Execute a shell command on the server.
            action:,
            # The unique ID of the local shell tool call generated by the model.
            call_id:,
            # The status of the local shell call.
            status:,
            # The type of the local shell call. Always `local_shell_call`.
            type: :local_shell_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                action:
                  OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
                call_id: String,
                status:
                  OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Action < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Conversations::ConversationItem::LocalShellCall::Action,
                  OpenAI::Internal::AnyHash
                )
              end

            # The command to run.
            sig { returns(T::Array[String]) }
            attr_accessor :command

            # Environment variables to set for the command.
            sig { returns(T::Hash[Symbol, String]) }
            attr_accessor :env

            # The type of the local shell action. Always `exec`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Optional timeout in milliseconds for the command.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :timeout_ms

            # Optional user to run the command as.
            sig { returns(T.nilable(String)) }
            attr_accessor :user

            # Optional working directory to run the command in.
            sig { returns(T.nilable(String)) }
            attr_accessor :working_directory

            # Execute a shell command on the server.
            sig do
              params(
                command: T::Array[String],
                env: T::Hash[Symbol, String],
                timeout_ms: T.nilable(Integer),
                user: T.nilable(String),
                working_directory: T.nilable(String),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The command to run.
              command:,
              # Environment variables to set for the command.
              env:,
              # Optional timeout in milliseconds for the command.
              timeout_ms: nil,
              # Optional user to run the command as.
              user: nil,
              # Optional working directory to run the command in.
              working_directory: nil,
              # The type of the local shell action. Always `exec`.
              type: :exec
            )
            end

            sig do
              override.returns(
                {
                  command: T::Array[String],
                  env: T::Hash[Symbol, String],
                  type: Symbol,
                  timeout_ms: T.nilable(Integer),
                  user: T.nilable(String),
                  working_directory: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end

          # The status of the local shell call.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Conversations::ConversationItem::LocalShellCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Conversations::ConversationItem::LocalShellCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class LocalShellCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::LocalShellCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the local shell tool call generated by the model.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of the output of the local shell tool call.
          sig { returns(String) }
          attr_accessor :output

          # The type of the local shell tool call output. Always `local_shell_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          sig do
            returns(
              T.nilable(
                OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            )
          end
          attr_accessor :status

          # The output of a local shell tool call.
          sig do
            params(
              id: String,
              output: String,
              status:
                T.nilable(
                  OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::OrSymbol
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the local shell tool call generated by the model.
            id:,
            # A JSON string of the output of the local shell tool call.
            output:,
            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            status: nil,
            # The type of the local shell tool call output. Always `local_shell_call_output`.
            type: :local_shell_call_output
          )
          end

          sig do
            override.returns(
              {
                id: String,
                output: String,
                type: Symbol,
                status:
                  T.nilable(
                    OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
                  )
              }
            )
          end
          def to_hash
          end

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Conversations::ConversationItem::LocalShellCallOutput::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class McpListTools < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::McpListTools,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the list.
          sig { returns(String) }
          attr_accessor :id

          # The label of the MCP server.
          sig { returns(String) }
          attr_accessor :server_label

          # The tools available on the server.
          sig do
            returns(
              T::Array[
                OpenAI::Conversations::ConversationItem::McpListTools::Tool
              ]
            )
          end
          attr_accessor :tools

          # The type of the item. Always `mcp_list_tools`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Error message if the server could not list tools.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # A list of tools available on an MCP server.
          sig do
            params(
              id: String,
              server_label: String,
              tools:
                T::Array[
                  OpenAI::Conversations::ConversationItem::McpListTools::Tool::OrHash
                ],
              error: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the list.
            id:,
            # The label of the MCP server.
            server_label:,
            # The tools available on the server.
            tools:,
            # Error message if the server could not list tools.
            error: nil,
            # The type of the item. Always `mcp_list_tools`.
            type: :mcp_list_tools
          )
          end

          sig do
            override.returns(
              {
                id: String,
                server_label: String,
                tools:
                  T::Array[
                    OpenAI::Conversations::ConversationItem::McpListTools::Tool
                  ],
                type: Symbol,
                error: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          class Tool < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Conversations::ConversationItem::McpListTools::Tool,
                  OpenAI::Internal::AnyHash
                )
              end

            # The JSON schema describing the tool's input.
            sig { returns(T.anything) }
            attr_accessor :input_schema

            # The name of the tool.
            sig { returns(String) }
            attr_accessor :name

            # Additional annotations about the tool.
            sig { returns(T.nilable(T.anything)) }
            attr_accessor :annotations

            # The description of the tool.
            sig { returns(T.nilable(String)) }
            attr_accessor :description

            # A tool available on an MCP server.
            sig do
              params(
                input_schema: T.anything,
                name: String,
                annotations: T.nilable(T.anything),
                description: T.nilable(String)
              ).returns(T.attached_class)
            end
            def self.new(
              # The JSON schema describing the tool's input.
              input_schema:,
              # The name of the tool.
              name:,
              # Additional annotations about the tool.
              annotations: nil,
              # The description of the tool.
              description: nil
            )
            end

            sig do
              override.returns(
                {
                  input_schema: T.anything,
                  name: String,
                  annotations: T.nilable(T.anything),
                  description: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end
        end

        class McpApprovalRequest < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::McpApprovalRequest,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the approval request.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of arguments for the tool.
          sig { returns(String) }
          attr_accessor :arguments

          # The name of the tool to run.
          sig { returns(String) }
          attr_accessor :name

          # The label of the MCP server making the request.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the item. Always `mcp_approval_request`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A request for human approval of a tool invocation.
          sig do
            params(
              id: String,
              arguments: String,
              name: String,
              server_label: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the approval request.
            id:,
            # A JSON string of arguments for the tool.
            arguments:,
            # The name of the tool to run.
            name:,
            # The label of the MCP server making the request.
            server_label:,
            # The type of the item. Always `mcp_approval_request`.
            type: :mcp_approval_request
          )
          end

          sig do
            override.returns(
              {
                id: String,
                arguments: String,
                name: String,
                server_label: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end
        end

        class McpApprovalResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::McpApprovalResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the approval response
          sig { returns(String) }
          attr_accessor :id

          # The ID of the approval request being answered.
          sig { returns(String) }
          attr_accessor :approval_request_id

          # Whether the request was approved.
          sig { returns(T::Boolean) }
          attr_accessor :approve

          # The type of the item. Always `mcp_approval_response`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Optional reason for the decision.
          sig { returns(T.nilable(String)) }
          attr_accessor :reason

          # A response to an MCP approval request.
          sig do
            params(
              id: String,
              approval_request_id: String,
              approve: T::Boolean,
              reason: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the approval response
            id:,
            # The ID of the approval request being answered.
            approval_request_id:,
            # Whether the request was approved.
            approve:,
            # Optional reason for the decision.
            reason: nil,
            # The type of the item. Always `mcp_approval_response`.
            type: :mcp_approval_response
          )
          end

          sig do
            override.returns(
              {
                id: String,
                approval_request_id: String,
                approve: T::Boolean,
                type: Symbol,
                reason: T.nilable(String)
              }
            )
          end
          def to_hash
          end
        end

        class McpCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Conversations::ConversationItem::McpCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the tool call.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of the arguments passed to the tool.
          sig { returns(String) }
          attr_accessor :arguments

          # The name of the tool that was run.
          sig { returns(String) }
          attr_accessor :name

          # The label of the MCP server running the tool.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the item. Always `mcp_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The error from the tool call, if any.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # The output from the tool call.
          sig { returns(T.nilable(String)) }
          attr_accessor :output

          # An invocation of a tool on an MCP server.
          sig do
            params(
              id: String,
              arguments: String,
              name: String,
              server_label: String,
              error: T.nilable(String),
              output: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the tool call.
            id:,
            # A JSON string of the arguments passed to the tool.
            arguments:,
            # The name of the tool that was run.
            name:,
            # The label of the MCP server running the tool.
            server_label:,
            # The error from the tool call, if any.
            error: nil,
            # The output from the tool call.
            output: nil,
            # The type of the item. Always `mcp_call`.
            type: :mcp_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                arguments: String,
                name: String,
                server_label: String,
                type: Symbol,
                error: T.nilable(String),
                output: T.nilable(String)
              }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Conversations::ConversationItem::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end

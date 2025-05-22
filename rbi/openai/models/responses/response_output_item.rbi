# typed: strong

module OpenAI
  module Models
    module Responses
      # An output message from the model.
      module ResponseOutputItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseFunctionToolCall,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseReasoningItem,
              OpenAI::Responses::ResponseOutputItem::ImageGenerationCall,
              OpenAI::Responses::ResponseCodeInterpreterToolCall,
              OpenAI::Responses::ResponseOutputItem::LocalShellCall,
              OpenAI::Responses::ResponseOutputItem::McpCall,
              OpenAI::Responses::ResponseOutputItem::McpListTools,
              OpenAI::Responses::ResponseOutputItem::McpApprovalRequest
            )
          end

        class ImageGenerationCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall,
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
              OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
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
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::OrSymbol,
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
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol,
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
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            GENERATING =
              T.let(
                :generating,
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            FAILED =
              T.let(
                :failed,
                OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
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
                OpenAI::Responses::ResponseOutputItem::LocalShellCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the local shell call.
          sig { returns(String) }
          attr_accessor :id

          # Execute a shell command on the server.
          sig do
            returns(
              OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action
            )
          end
          attr_reader :action

          sig do
            params(
              action:
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action::OrHash
            ).void
          end
          attr_writer :action

          # The unique ID of the local shell tool call generated by the model.
          sig { returns(String) }
          attr_accessor :call_id

          # The status of the local shell call.
          sig do
            returns(
              OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol
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
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action::OrHash,
              call_id: String,
              status:
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::OrSymbol,
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
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action,
                call_id: String,
                status:
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol,
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
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::Action,
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
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class McpCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputItem::McpCall,
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

        class McpListTools < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputItem::McpListTools,
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
                OpenAI::Responses::ResponseOutputItem::McpListTools::Tool
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
                  OpenAI::Responses::ResponseOutputItem::McpListTools::Tool::OrHash
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
                    OpenAI::Responses::ResponseOutputItem::McpListTools::Tool
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
                  OpenAI::Responses::ResponseOutputItem::McpListTools::Tool,
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
                OpenAI::Responses::ResponseOutputItem::McpApprovalRequest,
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

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseOutputItem::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end

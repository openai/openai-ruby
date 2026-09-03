# typed: strong

module OpenAI
  module Models

    BetaResponseSteerRequiredInput = Beta::BetaResponseSteerRequiredInput

    module Beta

      # An input stub identifying an outstanding client-owned tool result or approval
      # decision. Copy the stub and fill the result fields using the corresponding
      # `response.create` input schema. Use saved results without rerunning the tool.
      # The server does not supply results, approval decisions, or safety
      # acknowledgements in these stubs.
      module BetaResponseSteerRequiredInput
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseSteerRequiredInput::FunctionCallOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::CustomToolCallOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::ComputerCallOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::ShellCallOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::ApplyPatchCallOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput,
            OpenAI::Beta::BetaResponseSteerRequiredInput::McpApprovalResponse
          )
        end

        class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::FunctionCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(String) }
          attr_accessor :name

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `output` using the function tool call output input schema.
          sig do
            params(

              call_id: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            name:,

            type: :function_call_output
          )
          end

          sig do
            override.returns(
              {call_id: String, name: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class CustomToolCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::CustomToolCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `output` using the custom tool call output input schema. The original
          # custom tool call supplies the tool's name.
          sig do
            params(

              call_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            type: :custom_tool_call_output
          )
          end

          sig do
            override.returns(
              {call_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class ComputerCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::ComputerCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `output` using the computer tool call output input schema, including any
          # required `acknowledged_safety_checks`.
          sig do
            params(

              call_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            type: :computer_call_output
          )
          end

          sig do
            override.returns(
              {call_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class ShellCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::ShellCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `output` using the shell tool call output input schema. Each output entry
          # includes `stdout`, `stderr`, and `outcome`.
          sig do
            params(

              call_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            type: :shell_call_output
          )
          end

          sig do
            override.returns(
              {call_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class ApplyPatchCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::ApplyPatchCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `status` and optional `output` using the apply patch tool call output
          # input schema.
          sig do
            params(

              call_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            type: :apply_patch_call_output
          )
          end

          sig do
            override.returns(
              {call_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class ToolSearchOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :call_id

          sig { returns(OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution::TaggedSymbol) }
          attr_accessor :execution

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `tools` using the tool search output input schema, retaining
          # `execution: "client"`.
          sig do
            params(

              call_id: String,

              execution: OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution::OrSymbol,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            call_id:,

            execution:,

            type: :tool_search_output
          )
          end

          sig do
            override.returns(
              {
                call_id: String,
                execution: OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution::TaggedSymbol,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          module Execution
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CLIENT = T.let(
              :client,
              OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution::TaggedSymbol
            )

            sig {
              override.returns(
                T::Array[OpenAI::Beta::BetaResponseSteerRequiredInput::ToolSearchOutput::Execution::TaggedSymbol]
              )
            }
            def self.values
            end
          end
        end

        class McpApprovalResponse < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseSteerRequiredInput::McpApprovalResponse,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :approval_request_id

          sig { returns(Symbol) }
          attr_accessor :type

          # Supply `approve` using the MCP approval response input schema. An optional
          # `reason` can be supplied when denying the request. The original approval request
          # identifies the tool and server.
          sig do
            params(

              approval_request_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            approval_request_id:,

            type: :mcp_approval_response
          )
          end

          sig do
            override.returns(
              {approval_request_id: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::BetaResponseSteerRequiredInput::Variants]) }
        def self.variants
        end

      end

    end

  end
end

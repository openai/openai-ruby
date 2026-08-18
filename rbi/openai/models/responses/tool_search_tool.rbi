# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolSearchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ToolSearchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the tool. Always `tool_search`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Description shown to the model for a client-executed tool search tool.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # Whether tool search is executed by the server or by the client.
        sig do
          returns(
            T.nilable(OpenAI::Responses::ToolSearchTool::Execution::OrSymbol)
          )
        end
        attr_reader :execution

        sig do
          params(
            execution: OpenAI::Responses::ToolSearchTool::Execution::OrSymbol
          ).void
        end
        attr_writer :execution

        # Parameter schema for a client-executed tool search tool.
        sig { returns(T.nilable(T.anything)) }
        attr_accessor :parameters

        # Hosted or BYOT tool search configuration for deferred tools.
        sig do
          params(
            description: T.nilable(String),
            execution: OpenAI::Responses::ToolSearchTool::Execution::OrSymbol,
            parameters: T.nilable(T.anything),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Description shown to the model for a client-executed tool search tool.
          description: nil,
          # Whether tool search is executed by the server or by the client.
          execution: nil,
          # Parameter schema for a client-executed tool search tool.
          parameters: nil,
          # The type of the tool. Always `tool_search`.
          type: :tool_search
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              description: T.nilable(String),
              execution: OpenAI::Responses::ToolSearchTool::Execution::OrSymbol,
              parameters: T.nilable(T.anything)
            }
          )
        end
        def to_hash
        end

        # Whether tool search is executed by the server or by the client.
        module Execution
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ToolSearchTool::Execution)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER =
            T.let(
              :server,
              OpenAI::Responses::ToolSearchTool::Execution::TaggedSymbol
            )
          CLIENT =
            T.let(
              :client,
              OpenAI::Responses::ToolSearchTool::Execution::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ToolSearchTool::Execution::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end

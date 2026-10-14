# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpListTools < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeMcpListTools,
              OpenAI::Internal::AnyHash
            )
          end

        # The label of the MCP server.
        sig { returns(String) }
        attr_accessor :server_label

        # The tools available on the server.
        sig { returns(T::Array[OpenAI::Realtime::RealtimeMcpListTools::Tool]) }
        attr_accessor :tools

        # The type of the item. Always `mcp_list_tools`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the list.
        sig { returns(T.nilable(String)) }
        attr_reader :id

        sig { params(id: String).void }
        attr_writer :id

        # A Realtime item listing tools available on an MCP server.
        sig do
          params(
            server_label: String,
            tools:
              T::Array[OpenAI::Realtime::RealtimeMcpListTools::Tool::OrHash],
            id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The label of the MCP server.
          server_label:,
          # The tools available on the server.
          tools:,
          # The unique ID of the list.
          id: nil,
          # The type of the item. Always `mcp_list_tools`.
          type: :mcp_list_tools
        )
        end

        sig do
          override.returns(
            {
              server_label: String,
              tools: T::Array[OpenAI::Realtime::RealtimeMcpListTools::Tool],
              type: Symbol,
              id: String
            }
          )
        end
        def to_hash
        end

        class Tool < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeMcpListTools::Tool,
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
    end
  end
end

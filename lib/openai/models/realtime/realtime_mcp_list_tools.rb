# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpListTools < OpenAI::Internal::Type::BaseModel
        # @!attribute server_label
        #   The label of the MCP server.
        #
        #   @return [String]
        required :server_label, String

        # @!attribute tools
        #   The tools available on the server.
        #
        #   @return [Array<OpenAI::Models::Realtime::RealtimeMcpListTools::Tool>]
        required :tools, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RealtimeMcpListTools::Tool] }

        # @!attribute type
        #   The type of the item. Always `mcp_list_tools`.
        #
        #   @return [Symbol, :mcp_list_tools]
        required :type, const: :mcp_list_tools

        # @!attribute id
        #   The unique ID of the list.
        #
        #   @return [String, nil]
        optional :id, String

        # @!method initialize(server_label:, tools:, id: nil, type: :mcp_list_tools)
        #   A Realtime item listing tools available on an MCP server.
        #
        #   @param server_label [String] The label of the MCP server.
        #
        #   @param tools [Array<OpenAI::Models::Realtime::RealtimeMcpListTools::Tool>] The tools available on the server.
        #
        #   @param id [String] The unique ID of the list.
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
          #   {OpenAI::Models::Realtime::RealtimeMcpListTools::Tool} for more details.
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
    end
  end
end

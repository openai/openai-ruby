# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module BetaMcpToolCallError
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :mcp_protocol_error, -> { OpenAI::Beta::BetaMcpToolCallError::McpProtocolError }

        variant :mcp_tool_execution_error, -> { OpenAI::Beta::BetaMcpToolCallError::McpToolExecutionError }

        variant :http_error, -> { OpenAI::Beta::BetaMcpToolCallError::HTTPError }

        class McpProtocolError < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #
          #   @return [Integer]
          required :code, Integer

          # @!attribute message
          #
          #   @return [String]
          required :message, String

          # @!attribute type
          #
          #   @return [Symbol, :mcp_protocol_error]
          required :type, const: :mcp_protocol_error

          # @!method initialize(code:, message:, type: :mcp_protocol_error)
          #   @param code [Integer]
          #   @param message [String]
          #   @param type [Symbol, :mcp_protocol_error]
        end

        class McpToolExecutionError < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #
          #   @return [Object]
          required :content, OpenAI::Internal::Type::Unknown

          # @!attribute type
          #
          #   @return [Symbol, :mcp_tool_execution_error]
          required :type, const: :mcp_tool_execution_error

          # @!method initialize(content:, type: :mcp_tool_execution_error)
          #   @param content [Object]
          #   @param type [Symbol, :mcp_tool_execution_error]
        end

        class HTTPError < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #
          #   @return [Integer]
          required :code, Integer

          # @!attribute message
          #
          #   @return [String]
          required :message, String

          # @!attribute type
          #
          #   @return [Symbol, :http_error]
          required :type, const: :http_error

          # @!method initialize(code:, message:, type: :http_error)
          #   @param code [Integer]
          #   @param message [String]
          #   @param type [Symbol, :http_error]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaMcpToolCallError::McpProtocolError, OpenAI::Models::Beta::BetaMcpToolCallError::McpToolExecutionError, OpenAI::Models::Beta::BetaMcpToolCallError::HTTPError)]
      end
    end

    BetaMcpToolCallError = Beta::BetaMcpToolCallError
  end
end

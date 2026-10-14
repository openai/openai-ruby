# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A credential-free transport used to connect to an MCP server.
      module PersistedMcpTransport
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Connects to an MCP server over HTTP.
        variant :http, -> { OpenAI::Beta::PersistedMcpTransport::HTTP }

        # Starts an MCP server as a local process.
        variant :stdio, -> { OpenAI::Beta::PersistedMcpTransport::Stdio }

        class HTTP < OpenAI::Internal::Type::BaseModel
          # @!attribute headers
          #   Non-secret HTTP headers sent to the MCP server.
          #
          #   @return [Hash{Symbol=>String}]
          required :headers, OpenAI::Internal::Type::HashOf[String]

          # @!attribute server_url
          #   The URL of the MCP server.
          #
          #   @return [String]
          required :server_url, String

          # @!attribute type
          #   The type of the object. Always `http`.
          #
          #   @return [Symbol, :http]
          required :type, const: :http

          # @!method initialize(headers:, server_url:, type: :http)
          #   Connects to an MCP server over HTTP.
          #
          #   @param headers [Hash{Symbol=>String}]
          #     Non-secret HTTP headers sent to the MCP server.
          #
          #   @param server_url [String]
          #     The URL of the MCP server.
          #
          #   @param type [Symbol, :http]
          #     The type of the object. Always `http`.
        end

        class Stdio < OpenAI::Internal::Type::BaseModel
          # @!attribute args
          #   Arguments passed to the MCP server command.
          #
          #   @return [Array<String>]
          required :args, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute command
          #   The command used to start the MCP server.
          #
          #   @return [String]
          required :command, String

          # @!attribute cwd
          #   The working directory used to start the MCP server.
          #
          #   @return [String]
          required :cwd, String

          # @!attribute env_vars
          #   Environment variable names inherited from the execution environment.
          #
          #   @return [Array<String>]
          required :env_vars, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute type
          #   The type of the object. Always `stdio`.
          #
          #   @return [Symbol, :stdio]
          required :type, const: :stdio

          # @!method initialize(args:, command:, cwd:, env_vars:, type: :stdio)
          #   Starts an MCP server as a local process.
          #
          #   @param args [Array<String>]
          #     Arguments passed to the MCP server command.
          #
          #   @param command [String]
          #     The command used to start the MCP server.
          #
          #   @param cwd [String]
          #     The working directory used to start the MCP server.
          #
          #   @param env_vars [Array<String>]
          #     Environment variable names inherited from the execution environment.
          #
          #   @param type [Symbol, :stdio]
          #     The type of the object. Always `stdio`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::PersistedMcpTransport::HTTP, OpenAI::Models::Beta::PersistedMcpTransport::Stdio)]
      end
    end
  end
end

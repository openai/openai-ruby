# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A credential-free transport used to connect to an MCP server.
      module PersistedMcpTransportParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Connects to an MCP server over HTTP.
        variant :http, -> { OpenAI::Beta::PersistedMcpTransportParam::HTTP }

        # Starts an MCP server as a local process.
        variant :stdio, -> { OpenAI::Beta::PersistedMcpTransportParam::Stdio }

        class HTTP < OpenAI::Internal::Type::BaseModel
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

          # @!attribute headers
          #   Non-secret HTTP headers sent to the MCP server.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :headers, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!method initialize(server_url:, headers: nil, type: :http)
          #   Connects to an MCP server over HTTP.
          #
          #   @param server_url [String]
          #     The URL of the MCP server.
          #
          #   @param headers [Hash{Symbol=>String}, nil]
          #     Non-secret HTTP headers sent to the MCP server.
          #
          #   @param type [Symbol, :http]
          #     The type of the object. Always `http`.
        end

        class Stdio < OpenAI::Internal::Type::BaseModel
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

          # @!attribute type
          #   The type of the object. Always `stdio`.
          #
          #   @return [Symbol, :stdio]
          required :type, const: :stdio

          # @!attribute args
          #   Arguments passed to the MCP server command.
          #
          #   @return [Array<String>, nil]
          optional :args, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute env_vars
          #   Environment variable names to inherit from the selected execution environment.
          #
          #   @return [Array<String>, nil]
          optional :env_vars, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!method initialize(command:, cwd:, args: nil, env_vars: nil, type: :stdio)
          #   Starts an MCP server as a local process.
          #
          #   @param command [String]
          #     The command used to start the MCP server.
          #
          #   @param cwd [String]
          #     The working directory used to start the MCP server.
          #
          #   @param args [Array<String>, nil]
          #     Arguments passed to the MCP server command.
          #
          #   @param env_vars [Array<String>, nil]
          #     Environment variable names to inherit from the selected execution environment.
          #
          #   @param type [Symbol, :stdio]
          #     The type of the object. Always `stdio`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::PersistedMcpTransportParam::HTTP, OpenAI::Models::Beta::PersistedMcpTransportParam::Stdio)]
      end
    end
  end
end

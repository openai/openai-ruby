# typed: strong

module OpenAI
  module Models

    module Beta

      # The transport used to connect to an MCP server.
      module McpTransport
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::McpTransport::HTTP,
            OpenAI::Beta::McpTransport::Stdio
          )
        end

        class HTTP < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::McpTransport::HTTP,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the MCP server.
          sig { returns(String) }
          attr_accessor :server_url

          # The type of the object. Always `http`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Connects to an MCP server over HTTP.
          sig do
            params(

              server_url: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the MCP server.
            server_url:,

            # The type of the object. Always `http`.

            type: :http
          )
          end

          sig do
            override.returns(
              {server_url: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Stdio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::McpTransport::Stdio,
              OpenAI::Internal::AnyHash
            )
          end

          # Arguments passed to the MCP server command.
          sig { returns(T::Array[String]) }
          attr_accessor :args

          # The command used to start the MCP server.
          sig { returns(String) }
          attr_accessor :command

          # The working directory used to start the MCP server.
          sig { returns(String) }
          attr_accessor :cwd

          # Environment variable names inherited from the execution environment.
          sig { returns(T::Array[String]) }
          attr_accessor :env_vars

          # The type of the object. Always `stdio`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Starts an MCP server as a local process.
          sig do
            params(

              args: T::Array[String],

              command: String,

              cwd: String,

              env_vars: T::Array[String],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Arguments passed to the MCP server command.
            args:,

            # The command used to start the MCP server.
            command:,

            # The working directory used to start the MCP server.
            cwd:,

            # Environment variable names inherited from the execution environment.
            env_vars:,

            # The type of the object. Always `stdio`.

            type: :stdio
          )
          end

          sig do
            override.returns(
              {args: T::Array[String], command: String, cwd: String, env_vars: T::Array[String], type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::McpTransport::Variants]) }
        def self.variants
        end

      end

    end

  end
end

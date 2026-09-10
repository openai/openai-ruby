# typed: strong

module OpenAI
  module Models

    module Beta

      # The transport used to connect to an MCP server.
      module McpTransportParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::McpTransportParam::HTTP,
            OpenAI::Beta::McpTransportParam::Stdio
          )
        end

        class HTTP < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::McpTransportParam::HTTP,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the MCP server.
          sig { returns(String) }
          attr_accessor :server_url

          # The type of the object. Always `http`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The authorization value sent to the MCP server, if any.
          sig { returns(T.nilable(String)) }
          attr_accessor :authorization

          # Additional HTTP headers sent to the MCP server.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :headers

          # Connects to an MCP server over HTTP.
          sig do
            params(

              server_url: String,

              authorization: T.nilable(String),

              headers: T.nilable(T::Hash[Symbol, String]),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the MCP server.
            server_url:,

            # The authorization value sent to the MCP server, if any.
            authorization: nil,

            # Additional HTTP headers sent to the MCP server.
            headers: nil,

            # The type of the object. Always `http`.

            type: :http
          )
          end

          sig do
            override.returns(
              {
                server_url: String,
                type: Symbol,
                authorization: T.nilable(String),
                headers: T.nilable(T::Hash[Symbol, String])
              }
            )
          end
          def to_hash
          end

        end

        class Stdio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::McpTransportParam::Stdio,
              OpenAI::Internal::AnyHash
            )
          end

          # The command used to start the MCP server.
          sig { returns(String) }
          attr_accessor :command

          # The working directory used to start the MCP server.
          sig { returns(String) }
          attr_accessor :cwd

          # The type of the object. Always `stdio`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Arguments passed to the MCP server command.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :args

          # Environment variables set for the MCP server process.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :env

          # Environment variable names to inherit from the selected execution environment.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :env_vars

          # Starts an MCP server as a local process.
          sig do
            params(

              command: String,

              cwd: String,

              args: T.nilable(T::Array[String]),

              env: T.nilable(T::Hash[Symbol, String]),

              env_vars: T.nilable(T::Array[String]),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The command used to start the MCP server.
            command:,

            # The working directory used to start the MCP server.
            cwd:,

            # Arguments passed to the MCP server command.
            args: nil,

            # Environment variables set for the MCP server process.
            env: nil,

            # Environment variable names to inherit from the selected execution environment.
            env_vars: nil,

            # The type of the object. Always `stdio`.

            type: :stdio
          )
          end

          sig do
            override.returns(
              {
                command: String,
                cwd: String,
                type: Symbol,
                args: T.nilable(T::Array[String]),
                env: T.nilable(T::Hash[Symbol, String]),
                env_vars: T.nilable(T::Array[String])
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::McpTransportParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end

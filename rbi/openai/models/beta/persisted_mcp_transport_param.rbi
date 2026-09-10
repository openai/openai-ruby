# typed: strong

module OpenAI
  module Models

    module Beta

      # A credential-free transport used to connect to an MCP server.
      module PersistedMcpTransportParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::PersistedMcpTransportParam::HTTP,
            OpenAI::Beta::PersistedMcpTransportParam::Stdio
          )
        end

        class HTTP < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedMcpTransportParam::HTTP,
              OpenAI::Internal::AnyHash
            )
          end

          # The URL of the MCP server.
          sig { returns(String) }
          attr_accessor :server_url

          # The type of the object. Always `http`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Non-secret HTTP headers sent to the MCP server.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :headers

          # Connects to an MCP server over HTTP.
          sig do
            params(

              server_url: String,

              headers: T.nilable(T::Hash[Symbol, String]),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the MCP server.
            server_url:,

            # Non-secret HTTP headers sent to the MCP server.
            headers: nil,

            # The type of the object. Always `http`.

            type: :http
          )
          end

          sig do
            override.returns(
              {server_url: String, type: Symbol, headers: T.nilable(T::Hash[Symbol, String])}
            )
          end
          def to_hash
          end

        end

        class Stdio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedMcpTransportParam::Stdio,
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

          # Environment variable names to inherit from the selected execution environment.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :env_vars

          # Starts an MCP server as a local process.
          sig do
            params(

              command: String,

              cwd: String,

              args: T.nilable(T::Array[String]),

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
                env_vars: T.nilable(T::Array[String])
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::PersistedMcpTransportParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end

# typed: strong

module OpenAI
  module Models

    module Beta

      # A credential-free transport used to connect to an MCP server.
      module PersistedMcpTransport
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::PersistedMcpTransport::HTTP,
            OpenAI::Beta::PersistedMcpTransport::Stdio
          )
        end

        class HTTP < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedMcpTransport::HTTP,
              OpenAI::Internal::AnyHash
            )
          end

          # Non-secret HTTP headers sent to the MCP server.
          sig { returns(T::Hash[Symbol, String]) }
          attr_accessor :headers

          # The URL of the MCP server.
          sig { returns(String) }
          attr_accessor :server_url

          # The type of the object. Always `http`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Connects to an MCP server over HTTP.
          sig do
            params(

              headers: T::Hash[Symbol, String],

              server_url: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Non-secret HTTP headers sent to the MCP server.
            headers:,

            # The URL of the MCP server.
            server_url:,

            # The type of the object. Always `http`.

            type: :http
          )
          end

          sig do
            override.returns(
              {headers: T::Hash[Symbol, String], server_url: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Stdio < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedMcpTransport::Stdio,
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

        sig { override.returns(T::Array[OpenAI::Beta::PersistedMcpTransport::Variants]) }
        def self.variants
        end

      end

    end

  end
end

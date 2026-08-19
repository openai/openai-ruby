# typed: strong

module OpenAI
  module Models

    BetaMcpToolCallError = Beta::BetaMcpToolCallError

    module Beta

      module BetaMcpToolCallError
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::BetaMcpToolCallError::McpProtocolError,
            OpenAI::Beta::BetaMcpToolCallError::McpToolExecutionError,
            OpenAI::Beta::BetaMcpToolCallError::HTTPError
          )
        end

        class McpProtocolError < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaMcpToolCallError::McpProtocolError,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Integer) }
          attr_accessor :code

          sig { returns(String) }
          attr_accessor :message

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              code: Integer,

              message: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            code:,

            message:,

            type: :mcp_protocol_error
          )
          end

          sig do
            override.returns(
              {code: Integer, message: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class McpToolExecutionError < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaMcpToolCallError::McpToolExecutionError,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T.anything) }
          attr_accessor :content

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              content: T.anything,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            content:,

            type: :mcp_tool_execution_error
          )
          end

          sig do
            override.returns(
              {content: T.anything, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class HTTPError < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaMcpToolCallError::HTTPError,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Integer) }
          attr_accessor :code

          sig { returns(String) }
          attr_accessor :message

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              code: Integer,

              message: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            code:,

            message:,

            type: :http_error
          )
          end

          sig do
            override.returns(
              {code: Integer, message: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::BetaMcpToolCallError::Variants]) }
        def self.variants
        end

      end

    end

  end
end

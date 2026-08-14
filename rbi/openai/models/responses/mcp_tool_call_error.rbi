# typed: strong

module OpenAI
  module Models
    module Responses
      module McpToolCallError
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::McpToolCallError::McpProtocolError,
              OpenAI::Responses::McpToolCallError::McpToolExecutionError,
              OpenAI::Responses::McpToolCallError::HTTPError
            )
          end

        class McpProtocolError < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::McpToolCallError::McpProtocolError,
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
            params(code: Integer, message: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(code:, message:, type: :mcp_protocol_error)
          end

          sig do
            override.returns({ code: Integer, message: String, type: Symbol })
          end
          def to_hash
          end
        end

        class McpToolExecutionError < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::McpToolCallError::McpToolExecutionError,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(T.anything) }
          attr_accessor :content

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(content: T.anything, type: Symbol).returns(T.attached_class)
          end
          def self.new(content:, type: :mcp_tool_execution_error)
          end

          sig { override.returns({ content: T.anything, type: Symbol }) }
          def to_hash
          end
        end

        class HTTPError < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::McpToolCallError::HTTPError,
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
            params(code: Integer, message: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(code:, message:, type: :http_error)
          end

          sig do
            override.returns({ code: Integer, message: String, type: Symbol })
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::McpToolCallError::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end

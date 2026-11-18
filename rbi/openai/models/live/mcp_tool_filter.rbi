# typed: strong

module OpenAI
  module Models

    module Live

      class McpToolFilter < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::McpToolFilter,
            OpenAI::Internal::AnyHash
          )
        end

        # Whether to allow only read-only tools for matching entries.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :read_only

        # A list of tool names to match against.
        sig { returns(T.nilable(T::Array[String])) }
        attr_accessor :tool_names

        sig do
          params(

            read_only: T.nilable(T::Boolean),

            tool_names: T.nilable(T::Array[String])
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Whether to allow only read-only tools for matching entries.
          read_only: nil,

          # A list of tool names to match against.

          tool_names: nil
        )
        end

        sig do
          override.returns(
            {read_only: T.nilable(T::Boolean), tool_names: T.nilable(T::Array[String])}
          )
        end
        def to_hash
        end

      end

    end

  end
end

# typed: strong

module OpenAI
  module Models

    module Live

      class McpRequireApprovalFilter < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::McpRequireApprovalFilter,
            OpenAI::Internal::AnyHash
          )
        end

        # A filter that forces approval for matching tools.
        sig { returns(T.nilable(OpenAI::Live::McpToolFilter)) }
        attr_reader :always

        sig { params(always: T.nilable(OpenAI::Live::McpToolFilter::OrHash)).void }
        attr_writer :always

        # A filter that skips approval for matching tools.
        sig { returns(T.nilable(OpenAI::Live::McpToolFilter)) }
        attr_reader :never

        sig { params(never: T.nilable(OpenAI::Live::McpToolFilter::OrHash)).void }
        attr_writer :never

        sig do
          params(

            always: T.nilable(OpenAI::Live::McpToolFilter::OrHash),

            never: T.nilable(OpenAI::Live::McpToolFilter::OrHash)
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A filter that forces approval for matching tools.
          always: nil,

          # A filter that skips approval for matching tools.

          never: nil
        )
        end

        sig do
          override.returns(
            {always: T.nilable(OpenAI::Live::McpToolFilter), never: T.nilable(OpenAI::Live::McpToolFilter)}
          )
        end
        def to_hash
        end

      end

    end

  end
end

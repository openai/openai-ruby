# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceShell < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ToolChoiceShell, OpenAI::Internal::AnyHash)
          end

        # The tool to call. Always `shell`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Forces the model to call the shell tool when a tool call is required.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The tool to call. Always `shell`.
          type: :shell
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end

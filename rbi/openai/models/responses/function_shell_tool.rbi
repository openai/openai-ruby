# typed: strong

module OpenAI
  module Models
    module Responses
      class FunctionShellTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::FunctionShellTool,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the shell tool. Always `shell`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool that allows the model to execute shell commands.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the shell tool. Always `shell`.
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

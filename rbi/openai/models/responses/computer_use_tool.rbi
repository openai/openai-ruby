# typed: strong

module OpenAI
  module Models
    module Responses
      class ComputerUseTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ComputerUseTool, OpenAI::Internal::AnyHash)
          end

        # The type of the computer tool. Always `computer`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A tool that controls a virtual computer. Learn more about the
        # [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the computer tool. Always `computer`.
          type: :computer
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end

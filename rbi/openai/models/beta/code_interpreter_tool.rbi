# typed: strong

module OpenAI
  module Models

    module Beta

      class CodeInterpreterTool < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::CodeInterpreterTool,
            OpenAI::Internal::AnyHash
          )
        end

        # The type of tool being defined: `code_interpreter`
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The type of tool being defined: `code_interpreter`

          type: :code_interpreter
        )
        end

        sig do
          override.returns(
            {type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end

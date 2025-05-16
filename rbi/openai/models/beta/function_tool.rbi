# typed: strong

module OpenAI
  module Models
    module Beta
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::FunctionTool, OpenAI::Internal::AnyHash)
          end

        sig { returns(OpenAI::FunctionDefinition) }
        attr_reader :function

        sig { params(function: OpenAI::FunctionDefinition::OrHash).void }
        attr_writer :function

        # The type of tool being defined: `function`
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            function: OpenAI::FunctionDefinition::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          function:,
          # The type of tool being defined: `function`
          type: :function
        )
        end

        sig do
          override.returns(
            { function: OpenAI::FunctionDefinition, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end

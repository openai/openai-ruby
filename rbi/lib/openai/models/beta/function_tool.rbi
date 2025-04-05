# typed: strong

module OpenAI
  module Models
    module Beta
      class FunctionTool < OpenAI::Internal::Type::BaseModel
        sig { returns(OpenAI::Models::FunctionDefinition) }
        attr_reader :function

        sig { params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::AnyHash)).void }
        attr_writer :function

        # The type of tool being defined: `function`
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(function:, type: :function); end

        sig { override.returns({function: OpenAI::Models::FunctionDefinition, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end

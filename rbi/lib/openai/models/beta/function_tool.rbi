# typed: strong

module OpenAI
  module Models
    module Beta
      class FunctionTool < OpenAI::BaseModel
        sig { returns(OpenAI::Models::FunctionDefinition) }
        def function
        end

        sig { params(_: OpenAI::Models::FunctionDefinition).returns(OpenAI::Models::FunctionDefinition) }
        def function=(_)
        end

        # The type of tool being defined: `function`
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(function: OpenAI::Models::FunctionDefinition, type: Symbol).returns(T.attached_class) }
        def self.new(function:, type: :function)
        end

        sig { override.returns({function: OpenAI::Models::FunctionDefinition, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    module Beta
      class CodeInterpreterTool < OpenAI::Internal::Type::BaseModel
        # The type of tool being defined: `code_interpreter`
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(type: :code_interpreter)
        end

        sig { override.returns({type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end

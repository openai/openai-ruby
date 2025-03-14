# typed: strong

module OpenAI
  module Models
    module Beta
      class CodeInterpreterTool < OpenAI::BaseModel
        # The type of tool being defined: `code_interpreter`
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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

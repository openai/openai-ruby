# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceFunction < OpenAI::BaseModel
        # The name of the function to call.
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        # For function calling, the type is always `function`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Use this option to force the model to call a specific function.
        sig { params(name: String, type: Symbol).returns(T.attached_class) }
        def self.new(name:, type: :function)
        end

        sig { override.returns({name: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end

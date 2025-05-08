# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceFunction < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The name of the function to call.
        sig { returns(String) }
        attr_accessor :name

        # For function calling, the type is always `function`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Use this option to force the model to call a specific function.
        sig { params(name: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The name of the function to call.
          name:,
          # For function calling, the type is always `function`.
          type: :function
        )
        end

        sig { override.returns({ name: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end

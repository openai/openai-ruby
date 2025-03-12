# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceFunction < OpenAI::BaseModel
        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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

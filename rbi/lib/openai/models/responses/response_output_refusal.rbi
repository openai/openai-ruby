# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputRefusal < OpenAI::BaseModel
        # The refusal explanationfrom the model.
        sig { returns(String) }
        def refusal
        end

        sig { params(_: String).returns(String) }
        def refusal=(_)
        end

        # The type of the refusal. Always `refusal`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A refusal from the model.
        sig { params(refusal: String, type: Symbol).returns(T.attached_class) }
        def self.new(refusal:, type: :refusal)
        end

        sig { override.returns({refusal: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end

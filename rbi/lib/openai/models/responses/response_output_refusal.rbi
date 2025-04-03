# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputRefusal < OpenAI::Internal::Type::BaseModel
        # The refusal explanationfrom the model.
        sig { returns(String) }
        attr_accessor :refusal

        # The type of the refusal. Always `refusal`.
        sig { returns(Symbol) }
        attr_accessor :type

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

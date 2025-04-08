# typed: strong

module OpenAI
  module Models
    module Evals
      class EvalAPIError < OpenAI::Internal::Type::BaseModel
        # The error code.
        sig { returns(String) }
        attr_accessor :code

        # The error message.
        sig { returns(String) }
        attr_accessor :message

        # An object representing an error response from the Eval API.
        sig { params(code: String, message: String).returns(T.attached_class) }
        def self.new(code:, message:); end

        sig { override.returns({code: String, message: String}) }
        def to_hash; end
      end
    end

    EvalAPIError = Evals::EvalAPIError
  end
end

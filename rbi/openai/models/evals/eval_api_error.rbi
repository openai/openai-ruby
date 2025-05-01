# typed: strong

module OpenAI
  module Models
    EvalAPIError = Evals::EvalAPIError

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
        def self.new(
          # The error code.
          code:,
          # The error message.
          message:
        ); end
        sig { override.returns({code: String, message: String}) }
        def to_hash; end
      end
    end
  end
end

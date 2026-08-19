# typed: strong

module OpenAI
  module Models

    EvalAPIError = Evals::EvalAPIError

    module Evals

      class EvalAPIError < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Evals::EvalAPIError,
            OpenAI::Internal::AnyHash
          )
        end

        # The error code.
        sig { returns(String) }
        attr_accessor :code

        # The error message.
        sig { returns(String) }
        attr_accessor :message

        # An object representing an error response from the Eval API.
        sig do
          params(

            code: String,

            message: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The error code.
          code:,

          # The error message.

          message:
        )
        end

        sig do
          override.returns(
            {code: String, message: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end

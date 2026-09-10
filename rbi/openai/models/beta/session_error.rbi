# typed: strong

module OpenAI
  module Models

    module Beta

      class SessionError < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::SessionError,
            OpenAI::Internal::AnyHash
          )
        end

        # The machine-readable error code, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :code

        # A customer-safe explanation of the error.
        sig { returns(String) }
        attr_accessor :message

        # The request parameter associated with the error, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :param

        # The error type.
        sig { returns(String) }
        attr_accessor :type

        # An error payload with the same public fields as Responses API streaming errors.
        sig do
          params(

            code: T.nilable(String),

            message: String,

            param: T.nilable(String),

            type: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The machine-readable error code, if any.
          code:,

          # A customer-safe explanation of the error.
          message:,

          # The request parameter associated with the error, if any.
          param:,

          # The error type.

          type:
        )
        end

        sig do
          override.returns(
            {code: T.nilable(String), message: String, param: T.nilable(String), type: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end

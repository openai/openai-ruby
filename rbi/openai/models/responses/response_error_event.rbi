# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        # The error code.
        sig { returns(T.nilable(String)) }
        attr_accessor :code

        # The error message.
        sig { returns(String) }
        attr_accessor :message

        # The error parameter.
        sig { returns(T.nilable(String)) }
        attr_accessor :param

        # The type of the event. Always `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an error occurs.
        sig do
          params(code: T.nilable(String), message: String, param: T.nilable(String), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(
          # The error code.
          code:,
          # The error message.
          message:,
          # The error parameter.
          param:,
          # The type of the event. Always `error`.
          type: :error
        ); end
        sig do
          override.returns({code: T.nilable(String), message: String, param: T.nilable(String), type: Symbol})
        end
        def to_hash; end
      end
    end
  end
end

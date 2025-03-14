# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseErrorEvent < OpenAI::BaseModel
        # The error code.
        sig { returns(T.nilable(String)) }
        def code
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def code=(_)
        end

        # The error message.
        sig { returns(String) }
        def message
        end

        sig { params(_: String).returns(String) }
        def message=(_)
        end

        # The error parameter.
        sig { returns(T.nilable(String)) }
        def param
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def param=(_)
        end

        # The type of the event. Always `error`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when an error occurs.
        sig do
          params(code: T.nilable(String), message: String, param: T.nilable(String), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(code:, message:, param:, type: :error)
        end

        sig do
          override.returns({code: T.nilable(String), message: String, param: T.nilable(String), type: Symbol})
        end
        def to_hash
        end
      end
    end
  end
end

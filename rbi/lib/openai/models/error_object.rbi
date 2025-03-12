# typed: strong

module OpenAI
  module Models
    class ErrorObject < OpenAI::BaseModel
      sig { returns(T.nilable(String)) }
      def code
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def code=(_)
      end

      sig { returns(String) }
      def message
      end

      sig { params(_: String).returns(String) }
      def message=(_)
      end

      sig { returns(T.nilable(String)) }
      def param
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def param=(_)
      end

      sig { returns(String) }
      def type
      end

      sig { params(_: String).returns(String) }
      def type=(_)
      end

      sig do
        params(code: T.nilable(String), message: String, param: T.nilable(String), type: String)
          .returns(T.attached_class)
      end
      def self.new(code:, message:, param:, type:)
      end

      sig do
        override.returns({code: T.nilable(String), message: String, param: T.nilable(String), type: String})
      end
      def to_hash
      end
    end
  end
end

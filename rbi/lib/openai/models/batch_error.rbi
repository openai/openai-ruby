# typed: strong

module OpenAI
  module Models
    class BatchError < OpenAI::BaseModel
      sig { returns(T.nilable(String)) }
      def code
      end

      sig { params(_: String).returns(String) }
      def code=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def line
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def line=(_)
      end

      sig { returns(T.nilable(String)) }
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

      sig do
        params(code: String, line: T.nilable(Integer), message: String, param: T.nilable(String))
          .returns(T.attached_class)
      end
      def self.new(code: nil, line: nil, message: nil, param: nil)
      end

      sig do
        override.returns({code: String, line: T.nilable(Integer), message: String, param: T.nilable(String)})
      end
      def to_hash
      end
    end
  end
end

# typed: strong

module OpenAI
  module Models
    class ErrorObject < OpenAI::BaseModel
      sig { returns(T.nilable(String)) }
      attr_accessor :code

      sig { returns(String) }
      attr_accessor :message

      sig { returns(T.nilable(String)) }
      attr_accessor :param

      sig { returns(String) }
      attr_accessor :type

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

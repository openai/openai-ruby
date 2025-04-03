# typed: strong

module OpenAI
  module Models
    class BatchError < OpenAI::Internal::Type::BaseModel
      # An error code identifying the error type.
      sig { returns(T.nilable(String)) }
      attr_reader :code

      sig { params(code: String).void }
      attr_writer :code

      # The line number of the input file where the error occurred, if applicable.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :line

      # A human-readable message providing more details about the error.
      sig { returns(T.nilable(String)) }
      attr_reader :message

      sig { params(message: String).void }
      attr_writer :message

      # The name of the parameter that caused the error, if applicable.
      sig { returns(T.nilable(String)) }
      attr_accessor :param

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

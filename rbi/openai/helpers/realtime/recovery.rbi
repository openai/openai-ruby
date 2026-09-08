# typed: strong

module OpenAI
  module Errors
    class RealtimeQueueFullError < OpenAI::Errors::Error
      sig { returns(T.attached_class) }
      def self.new
      end
    end

    class RealtimeReconnectError < OpenAI::Errors::Error
      sig { returns(T::Array[String]) }
      attr_reader :unsent_messages

      sig { returns(T.nilable(String)) }
      attr_reader :uncertain_message

      # @api private
      sig do
        params(message: String, unsent_messages: T::Array[String], uncertain_message: T.nilable(String))
          .returns(T.attached_class)
      end
      def self.new(message:, unsent_messages: [], uncertain_message: nil)
      end
    end
  end
end

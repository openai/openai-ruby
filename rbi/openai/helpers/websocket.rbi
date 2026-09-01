# typed: strong

module OpenAI
  module Errors
    class WebSocketConnectionError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T.nilable(Integer)) }
      attr_reader :http_status

      sig { returns(T.nilable(Exception)) }
      def cause
      end

      # @api private
      sig do
        params(
          url: URI::Generic,
          message: T.nilable(String),
          cause: T.nilable(Exception),
          http_status: T.nilable(Integer)
        )
          .returns(T.attached_class)
      end
      def self.new(url:, message: nil, cause: nil, http_status: nil)
      end
    end

    class WebSocketProtocolError < OpenAI::Errors::Error
    end
  end
end

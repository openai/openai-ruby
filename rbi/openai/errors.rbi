# typed: strong

module OpenAI
  module Errors
    class Error < StandardError
      sig { returns(T.nilable(Exception)) }
      attr_accessor :cause
    end

    class PollingError < OpenAI::Errors::Error
    end

    class PollingTimeoutError < OpenAI::Errors::PollingError
      sig { returns(T.anything) }
      attr_reader :resource

      sig { returns(Float) }
      attr_reader :timeout

      sig { returns(String) }
      attr_reader :operation

      # @api private
      sig do
        params(
          operation: String,
          timeout: Float,
          resource: T.anything
        ).returns(T.attached_class)
      end
      def self.new(operation:, timeout:, resource:)
      end
    end

    class ConversionError < OpenAI::Errors::Error
      sig { returns(T.nilable(StandardError)) }
      def cause
      end

      # @api private
      sig do
        params(
          on: T::Class[StandardError],
          method: Symbol,
          target: T.anything,
          value: T.anything,
          cause: T.nilable(StandardError)
        ).returns(T.attached_class)
      end
      def self.new(on:, method:, target:, value:, cause: nil)
      end
    end

    class RealtimeConnectionError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T.nilable(Exception)) }
      def cause
      end

      sig do
        params(
          url: URI::Generic,
          message: T.nilable(String),
          cause: T.nilable(Exception)
        ).returns(T.attached_class)
      end
      def self.new(url:, message: nil, cause: nil)
      end
    end

    class RealtimeProtocolError < OpenAI::Errors::Error
      sig { returns(String) }
      attr_reader :data

      sig { returns(T.nilable(StandardError)) }
      def cause
      end

      sig do
        params(
          data: String,
          message: T.nilable(String),
          cause: T.nilable(StandardError)
        ).returns(T.attached_class)
      end
      def self.new(data:, message: nil, cause: nil)
      end
    end

    class APIError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_accessor :url

      sig { returns(T.nilable(Integer)) }
      attr_accessor :status

      sig { returns(T.nilable(T::Hash[String, String])) }
      attr_accessor :headers

      sig { returns(T.nilable(T.anything)) }
      attr_accessor :body

      sig { returns(T.nilable(String)) }
      attr_accessor :code

      sig { returns(T.nilable(String)) }
      attr_accessor :param

      sig { returns(T.nilable(String)) }
      attr_accessor :type

      # The ID of the API request, returned via the `x-request-id` response
      # header. This is nil when no HTTP response was received or the response
      # did not include the header.
      sig { returns(T.nilable(String)) }
      def request_id
      end

      # @api private
      sig do
        params(
          url: URI::Generic,
          status: T.nilable(Integer),
          headers: T.nilable(T::Hash[String, String]),
          body: T.nilable(Object),
          request: NilClass,
          response: NilClass,
          message: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.new(
        url:,
        status: nil,
        headers: nil,
        body: nil,
        request: nil,
        response: nil,
        message: nil
      )
      end
    end

    class APIConnectionError < OpenAI::Errors::APIError
      sig { returns(NilClass) }
      attr_accessor :status

      sig { returns(NilClass) }
      attr_accessor :body

      sig { returns(NilClass) }
      attr_accessor :code

      sig { returns(NilClass) }
      attr_accessor :param

      sig { returns(NilClass) }
      attr_accessor :type

      # @api private
      sig do
        params(
          url: URI::Generic,
          status: NilClass,
          headers: T.nilable(T::Hash[String, String]),
          body: NilClass,
          request: NilClass,
          response: NilClass,
          message: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.new(
        url:,
        status: nil,
        headers: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Connection error."
      )
      end
    end

    class APITimeoutError < OpenAI::Errors::APIConnectionError
      # @api private
      sig do
        params(
          url: URI::Generic,
          status: NilClass,
          headers: T.nilable(T::Hash[String, String]),
          body: NilClass,
          request: NilClass,
          response: NilClass,
          message: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.new(
        url:,
        status: nil,
        headers: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Request timed out."
      )
      end
    end

    class APIStatusError < OpenAI::Errors::APIError
      # @api private
      sig do
        params(
          url: URI::Generic,
          status: Integer,
          headers: T.nilable(T::Hash[String, String]),
          body: T.nilable(Object),
          request: NilClass,
          response: NilClass,
          message: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.for(
        url:,
        status:,
        headers:,
        body:,
        request:,
        response:,
        message: nil
      )
      end

      sig { returns(Integer) }
      attr_accessor :status

      sig { returns(T.nilable(String)) }
      attr_accessor :code

      sig { returns(T.nilable(String)) }
      attr_accessor :param

      sig { returns(T.nilable(String)) }
      attr_accessor :type

      # @api private
      sig do
        params(
          url: URI::Generic,
          status: Integer,
          headers: T.nilable(T::Hash[String, String]),
          body: T.nilable(Object),
          request: NilClass,
          response: NilClass,
          message: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.new(
        url:,
        status:,
        headers:,
        body:,
        request:,
        response:,
        message: nil
      )
      end
    end

    class BadRequestError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 400
    end

    class AuthenticationError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 401
    end

    class PermissionDeniedError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 403
    end

    class NotFoundError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 404
    end

    class ConflictError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 409
    end

    class UnprocessableEntityError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 422
    end

    class RateLimitError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = 429
    end

    class InternalServerError < OpenAI::Errors::APIStatusError
      HTTP_STATUS = T.let((500..), T::Range[Integer])
    end
  end
end

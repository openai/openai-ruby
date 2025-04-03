# frozen_string_literal: true

module OpenAI
  module Errors
    class Error < StandardError
      # @!parse
      #   # @return [StandardError, nil]
      #   attr_accessor :cause
    end

    class ConversionError < OpenAI::Errors::Error
    end

    class APIError < OpenAI::Errors::Error
      # @return [URI::Generic]
      attr_accessor :url

      # @return [Integer, nil]
      attr_accessor :status

      # @return [Object, nil]
      attr_accessor :body

      # @return [String, nil]
      attr_accessor :code

      # @return [String, nil]
      attr_accessor :param

      # @return [String, nil]
      attr_accessor :type

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer, nil]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(url:, status: nil, body: nil, request: nil, response: nil, message: nil)
        @url = url
        @status = status
        @body = body
        @request = request
        @response = response
        super(message)
      end
    end

    class APIConnectionError < OpenAI::Errors::APIError
      # @!parse
      #   # @return [nil]
      #   attr_accessor :status

      # @!parse
      #   # @return [nil]
      #   attr_accessor :body

      # @!parse
      #   # @return [nil]
      #   attr_accessor :code

      # @!parse
      #   # @return [nil]
      #   attr_accessor :param

      # @!parse
      #   # @return [nil]
      #   attr_accessor :type

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [nil]
      # @param body [nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(
        url:,
        status: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Connection error."
      )
        super
      end
    end

    class APITimeoutError < OpenAI::Errors::APIConnectionError
      # @api private
      #
      # @param url [URI::Generic]
      # @param status [nil]
      # @param body [nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(
        url:,
        status: nil,
        body: nil,
        request: nil,
        response: nil,
        message: "Request timed out."
      )
        super
      end
    end

    class APIStatusError < OpenAI::Errors::APIError
      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      #
      # @return [OpenAI::Errors::APIStatusError]
      def self.for(url:, status:, body:, request:, response:, message: nil)
        kwargs = {
          url: url,
          status: status,
          body: body,
          request: request,
          response: response,
          message: message
        }

        case status
        in 400
          OpenAI::Errors::BadRequestError.new(**kwargs)
        in 401
          OpenAI::Errors::AuthenticationError.new(**kwargs)
        in 403
          OpenAI::Errors::PermissionDeniedError.new(**kwargs)
        in 404
          OpenAI::Errors::NotFoundError.new(**kwargs)
        in 409
          OpenAI::Errors::ConflictError.new(**kwargs)
        in 422
          OpenAI::Errors::UnprocessableEntityError.new(**kwargs)
        in 429
          OpenAI::Errors::RateLimitError.new(**kwargs)
        in (500..)
          OpenAI::Errors::InternalServerError.new(**kwargs)
        else
          OpenAI::Errors::APIStatusError.new(**kwargs)
        end
      end

      # @!parse
      #   # @return [Integer]
      #   attr_accessor :status

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :code

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :param

      # @!parse
      #   # @return [String, nil]
      #   attr_accessor :type

      # @api private
      #
      # @param url [URI::Generic]
      # @param status [Integer]
      # @param body [Object, nil]
      # @param request [nil]
      # @param response [nil]
      # @param message [String, nil]
      def initialize(url:, status:, body:, request:, response:, message: nil)
        message ||= OpenAI::Internal::Util.dig(body, :message) { {url: url.to_s, status: status, body: body} }
        @code = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :code))
        @param = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :param))
        @type = OpenAI::Internal::Type::Converter.coerce(String, OpenAI::Internal::Util.dig(body, :type))
        super(
          url: url,
          status: status,
          body: body,
          request: request,
          response: response,
          message: message&.to_s
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
      HTTP_STATUS = (500..)
    end
  end
end

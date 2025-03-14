# typed: strong

module OpenAI
  class Error < StandardError
    sig { returns(T.nilable(StandardError)) }
    def cause
    end
  end

  class ConversionError < OpenAI::Error
  end

  class APIError < OpenAI::Error
    sig { returns(URI::Generic) }
    def url
    end

    sig { returns(T.nilable(Integer)) }
    def status
    end

    sig { returns(T.nilable(T.anything)) }
    def body
    end

    sig { returns(T.nilable(String)) }
    def code
    end

    sig { returns(T.nilable(String)) }
    def param
    end

    sig { returns(T.nilable(String)) }
    def type
    end

    # @api private
    sig do
      params(
        url: URI::Generic,
        status: T.nilable(Integer),
        body: T.nilable(Object),
        request: NilClass,
        response: NilClass,
        message: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(url:, status: nil, body: nil, request: nil, response: nil, message: nil)
    end
  end

  class APIConnectionError < OpenAI::APIError
    sig { void }
    def status
    end

    sig { void }
    def body
    end

    sig { void }
    def code
    end

    sig { void }
    def param
    end

    sig { void }
    def type
    end

    # @api private
    sig do
      params(
        url: URI::Generic,
        status: NilClass,
        body: NilClass,
        request: NilClass,
        response: NilClass,
        message: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(url:, status: nil, body: nil, request: nil, response: nil, message: "Connection error.")
    end
  end

  class APITimeoutError < OpenAI::APIConnectionError
    # @api private
    sig do
      params(
        url: URI::Generic,
        status: NilClass,
        body: NilClass,
        request: NilClass,
        response: NilClass,
        message: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(url:, status: nil, body: nil, request: nil, response: nil, message: "Request timed out.")
    end
  end

  class APIStatusError < OpenAI::APIError
    # @api private
    sig do
      params(
        url: URI::Generic,
        status: Integer,
        body: T.nilable(Object),
        request: NilClass,
        response: NilClass,
        message: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.for(url:, status:, body:, request:, response:, message: nil)
    end

    sig { returns(Integer) }
    def status
    end

    sig { returns(T.nilable(String)) }
    def code
    end

    sig { returns(T.nilable(String)) }
    def param
    end

    sig { returns(T.nilable(String)) }
    def type
    end

    # @api private
    sig do
      params(
        url: URI::Generic,
        status: Integer,
        body: T.nilable(Object),
        request: NilClass,
        response: NilClass,
        message: T.nilable(String)
      )
        .returns(T.attached_class)
    end
    def self.new(url:, status:, body:, request:, response:, message: nil)
    end
  end

  class BadRequestError < OpenAI::APIStatusError
    HTTP_STATUS = 400
  end

  class AuthenticationError < OpenAI::APIStatusError
    HTTP_STATUS = 401
  end

  class PermissionDeniedError < OpenAI::APIStatusError
    HTTP_STATUS = 403
  end

  class NotFoundError < OpenAI::APIStatusError
    HTTP_STATUS = 404
  end

  class ConflictError < OpenAI::APIStatusError
    HTTP_STATUS = 409
  end

  class UnprocessableEntityError < OpenAI::APIStatusError
    HTTP_STATUS = 422
  end

  class RateLimitError < OpenAI::APIStatusError
    HTTP_STATUS = 429
  end

  class InternalServerError < OpenAI::APIStatusError
    HTTP_STATUS = T.let((500..), T::Range[Integer])
  end
end

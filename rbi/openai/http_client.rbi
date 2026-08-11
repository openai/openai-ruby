# typed: strong

module OpenAI
  class ResponseMetadata
    sig { returns(Integer) }
    attr_reader :status

    sig { returns(T::Hash[String, String]) }
    attr_reader :headers

    sig { returns(T.nilable(String)) }
    attr_reader :request_id

    # @api private
    sig do
      params(status: Integer, headers: T::Hash[String, String]).returns(
        T.attached_class
      )
    end
    def self.new(status:, headers:)
    end
  end

  class RetryEvent
    sig { returns(Integer) }
    attr_reader :attempt

    sig { returns(Integer) }
    attr_reader :max_attempts

    sig { returns(Float) }
    attr_reader :delay

    sig { returns(T.nilable(OpenAI::ResponseMetadata)) }
    attr_reader :response

    sig { returns(T.nilable(OpenAI::Errors::APIConnectionError)) }
    attr_reader :error

    sig do
      params(
        attempt: Integer,
        max_attempts: Integer,
        delay: Float,
        response: T.nilable(OpenAI::ResponseMetadata),
        error: T.nilable(OpenAI::Errors::APIConnectionError)
      ).returns(T.attached_class)
    end
    def self.new(attempt:, max_attempts:, delay:, response:, error:)
    end

    sig { returns(T.nilable(Integer)) }
    def status
    end

    sig { returns(T.nilable(String)) }
    def request_id
    end
  end

  class HTTPClient
    sig { returns(T.untyped) }
    attr_reader :logger

    sig { returns(Symbol) }
    attr_reader :log_level

    sig { returns(T.nilable(T.proc.params(event: OpenAI::RetryEvent).void)) }
    attr_reader :on_retry

    sig do
      params(
        logger: T.untyped,
        log_level: T.any(Symbol, String),
        on_retry: T.nilable(T.proc.params(event: OpenAI::RetryEvent).void)
      ).returns(T.attached_class)
    end
    def self.new(logger: nil, log_level: :off, on_retry: nil)
    end

    class Request
      sig { returns(Symbol) }
      attr_reader :method

      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T::Hash[String, String]) }
      attr_reader :headers

      sig { returns(T.anything) }
      attr_reader :body

      sig { returns(T.nilable(Float)) }
      attr_reader :timeout

      sig do
        params(
          method: Symbol,
          url: URI::Generic,
          headers: T::Hash[String, String],
          body: T.anything,
          timeout: T.nilable(Float)
        ).returns(T.attached_class)
      end
      def self.new(method:, url:, headers:, body:, timeout:)
      end
    end

    class Response
      sig { returns(Integer) }
      attr_reader :status

      sig { returns(T::Hash[String, String]) }
      attr_reader :headers

      sig { returns(T::Enumerable[String]) }
      attr_reader :body

      sig { returns(OpenAI::ResponseMetadata) }
      attr_reader :metadata

      sig do
        params(
          status: Integer,
          headers: T::Hash[String, String],
          body: T.any(String, T::Enumerable[String])
        ).returns(T.attached_class)
      end
      def self.new(status:, headers:, body:)
      end
    end

    sig do
      params(request: OpenAI::HTTPClient::Request).returns(
        OpenAI::HTTPClient::Response
      )
    end
    def execute(request)
    end
  end
end

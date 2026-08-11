# frozen_string_literal: true

require "logger"

module OpenAI
  # Metadata from the HTTP response backing a top-level SDK value.
  class ResponseMetadata
    # The HTTP response status code.
    #
    # @return [Integer]
    attr_reader :status

    # Immutable response headers with lowercase String keys.
    #
    # @return [Hash{String=>String}]
    attr_reader :headers

    # The request ID returned in the `x-request-id` response header.
    #
    # @return [String, nil]
    attr_reader :request_id

    # @api private
    #
    # @param status [Integer]
    # @param headers [Hash{String=>String}]
    def initialize(status:, headers:)
      @status = Integer(status)
      @headers =
        headers.to_h do |name, value|
          [name.to_s.downcase.freeze, value.to_s.dup.freeze]
        end.freeze
      @request_id = @headers["x-request-id"]
      freeze
    end
  end

  # Details about an API request retry that is about to run.
  class RetryEvent
    # The one-based number of the attempt that will run after the delay.
    #
    # @return [Integer]
    attr_reader :attempt

    # The maximum number of attempts, including the initial request.
    #
    # @return [Integer]
    attr_reader :max_attempts

    # The number of seconds the SDK will wait before the next attempt.
    #
    # @return [Float]
    attr_reader :delay

    # Metadata from the retryable HTTP response, if one was received.
    #
    # @return [OpenAI::ResponseMetadata, nil]
    attr_reader :response

    # The connection error that caused the retry, if the request failed before
    # an HTTP response was received.
    #
    # @return [OpenAI::Errors::APIConnectionError, nil]
    attr_reader :error

    # @api private
    #
    # @param attempt [Integer]
    # @param max_attempts [Integer]
    # @param delay [Float]
    # @param response [OpenAI::ResponseMetadata, nil]
    # @param error [OpenAI::Errors::APIConnectionError, nil]
    def initialize(attempt:, max_attempts:, delay:, response:, error:)
      @attempt = Integer(attempt)
      @max_attempts = Integer(max_attempts)
      @delay = Float(delay)
      @response = response
      @error = error
      freeze
    end

    # The status of the retryable response, if one was received.
    #
    # @return [Integer, nil]
    def status = @response&.status

    # The request ID of the retryable response, if one was received.
    #
    # @return [String, nil]
    def request_id = @response&.request_id
  end

  # The transport boundary used by {OpenAI::Client}.
  #
  # Implement {#execute} to replace the SDK's HTTP transport. Subclassing this
  # class is optional; any object that implements the same method is accepted.
  # Subclass this class to use its diagnostics configuration. Most applications
  # should use {OpenAI::NetHTTPClient}.
  class HTTPClient
    # @return [#debug, #info, #warn, #error, nil]
    attr_reader :logger

    # @return [Symbol]
    attr_reader :log_level

    # @return [Proc, nil]
    attr_reader :on_retry

    # @param logger [#debug, #info, #warn, #error, nil]
    # @param log_level [Symbol, String]
    # @param on_retry [Proc, nil]
    def initialize(logger: nil, log_level: logger.nil? ? :off : :info, on_retry: nil)
      unless on_retry.nil? || on_retry.respond_to?(:call)
        raise ArgumentError, "`on_retry` must respond to `call`"
      end

      @log_level = OpenAI::Internal::Logging.normalize_level(log_level)
      OpenAI::Internal::Logging.validate_logger!(logger)
      @logger = logger
      @logger ||= OpenAI::Internal::Logging.default_logger unless @log_level == :off
      @on_retry = on_retry
    end

    # An HTTP request prepared by the SDK.
    class Request
      # @return [Symbol]
      attr_reader :method

      # @return [URI::Generic]
      attr_reader :url

      # @return [Hash{String=>String}]
      attr_reader :headers

      # @return [Object, nil]
      attr_reader :body

      # @return [Float, nil]
      attr_reader :timeout

      # @param method [Symbol]
      # @param url [URI::Generic]
      # @param headers [Hash{String=>String}]
      # @param body [Object, nil]
      # @param timeout [Float, nil]
      def initialize(method:, url:, headers:, body:, timeout:)
        @method = method
        @url = url
        @headers = headers.dup.freeze
        @body = body
        @timeout = timeout
        freeze
      end
    end

    # An HTTP response returned to the SDK.
    class Response
      # @return [Integer]
      attr_reader :status

      # @return [Hash{String=>String}]
      attr_reader :headers

      # The body is normalized to a one-shot enumerable. If the supplied body
      # responds to `close`, the SDK calls it when the body is consumed or
      # discarded.
      #
      # @return [Enumerable<String>]
      attr_reader :body

      # Immutable metadata safe to retain after the response body is consumed.
      #
      # @return [OpenAI::ResponseMetadata]
      attr_reader :metadata

      # @param status [Integer]
      # @param headers [Hash{String=>String}]
      # @param body [String, Enumerable<String>]
      def initialize(status:, headers:, body:)
        unless body.is_a?(String) || body.respond_to?(:each)
          raise ArgumentError, "`body` must be a String or respond to `each`"
        end

        @metadata = OpenAI::ResponseMetadata.new(status: status, headers: headers)
        @status = @metadata.status
        @headers = @metadata.headers
        source = body.is_a?(String) ? [body].freeze : body
        @body = OpenAI::Internal::Util.fused_enum(source) do
          if source.respond_to?(:close)
            source.close
          else
            OpenAI::Internal::Util.close_fused!(source)
          end
        end
        freeze
      end
    end

    # Executes one SDK-prepared HTTP request.
    #
    # Implementations must return an {OpenAI::HTTPClient::Response}. Connection
    # pooling and transport-specific retries belong to the implementation; the
    # SDK remains responsible for API-level retries and redirects. Transport
    # failures should be raised as {OpenAI::Errors::APIConnectionError} or
    # {OpenAI::Errors::APITimeoutError} so the SDK can apply its retry policy;
    # other exceptions propagate without an SDK retry.
    #
    # @param request [OpenAI::HTTPClient::Request]
    # @return [OpenAI::HTTPClient::Response]
    def execute(request)
      raise NotImplementedError, "#{self.class} must implement #execute for #{request.class}"
    end
  end
end

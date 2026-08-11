# frozen_string_literal: true

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

  # The transport boundary used by {OpenAI::Client}.
  #
  # Implement {#execute} to replace the SDK's HTTP transport. Subclassing this
  # class is optional; any object that implements the same method is accepted.
  # Most applications should use {OpenAI::NetHTTPClient}.
  class HTTPClient
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

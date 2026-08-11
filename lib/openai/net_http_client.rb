# frozen_string_literal: true

require_relative "internal/read_io_adapter"

module OpenAI
  # The SDK's pooled Net::HTTP implementation.
  #
  # Network operations from a non-blocking fiber cooperate with its active Ruby
  # Fiber scheduler, allowing concurrent requests and streams without occupying
  # one thread per request.
  #
  # Pass a block to configure each SDK-created connection before it is pooled
  # and started.
  class NetHTTPClient < HTTPClient
    # from the golang stdlib
    # https://github.com/golang/go/blob/c8eced8580028328fde7c03cbfcb720ce15b2358/src/net/http/transport.go#L49
    KEEP_ALIVE_TIMEOUT = 30

    DEFAULT_MAX_CONNECTIONS = [Etc.nprocessors, 99].max

    NETWORK_ERRORS = [
      EOFError,
      IOError,
      SocketError,
      SystemCallError,
      OpenSSL::SSL::SSLError,
      Net::HTTPBadResponse,
      Net::HTTPHeaderSyntaxError,
      Net::ProtocolError,
      (defined?(Zlib::Error) ? Zlib::Error : nil),
      ConnectionPool::PoolShuttingDownError
    ].compact.freeze
    private_constant :NETWORK_ERRORS

    class ConnectionConfigurationError < StandardError
      attr_reader :original

      def initialize(original)
        @original = original
        super()
      end
    end
    private_constant :ConnectionConfigurationError

    # @api private
    #
    # @param url [URI::Generic]
    #
    # @return [Net::HTTP]
    private def connect(url:)
      port =
        case [url.port, url.scheme]
        in [Integer, _]
          url.port
        in [nil, "http" | "ws"]
          Net::HTTP.http_default_port
        in [nil, "https" | "wss"]
          Net::HTTP.https_default_port
        end

      Net::HTTP.new(url.host, port).tap do
        _1.use_ssl = %w[https wss].include?(url.scheme)
        _1.keep_alive_timeout = KEEP_ALIVE_TIMEOUT
        _1.max_retries = 0

        (_1.cert_store = @cert_store) if _1.use_ssl?
      end
    end

    # @api private
    #
    # @param conn [Net::HTTP]
    # @param deadline [Float, nil]
    private def calibrate_socket_timeout(conn, deadline)
      timeout = deadline&.then { remaining_timeout(_1) }
      conn.open_timeout = conn.read_timeout = conn.write_timeout = conn.continue_timeout = timeout
    end

    # @api private
    #
    # @param deadline [Float, nil]
    # @return [Float]
    # @raise [Timeout::Error]
    private def remaining_timeout(deadline)
      timeout = deadline - OpenAI::Internal::Util.monotonic_secs
      raise Timeout::Error, "request timed out" unless timeout.positive?

      timeout
    end

    # @api private
    #
    # @param request [OpenAI::HTTPClient::Request]
    # @param blk [Proc]
    #
    # @yieldparam [String]
    # @return [Array(Net::HTTPGenericRequest, Proc)]
    private def build_request(request, &blk)
      method = request.method
      body = request.body
      req = Net::HTTPGenericRequest.new(
        method.to_s.upcase,
        !body.nil?,
        method != :head,
        URI(request.url.to_s)
      )

      request.headers.each { req[_1] = _2 }

      case body
      in nil
        req["content-length"] ||= 0 unless req["transfer-encoding"]
      in String
        req["content-length"] ||= body.bytesize.to_s unless req["transfer-encoding"]
        req.body_stream = OpenAI::Internal::Util::ReadIOAdapter.new(body, &blk)
      in StringIO
        req["content-length"] ||= body.size.to_s unless req["transfer-encoding"]
        req.body_stream = OpenAI::Internal::Util::ReadIOAdapter.new(body, &blk)
      in Pathname | IO | Enumerator
        req["transfer-encoding"] ||= "chunked" unless req["content-length"]
        req.body_stream = OpenAI::Internal::Util::ReadIOAdapter.new(body, &blk)
      end

      [req, req.body_stream&.method(:close)]
    end

    # @api private
    #
    # @param url [URI::Generic]
    # @param deadline [Float]
    # @param blk [Proc]
    #
    # @raise [Timeout::Error]
    # @yieldparam [Net::HTTP]
    private def with_pool(url, deadline:, &blk)
      origin = OpenAI::Internal::Util.uri_origin(url)
      pool =
        @mutex.synchronize do
          @pools[origin] ||= ConnectionPool.new(size: @size) do
            configured_connection(url)
          end
        end

      return pool.with(timeout: remaining_timeout(deadline), &blk) if deadline

      checked_out = false
      begin
        pool.with do |connection|
          checked_out = true
          blk.call(connection)
        end
      rescue ConnectionPool::TimeoutError
        retry unless checked_out
        raise
      end
    end

    # @api private
    #
    # @param url [URI::Generic]
    #
    # @return [Net::HTTP]
    private def configured_connection(url)
      connection = nil
      connection = connect(url: url)
      begin
        @connection_configurator&.call(connection)
      rescue StandardError => e
        raise ConnectionConfigurationError.new(e)
      end

      if connection.started?
        raise ArgumentError, "connection configuration must leave the connection unstarted"
      end

      expected_ssl = %w[https wss].include?(url.scheme)
      unless connection.use_ssl? == expected_ssl
        raise ArgumentError, "connection configuration must preserve TLS for the requested URL"
      end

      connection.max_retries = 0
      connection
    rescue StandardError
      begin
        connection.finish if connection&.started?
      rescue StandardError
        nil
      end
      raise
    end

    # Closes current pooled connections. The client remains reusable and will
    # create fresh pools on subsequent requests.
    #
    # In-flight requests are allowed to finish before their connection closes.
    #
    # @return [void]
    def close
      pools =
        @mutex.synchronize do
          current_pools = @pools
          @pools = {}
          current_pools
        end
      pools.each_value do |pool|
        pool.shutdown { |connection| connection.finish if connection.started? }
      end
      nil
    end

    # Executes a request using a pooled Net::HTTP connection.
    #
    # @param request [OpenAI::HTTPClient::Request]
    # @return [OpenAI::HTTPClient::Response]
    def execute(request)
      url = request.url
      deadline = request.timeout&.then { OpenAI::Internal::Util.monotonic_secs + _1 }

      req = nil
      finished = false

      # rubocop:disable Metrics/BlockLength
      enum = Enumerator.new do |y|
        next if finished

        with_pool(url, deadline: deadline) do |conn|
          eof = false
          closing = nil
          ::Thread.handle_interrupt(Object => :never) do
            ::Thread.handle_interrupt(Object => :immediate) do
              req, closing = build_request(request) do
                calibrate_socket_timeout(conn, deadline)
              end

              calibrate_socket_timeout(conn, deadline)
              conn.start unless conn.started?

              calibrate_socket_timeout(conn, deadline)
              ::Kernel.catch(:jump) do
                conn.request(req) do |rsp|
                  y << [req, rsp]
                  ::Kernel.throw(:jump) if finished

                  rsp.read_body do |bytes|
                    y << bytes.force_encoding(Encoding::BINARY)
                    ::Kernel.throw(:jump) if finished

                    calibrate_socket_timeout(conn, deadline)
                  end
                  eof = true
                end
              end
            end
          ensure
            begin
              conn.finish if !eof && conn&.started?
            ensure
              closing&.call
            end
          end
        end
      rescue ConnectionConfigurationError => e
        raise e.original, cause: e.original.cause
      rescue Timeout::Error
        raise OpenAI::Errors::APITimeoutError.new(url: url, request: req)
      rescue *NETWORK_ERRORS
        raise OpenAI::Errors::APIConnectionError.new(url: url, request: req)
      end
      # rubocop:enable Metrics/BlockLength

      _, response = enum.next
      body = OpenAI::Internal::Util.fused_enum(enum, external: true) do
        finished = true
        loop { enum.next }
      end
      OpenAI::HTTPClient::Response.new(
        status: Integer(response.code),
        headers: response.each_header.to_h,
        body: body
      )
    end

    # @param size [Integer]
    # @param logger [#debug, #info, #warn, #error, nil]
    # @param log_level [Symbol, String]
    # @param on_retry [Proc, nil]
    # @param connection_configurator [#call, nil] A block that configures every
    #   SDK-created Net::HTTP connection before it is pooled and started.
    def initialize(
      size: self.class::DEFAULT_MAX_CONNECTIONS,
      logger: nil,
      log_level: logger.nil? ? :off : :info,
      on_retry: nil,
      &connection_configurator
    )
      super(logger: logger, log_level: log_level, on_retry: on_retry)
      @mutex = Mutex.new
      @size = size
      @cert_store = OpenSSL::X509::Store.new.tap(&:set_default_paths)
      @connection_configurator = connection_configurator
      @pools = {}
    end
  end
end

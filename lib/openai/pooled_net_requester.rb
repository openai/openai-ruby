# frozen_string_literal: true

module OpenAI
  # @api private
  class PooledNetRequester
    class << self
      # @api private
      #
      # @param url [URI::Generic]
      #
      # @return [Net::HTTP]
      def connect(url)
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
          _1.max_retries = 0
        end
      end

      # @api private
      #
      # @param conn [Net::HTTP]
      # @param deadline [Float]
      def calibrate_socket_timeout(conn, deadline)
        timeout = deadline - OpenAI::Util.monotonic_secs
        conn.open_timeout = conn.read_timeout = conn.write_timeout = conn.continue_timeout = timeout
      end

      # @api private
      #
      # @param request [Hash{Symbol=>Object}] .
      #
      #   @option request [Symbol] :method
      #
      #   @option request [URI::Generic] :url
      #
      #   @option request [Hash{String=>String}] :headers
      #
      # @param blk [Proc]
      #
      # @return [Net::HTTPGenericRequest]
      def build_request(request, &)
        method, url, headers, body = request.fetch_values(:method, :url, :headers, :body)
        req = Net::HTTPGenericRequest.new(
          method.to_s.upcase,
          !body.nil?,
          method != :head,
          url.to_s
        )

        headers.each { req[_1] = _2 }

        case body
        in nil
        in String
          req["content-length"] ||= body.bytesize.to_s unless req["transfer-encoding"]
          req.body_stream = OpenAI::Util::ReadIOAdapter.new(body, &)
        in StringIO
          req["content-length"] ||= body.size.to_s unless req["transfer-encoding"]
          req.body_stream = OpenAI::Util::ReadIOAdapter.new(body, &)
        in IO | Enumerator
          req["transfer-encoding"] ||= "chunked" unless req["content-length"]
          req.body_stream = OpenAI::Util::ReadIOAdapter.new(body, &)
        end

        req
      end
    end

    # @api private
    #
    # @param url [URI::Generic]
    # @param blk [Proc]
    private def with_pool(url, &)
      origin = OpenAI::Util.uri_origin(url)
      pool =
        @mutex.synchronize do
          @pools[origin] ||= ConnectionPool.new(size: @size) do
            self.class.connect(url)
          end
        end

      pool.with(&)
    end

    # @api private
    #
    # @param request [Hash{Symbol=>Object}] .
    #
    #   @option request [Symbol] :method
    #
    #   @option request [URI::Generic] :url
    #
    #   @option request [Hash{String=>String}] :headers
    #
    #   @option request [Object] :body
    #
    #   @option request [Float] :deadline
    #
    # @return [Array(Net::HTTPResponse, Enumerable)]
    def execute(request)
      url, deadline = request.fetch_values(:url, :deadline)

      eof = false
      finished = false
      enum = Enumerator.new do |y|
        with_pool(url) do |conn|
          next if finished

          req = self.class.build_request(request) do
            self.class.calibrate_socket_timeout(conn, deadline)
          end

          self.class.calibrate_socket_timeout(conn, deadline)
          conn.start unless conn.started?

          self.class.calibrate_socket_timeout(conn, deadline)
          conn.request(req) do |rsp|
            y << [conn, rsp]
            break if finished

            rsp.read_body do |bytes|
              y << bytes
              break if finished

              self.class.calibrate_socket_timeout(conn, deadline)
            end
            eof = true
          end
        end
      end

      conn, response = enum.next
      body = OpenAI::Util.fused_enum(enum, external: true) do
        finished = true
        tap do
          enum.next
        rescue StopIteration
          nil
        end
        conn.finish if !eof && conn&.started?
      end
      [response, (response.body = body)]
    end

    # @api private
    #
    # @param size [Integer]
    def initialize(size: Etc.nprocessors)
      @mutex = Mutex.new
      @size = size
      @pools = {}
    end
  end
end

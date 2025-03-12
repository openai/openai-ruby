# frozen_string_literal: true

module OpenAI
  # @private
  #
  class PooledNetRequester
    class << self
      # @private
      #
      # @param url [URI::Generic]
      #
      # @return [Net::HTTP]
      #
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

      # @private
      #
      # @param conn [Net::HTTP]
      # @param deadline [Float]
      #
      def calibrate_socket_timeout(conn, deadline)
        timeout = deadline - OpenAI::Util.monotonic_secs
        conn.open_timeout = conn.read_timeout = conn.write_timeout = conn.continue_timeout = timeout
      end

      # @private
      #
      # @param request [Hash{Symbol=>Object}] .
      #
      #   @option request [Symbol] :method
      #
      #   @option request [URI::Generic] :url
      #
      #   @option request [Hash{String=>String}] :headers
      #
      # @return [Net::HTTPGenericRequest]
      #
      def build_request(request)
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
          req.body = body
        in StringIO
          req.body = body.string
        in IO
          body.rewind
          req.body_stream = body
        end

        req
      end
    end

    # @private
    #
    # @param url [URI::Generic]
    # @param blk [Proc]
    #
    private def with_pool(url, &blk)
      origin = OpenAI::Util.uri_origin(url)
      th = Thread.current
      key = :"#{object_id}-#{self.class.name}-connection_in_use_for_#{origin}"

      if th[key]
        tap do
          conn = self.class.connect(url)
          return blk.call(conn)
        ensure
          conn.finish if conn&.started?
        end
      end

      pool =
        @mutex.synchronize do
          @pools[origin] ||= ConnectionPool.new(size: Etc.nprocessors) do
            self.class.connect(url)
          end
        end

      pool.with do |conn|
        th[key] = true
        blk.call(conn)
      ensure
        th[key] = nil
      end
    end

    # @private
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
    #
    def execute(request)
      url, deadline = request.fetch_values(:url, :deadline)
      req = self.class.build_request(request)

      eof = false
      finished = false
      enum = Enumerator.new do |y|
        with_pool(url) do |conn|
          next if finished

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

    def initialize
      @mutex = Mutex.new
      @pools = {}
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Product-neutral transport backed by the optional async-websocket gem.
    #
    # @api private
    class AsyncWebSocketTransport
      REDACTED_HEADER_VALUE = "[REDACTED]"
      private_constant :REDACTED_HEADER_VALUE

      # Preserve real header fields for the wire while presenting a safe snapshot to
      # Protocol::HTTP1 tracing, which calls #to_h before writing the request.
      class TraceSafeHeaderFields
        include Enumerable

        def initialize(fields)
          @fields = fields.to_a.freeze
        end

        def each(&block) = @fields.each(&block)

        def to_h
          @fields.to_h do |name, value|
            safe_value = if OpenAI::Internal::Logging.sensitive_header?(name)
              REDACTED_HEADER_VALUE
            else
              value
            end

            [name, safe_value]
          end
        end
      end

      private_constant :TraceSafeHeaderFields

      module TraceSafeHeaders
        def header(&block)
          return super(&block) if block

          TraceSafeHeaderFields.new(super)
        end
      end

      private_constant :TraceSafeHeaders

      # HTTP/1 tracing observes the request target passed to #write_request.
      # Keep that target redacted while restoring the real call ID only at the
      # private connection's first serialized request-line boundary.
      class TraceSafeRequestStream
        def initialize(stream, trace_request_line:, wire_request_line:)
          @stream = stream
          @trace_request_line = trace_request_line
          @wire_request_line = wire_request_line
          @first_write = true
        end

        def write(data)
          if @first_write
            @first_write = false
            unless data == @trace_request_line
              raise IOError, "Unexpected WebSocket request-line serialization."
            end

            data = @wire_request_line
          end

          @stream.write(data)
        end
      end

      private_constant :TraceSafeRequestStream

      module TraceSafeRequestWriter
        def write_request(authority, method, target, version, headers)
          return super unless @sensitive_query_parameter

          trace_target = target.gsub(/([?&])([^&=]+)(?:=[^&]*)?/) do |parameter|
            separator = Regexp.last_match(1)
            name = Regexp.last_match(2)
            if URI.decode_www_form_component(name) == @sensitive_query_parameter
              "#{separator}#{name}=[REDACTED]"
            else
              parameter
            end
          end

          original_stream = @stream
          @stream = TraceSafeRequestStream.new(
            original_stream,
            trace_request_line: "#{method} #{trace_target} #{version}\r\n",
            wire_request_line: "#{method} #{target} #{version}\r\n"
          )

          super(authority, method, trace_target, version, headers)
        ensure
          @stream = original_stream
        end
      end

      private_constant :TraceSafeRequestWriter

      class TraceSafeProtocol
        def initialize(protocol, sensitive_query_parameter:)
          @protocol = protocol
          @sensitive_query_parameter = sensitive_query_parameter
        end

        def client(peer, **options)
          @protocol.client(peer, **options).tap do |client|
            client.extend(TraceSafeRequestWriter)
            client.instance_variable_set(:@sensitive_query_parameter, @sensitive_query_parameter)
          end
        end

        def to_s = @protocol.to_s
      end

      private_constant :TraceSafeProtocol

      # Async's ordinary framer close flushes buffered output. Exceptional cleanup
      # must instead close the raw socket first, then release the acquired pool slot.
      module AbortableFramer
        def abort
          stream = @stream
          pool = @pool
          connection = @connection
          @pool = nil
          @connection = nil

          begin
            io = stream.to_io
            io.close unless io.closed?
          ensure
            pool&.release(connection)
          end
        end
      end

      private_constant :AbortableFramer

      # Configure the native TLS context used by secure WebSockets.
      # Peer and hostname verification and HTTP/1.1 ALPN remain SDK-owned.
      def initialize(
        product_name:,
        error_class:,
        error_factory:,
        dependency_message: nil,
        sensitive_query_parameter: nil,
        &tls_configurator
      )
        @product_name = product_name
        @error_class = error_class
        @error_factory = error_factory
        @dependency_message = dependency_message
        @sensitive_query_parameter = sensitive_query_parameter
        @tls_configurator = tls_configurator
      end

      class Socket
        # @api private
        def initialize(connection, url:, error_factory:)
          @connection = connection
          @url = url
          @error_factory = error_factory
          @aborted = false
        end

        def read
          @connection.read
        rescue StandardError => e
          raise @error_factory.call(url: @url, cause: e)
        end

        def write(message)
          @connection.write(message)
          @connection.flush
        rescue StandardError => e
          raise @error_factory.call(url: @url, cause: e)
        end

        def close(code: 1000, reason: "")
          @connection.close(code, reason)
        rescue StandardError => e
          raise @error_factory.call(url: @url, cause: e)
        end

        # @api private
        def abort
          framer = @connection.framer
          framer.extend(AbortableFramer)
          framer.abort
          @aborted = true
        rescue StandardError => e
          raise @error_factory.call(url: @url, cause: e)
        end

        # @api private
        def aborted? = @aborted

        def closed? = @aborted || @connection.closed?
      end

      def open(url:, headers:, timeout:, **endpoint_options)
        load_dependencies(url)

        # Proxy credentials belong only on the CONNECT request assembled from
        # proxy configuration. Never forward a caller-supplied value to the
        # origin handshake.
        headers = headers.reject do |name, _value|
          name.to_s.casecmp?("proxy-authorization")
        end

        # Classic WebSocket negotiation uses HTTP/1.1. Pinning ALPN also avoids an
        # HTTP/2 selection on servers that advertise both protocols.
        options = {
          alpn_protocols: ::Async::HTTP::Protocol::HTTP11.names,
          **endpoint_options
        }
        if url.scheme == "wss" || @tls_configurator
          options[:ssl_context] = build_tls_context(url)
        end

        sideband = sensitive_query?(url)
        endpoint_url = url.dup
        endpoint_url.query = nil if sideband

        endpoint = ::Async::HTTP::Endpoint.parse(
          endpoint_url.to_s,
          **options
        )
        request_target = endpoint.path
        request_target = "#{request_target}?#{url.query}" if sideband
        proxy_client = nil
        if (proxy = proxy_uri(url))
          proxy_endpoint = ::Async::HTTP::Endpoint.parse(proxy_url(proxy).to_s)
          proxy_client = ::Async::HTTP::Client.open(proxy_endpoint)
          tunnel = ::Async::HTTP::Proxy.new(
            proxy_client,
            authority(url, include_default_port: true),
            trace_safe_headers(proxy_headers(proxy))
          )
          endpoint = tunnel.wrap_endpoint(endpoint)
        end

        block_error = nil
        # Keep the request timeout scoped to WebSocket negotiation. Endpoint timeouts
        # remain installed on the socket and would otherwise terminate healthy idle
        # sessions after the ordinary HTTP request timeout.
        ::Kernel.Sync() do
          client_options = if sideband
            {
              protocol: TraceSafeProtocol.new(
                endpoint.protocol,
                sensitive_query_parameter: @sensitive_query_parameter
              )
            }
          else
            {}
          end

          client = ::Async::WebSocket::Client.open(endpoint, **client_options)
          connection = nil
          socket = nil
          begin
            connection = negotiate(
              client,
              endpoint,
              request_target: request_target,
              headers: headers,
              timeout: timeout
            )
            socket = build_socket(connection, url: url)
            begin
              yield(socket)
            rescue StandardError => e
              block_error = e
              raise
            end

          ensure
            close_resources(
              connection,
              client,
              proxy_client,
              connection_aborted: socket&.aborted?,
              pending_error: $ERROR_INFO
            )
          end
        end

      rescue StandardError => e
        raise if @error_class === e
        raise if e.equal?(block_error)

        raise @error_factory.call(url: url, cause: e, http_status: handshake_status(e))
      end

      private def negotiate(client, endpoint, request_target:, headers:, timeout:)
        safe_headers = trace_safe_headers(headers)
        operation = lambda do
          client.connect(authority(endpoint.url), request_target, headers: safe_headers)
        end

        return operation.call if timeout.nil?

        ::Async::Task.current.with_timeout(timeout, &operation)
      end

      private def build_socket(connection, url:)
        Socket.new(connection, url: url, error_factory: @error_factory)
      end

      private def sensitive_query?(url)
        return false unless @sensitive_query_parameter && url.query

        URI.decode_www_form(url.query).any? { |name, _value| name == @sensitive_query_parameter }
      end

      private def build_tls_context(url)
        unless url.scheme == "wss"
          raise ArgumentError, "TLS configuration requires a wss:// #{@product_name} endpoint"
        end

        context = OpenSSL::SSL::SSLContext.new
        @tls_configurator&.call(context)
        if context.verify_callback
          raise ArgumentError, "#{@product_name} WebSocket TLS configuration cannot set verify_callback"
        end

        context.set_params(verify_mode: OpenSSL::SSL::VERIFY_PEER)
        context.verify_hostname = true
        context.alpn_protocols = ::Async::HTTP::Protocol::HTTP11.names
        context
      end

      private def close_resources(connection, client, proxy_client, connection_aborted:, pending_error:)
        cleanup_error = nil
        resources = [client, proxy_client]
        resources.unshift(connection) unless connection_aborted
        resources.compact.each do |resource|
          resource.close
        rescue StandardError => e
          cleanup_error ||= e
        end

        raise cleanup_error if pending_error.nil? && cleanup_error
      end

      private def load_dependencies(url)
        require("async/websocket/client")
        require("async/http/endpoint")
        require("async/http/proxy")

      rescue LoadError => e
        message = @dependency_message ||
          "#{@product_name} WebSockets require the `async-websocket` gem. " \
            "Add `gem \"async-websocket\"` to your Gemfile."
        raise @error_factory.call(url: url, message: message, cause: e)
      end

      private def authority(url, include_default_port: false)
        host = url.hostname
        host = "[#{host}]" if host.include?(":")
        default_port = %w[https wss].include?(url.scheme) ? 443 : 80
        return host if !include_default_port && url.port == default_port

        "#{host}:#{url.port}"
      end

      private def proxy_uri(url)
        policy_url = url.dup
        policy_url.scheme = {"ws" => "http", "wss" => "https"}.fetch(url.scheme, url.scheme)
        policy_url.find_proxy
      end

      private def proxy_url(proxy)
        unless %w[http https].include?(proxy.scheme) && proxy.hostname
          raise ArgumentError, "#{@product_name} WebSocket proxy must be an absolute HTTP or HTTPS URL"
        end

        proxy.dup.tap do |url|
          url.user = nil
          url.password = nil
        end
      end

      private def proxy_headers(proxy)
        return {} unless proxy.user

        user = URI::RFC2396_PARSER.unescape(proxy.user)
        password = URI::RFC2396_PARSER.unescape(proxy.password.to_s)
        {"proxy-authorization" => "Basic #{["#{user}:#{password}"].pack("m0")}"}
      end

      private def trace_safe_headers(headers)
        fields = ::Protocol::HTTP::Headers[headers].to_a
        trace_safe_headers_class.new(fields)
      end

      private def trace_safe_headers_class
        @trace_safe_headers_class ||= Class.new(::Protocol::HTTP::Headers) do
          include(TraceSafeHeaders)
        end
      end

      private def handshake_status(error)
        return unless error.is_a?(::Async::WebSocket::ConnectionError)

        error.response.status
      end
    end
  end
end

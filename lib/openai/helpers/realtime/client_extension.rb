# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Realtime request integration kept outside the generated client implementation.
      module ClientExtension
        include OpenAI::WebSocket::ClientRequest

        MAX_CALL_CLEANUP_SECONDS = 5.0
        private_constant :MAX_CALL_CLEANUP_SECONDS

        # A generated WebRTC allocation belongs to the SDK until its complete raw
        # response can be returned. Keep this lifecycle outside generated resources.
        def request(req)
          unless req.is_a?(Hash) &&
              req[:method] == :post &&
              req[:path] == "realtime/calls" &&
              req[:model] == OpenAI::HTTPClient::Response
            return super
          end

          delivered = false
          allocated_response = nil
          call_id = nil
          begin
            url, response, log_context = perform_request(req) do |received_response, request_url, response_url|
              if received_response.status == 201
                allocated_response = received_response
                if response_url.path == request_url.path &&
                    realtime_call_origin(response_url).casecmp?(realtime_call_origin(request_url))
                  call_id = realtime_call_id_from_location(
                    received_response.headers["location"],
                    request_url: request_url
                  )
                end
              end
            end

            result = finish_request(log_context, response) do
              parse_response(req, url: url, response: response)
            end

            delivered = true
            result
          ensure
            unless delivered
              begin
                OpenAI::Internal::Util.close_fused!(allocated_response.body) if allocated_response
              rescue StandardError, *(defined?(::Async::Stop) ? [::Async::Stop] : [])
                nil
              ensure
                cleanup_created_realtime_call(call_id, options: req[:options]) if call_id
              end
            end
          end
        end

        private def realtime_call_id_from_location(location, request_url:)
          return if location.nil? || location.empty?

          call_url = URI.join(request_url.to_s, location)
          unless call_url.is_a?(URI::HTTP) &&
              !call_url.host.to_s.empty? &&
              call_url.userinfo.nil? &&
              call_url.fragment.nil?
            return
          end

          return unless realtime_call_origin(request_url).casecmp?(realtime_call_origin(call_url))

          prefix = "#{request_url.path}/"
          return unless call_url.path.start_with?(prefix)

          call_id = call_url.path.delete_prefix(prefix)
          call_id if /\A[A-Za-z0-9_-]+\z/.match?(call_id)
        rescue URI::InvalidURIError, ArgumentError
          nil
        end

        private def realtime_call_origin(url)
          origin = OpenAI::Internal::Util.uri_origin(url)
          if url.host.start_with?("[") && !url.hostname.start_with?("v", "V")
            origin = origin.sub(url.host, "[#{IPAddr.new(url.hostname)}]")
          end

          origin
        end

        private def cleanup_created_realtime_call(call_id, options:)
          cleanup_options = options.to_h.slice(:extra_headers, :extra_query, :timeout)
          timeout = cleanup_options.fetch(:timeout, @timeout)
          timeout = MAX_CALL_CLEANUP_SECONDS unless timeout&.positive?
          cleanup_options[:timeout] = [timeout, MAX_CALL_CLEANUP_SECONDS].min
          cleanup_options[:max_retries] = 0
          task = ::Async::Task.current? if defined?(::Async::Task)
          cleanup = lambda do
            Timeout.timeout(cleanup_options.fetch(:timeout)) do
              realtime.calls.hangup(call_id, request_options: cleanup_options)
            end
          end

          if task
            if task.respond_to?(:defer_cancel)
              task.defer_cancel(&cleanup)
            else
              task.defer_stop(&cleanup)
            end
          else
            cleanup.call
          end

        rescue StandardError, *(defined?(::Async::Stop) ? [::Async::Stop] : [])
          nil
        end

        # Build a fully authenticated Realtime WebSocket handshake request. Realtime
        # transports use this boundary so provider authentication and request options stay
        # consistent with ordinary SDK requests.
        #
        # @api private
        #
        # @param path [String]
        # @param query [Hash{String=>String}]
        # @param options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [Hash{Symbol=>Object}]
        def realtime_connection_request(path:, query:, websocket_base_url: nil, options: nil)
          request, = build_realtime_connection_request(
            path: path,
            query: query,
            websocket_base_url: websocket_base_url,
            options: options
          )
          request
        end

        # Yield an authenticated WebSocket request, refreshing a rejected workload
        # identity token exactly once after a definitive upgrade 401.
        # The caller marks the handshake complete as soon as the transport yields
        # a socket, before running application code; only pre-yield failures may retry.
        #
        # @api private
        def with_realtime_connection_request(path:, query:, websocket_base_url: nil, options: nil)
          build = lambda do |deadline|
            build_realtime_connection_request(
              path: path,
              query: query,
              websocket_base_url: websocket_base_url,
              options: options,
              deadline: deadline
            )
          end

          with_websocket_connection_retry(
            error_class: OpenAI::Errors::RealtimeConnectionError,
            build: build
          ) { |request, marker| yield(request, marker) }
        end

        private def build_realtime_connection_request(
          path:,
          query:,
          websocket_base_url:,
          options:,
          deadline: nil
        )
          build_shared_websocket_connection_request(
            path: path,
            query: query,
            websocket_base_url: websocket_base_url,
            options: options,
            deadline: deadline,
            validate: -> (value) { validate_realtime_websocket_request!(value) },
            invalid_base_url_message: "`websocket_base_url` must be an absolute HTTP or WebSocket URL " \
              "without credentials, query, or fragment",
            malformed_base_url_message: "`websocket_base_url` is not a valid URL",
            preserve_base_url_cause: true,
            extra_query_message: "`request_options[:extra_query]` is not supported for Realtime WebSocket " \
              "connections; omit it",
            max_retries_message: "`request_options[:max_retries]` is not supported for Realtime WebSocket " \
              "connections; use 0 or omit it",
            timeout_error: lambda do |url, cause|
              OpenAI::Errors::RealtimeConnectionError.new(url: url, cause: cause)
            end
          )
        end

        private def validate_realtime_websocket_request!(websocket_base_url)
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Realtime WebSocket connections"
          end

          if @provider_runtime && @provider_runtime.name != "azure"
            message = "Realtime WebSocket connections are not supported by the " \
              "#{@provider_runtime.name} provider."
            raise OpenAI::Errors::Error, message
          end

          if websocket_base_url && @provider_runtime
            raise ArgumentError, "`websocket_base_url` cannot be combined with `provider`"
          end
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::Realtime::ClientExtension)

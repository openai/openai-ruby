# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Realtime request integration kept outside the generated client implementation.
      module ClientExtension
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
          request, deadline = build_realtime_connection_request(
            path: path,
            query: query,
            websocket_base_url: websocket_base_url,
            options: options
          )
          handshake_completed = false
          mark_handshake_completed = -> { handshake_completed = true }
          yield(request, mark_handshake_completed)
        rescue OpenAI::Errors::RealtimeConnectionError => e
          raise if handshake_completed
          raise unless e.http_status == 401 && @workload_identity_auth

          @workload_identity_auth.invalidate_token
          refreshed, = build_realtime_connection_request(
            path: path,
            query: query,
            websocket_base_url: websocket_base_url,
            options: options,
            deadline: deadline
          )
          yield(refreshed, mark_handshake_completed)
        end

        private def build_realtime_connection_request(
          path:,
          query:,
          websocket_base_url:,
          options:,
          deadline: nil
        )
          if @copy_options.fetch(:workload_identity).instance_of?(OpenAI::Auth::X509WorkloadIdentity)
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

          websocket_uri = parse_websocket_base_url(websocket_base_url)

          opts = options.to_h.dup
          OpenAI::RequestOptions.validate!(opts)
          extra_query = opts.delete(:extra_query)
          unless extra_query.nil? || (extra_query.respond_to?(:empty?) && extra_query.empty?)
            message = "`request_options[:extra_query]` is not supported for Realtime WebSocket " \
              "connections; omit it"
            raise ArgumentError, message
          end

          max_retries = opts[:max_retries]
          unless max_retries.nil? || max_retries == 0
            message = "`request_options[:max_retries]` is not supported for Realtime WebSocket " \
              "connections; use 0 or omit it"
            raise ArgumentError, message
          end

          request = build_request(
            {
              method: :get,
              path: path,
              query: query,
              security: {bearer_auth: true}
            },
            opts
          )
          error_request = if websocket_uri
            with_websocket_base_url(request, path: path, base_url: websocket_uri)
          else
            request
          end

          error_url = websocket_url(error_request.fetch(:url))

          if @workload_identity_auth
            deadline ||= request[:timeout]&.then do |timeout|
              OpenAI::Internal::Util.monotonic_secs + timeout
            end
          end

          workload_identity_header = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
          if @workload_identity_auth && request.fetch(:headers)["authorization"] == workload_identity_header
            token = @workload_identity_auth.get_token(deadline: deadline)
            request = request.merge(
              headers: request.fetch(:headers).merge("authorization" => "Bearer #{token}")
            )
          end

          request = prepare_request(request, redirect_count: 0, retry_count: 0)
          request = with_websocket_base_url(request, path: path, base_url: websocket_uri) if websocket_uri

          url = websocket_url(request.fetch(:url))
          headers = request.fetch(:headers).except("accept", "content-type").reject do |name, _value|
            name.to_s.casecmp?("proxy-authorization")
          end

          request = request.merge(url: url, headers: headers)
          request = request_with_remaining_timeout(request, deadline) unless deadline.nil?
          [request, deadline]
        rescue Timeout::Error => e
          raise(
            OpenAI::Errors::RealtimeConnectionError.new(
              url: error_url,
              cause: e
            )
          )
        end

        private def with_websocket_base_url(request, path:, base_url:)
          url = OpenAI::Internal::Util.join_parsed_uri(
            OpenAI::Internal::Util.parse_uri(base_url.to_s),
            {path: OpenAI::Internal::Util.interpolate_path(path)}
          )
          url.query = request.fetch(:url).query
          request.merge(url: url)
        end

        private def parse_websocket_base_url(value)
          return if value.nil?

          uri = URI(value.to_s)
          valid_scheme = %w[http https ws wss].include?(uri.scheme)
          ambiguous_component = uri.userinfo || uri.query || uri.fragment
          unless uri.absolute? && uri.host && valid_scheme && !ambiguous_component
            message = "`websocket_base_url` must be an absolute HTTP or WebSocket URL " \
              "without credentials, query, or fragment"
            raise ArgumentError, message
          end

          uri
        rescue URI::Error => e
          raise ArgumentError, "`websocket_base_url` is not a valid URL", cause: e
        end

        private def websocket_url(url)
          url = url.dup
          url.scheme = {"http" => "ws", "https" => "wss"}.fetch(url.scheme, url.scheme)
          url
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::Realtime::ClientExtension)

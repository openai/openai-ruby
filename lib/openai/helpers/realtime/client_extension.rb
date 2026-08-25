# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Realtime request integration kept outside the generated client implementation.
      module ClientExtension
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

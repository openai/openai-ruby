# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared handshake request helpers used by product WebSocket facades.
    #
    # @api private
    module ClientRequest
      private def with_websocket_connection_retry(error_class:, build:)
        request, deadline = build.call(nil)
        handshake_completed = false
        mark_handshake_completed = -> { handshake_completed = true }
        yield(request, mark_handshake_completed)
      rescue error_class => e
        raise if handshake_completed
        raise unless e.http_status == 401 && @workload_identity_auth

        @workload_identity_auth.invalidate_token
        refreshed, = build.call(deadline)
        yield(refreshed, mark_handshake_completed)
      end

      private def shared_websocket_request_options(options, extra_query_message:, max_retries_message:)
        opts = options.to_h.dup
        OpenAI::RequestOptions.validate!(opts)
        extra_query = opts.delete(:extra_query)
        unless extra_query.nil? || (extra_query.respond_to?(:empty?) && extra_query.empty?)
          raise ArgumentError, extra_query_message
        end

        max_retries = opts[:max_retries]
        raise ArgumentError, max_retries_message unless max_retries.nil? || max_retries == 0

        opts
      end

      private def parse_shared_websocket_base_url(value, invalid_message:, malformed_message:, preserve_cause:)
        return if value.nil?

        uri = URI(value.to_s)
        valid_scheme = %w[http https ws wss].include?(uri.scheme)
        ambiguous = uri.userinfo || uri.query || uri.fragment
        raise ArgumentError, invalid_message unless uri.absolute? && uri.host && valid_scheme && !ambiguous

        uri
      rescue URI::Error => e
        raise ArgumentError, malformed_message, cause: preserve_cause ? e : nil
      end

      private def shared_websocket_url(url)
        url = url.dup
        url.scheme = {"http" => "ws", "https" => "wss"}.fetch(url.scheme, url.scheme)
        url
      end

      private def shared_websocket_headers(headers)
        headers.except("accept", "content-type").reject do |name, _value|
          name.to_s.casecmp?("proxy-authorization")
        end
      end

      private def build_shared_websocket_connection_request(
        path:,
        query:,
        websocket_base_url:,
        options:,
        deadline: nil,
        validate:,
        invalid_base_url_message:,
        malformed_base_url_message:,
        preserve_base_url_cause:,
        extra_query_message:,
        max_retries_message:,
        timeout_error:
      )
        validate.call(websocket_base_url)
        websocket_uri = parse_shared_websocket_base_url(
          websocket_base_url,
          invalid_message: invalid_base_url_message,
          malformed_message: malformed_base_url_message,
          preserve_cause: preserve_base_url_cause
        )
        opts = shared_websocket_request_options(
          options,
          extra_query_message: extra_query_message,
          max_retries_message: max_retries_message
        )

        request = build_request(
          {method: :get, path: path, query: query, security: {bearer_auth: true}},
          opts
        )
        error_request = websocket_uri ? with_shared_websocket_base_url(request, path:, base_url: websocket_uri) : request
        error_url = shared_websocket_url(error_request.fetch(:url))

        if @workload_identity_auth
          deadline ||= request[:timeout]&.then do |timeout|
            OpenAI::Internal::Util.monotonic_secs + timeout
          end
        end

        placeholder = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
        if @workload_identity_auth && request.fetch(:headers)["authorization"] == placeholder
          token = @workload_identity_auth.get_token(deadline: deadline)
          request = request.merge(headers: request.fetch(:headers).merge("authorization" => "Bearer #{token}"))
        end

        request = prepare_request(request, redirect_count: 0, retry_count: 0)
        request = with_shared_websocket_base_url(request, path:, base_url: websocket_uri) if websocket_uri
        request = request.merge(
          url: shared_websocket_url(request.fetch(:url)),
          headers: shared_websocket_headers(request.fetch(:headers))
        )
        request = request_with_remaining_timeout(request, deadline) unless deadline.nil?
        [request, deadline]
      rescue Timeout::Error => e
        error = timeout_error.call(error_url, e)
        raise error, cause: error.cause
      end

      private def with_shared_websocket_base_url(request, path:, base_url:)
        url = OpenAI::Internal::Util.join_parsed_uri(
          OpenAI::Internal::Util.parse_uri(base_url.to_s),
          {path: OpenAI::Internal::Util.interpolate_path(path)}
        )
        url.query = request.fetch(:url).query
        request.merge(url: url)
      end
    end
  end
end

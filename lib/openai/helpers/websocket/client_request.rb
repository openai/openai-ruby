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
    end
  end
end

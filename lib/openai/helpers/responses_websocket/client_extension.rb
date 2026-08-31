# frozen_string_literal: true

module OpenAI
  module Helpers
    module ResponsesWebSocket
      # Responses WebSocket request integration kept outside generated client code.
      module ClientExtension
        # @api private
        def with_responses_websocket_connection_request(websocket_base_url: nil, options: nil)
          request, deadline = build_responses_websocket_connection_request(
            websocket_base_url: websocket_base_url,
            options: options
          )
          handshake_completed = false
          mark_handshake_completed = -> { handshake_completed = true }
          yield(request, mark_handshake_completed)
        rescue OpenAI::Errors::ResponsesConnectionError => e
          raise if handshake_completed
          raise unless e.http_status == 401 && @workload_identity_auth

          @workload_identity_auth.invalidate_token
          refreshed, = build_responses_websocket_connection_request(
            websocket_base_url: websocket_base_url,
            options: options,
            deadline: deadline
          )
          yield(refreshed, mark_handshake_completed)
        end

        private def build_responses_websocket_connection_request(
          websocket_base_url:,
          options:,
          deadline: nil
        )
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Responses WebSocket connections"
          end

          if @provider_runtime
            raise OpenAI::Errors::Error, "Responses WebSocket connections are not supported by providers."
          end

          websocket_uri = parse_responses_websocket_base_url(websocket_base_url)
          opts = options.to_h.dup
          OpenAI::RequestOptions.validate!(opts)
          extra_query = opts.delete(:extra_query)
          unless extra_query.nil? || (extra_query.respond_to?(:empty?) && extra_query.empty?)
            raise ArgumentError, "request_options extra_query is not supported for Responses WebSocket connections"
          end

          max_retries = opts[:max_retries]
          unless max_retries.nil? || max_retries == 0
            raise ArgumentError, "request_options max_retries is not supported for Responses WebSocket connections"
          end

          request = build_request(
            {method: :get, path: "responses", query: {}, security: {bearer_auth: true}},
            opts
          )
          error_request = websocket_uri ? with_responses_websocket_base_url(request, websocket_uri) : request
          error_url = responses_websocket_url(error_request.fetch(:url))
          if @workload_identity_auth
            deadline ||= request[:timeout]&.then { |timeout| OpenAI::Internal::Util.monotonic_secs + timeout }
          end

          placeholder = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
          if @workload_identity_auth && request.fetch(:headers)["authorization"] == placeholder
            token = @workload_identity_auth.get_token(deadline: deadline)
            request = request.merge(headers: request.fetch(:headers).merge("authorization" => "Bearer #{token}"))
          end

          request = prepare_request(request, redirect_count: 0, retry_count: 0)
          request = with_responses_websocket_base_url(request, websocket_uri) if websocket_uri
          url = responses_websocket_url(request.fetch(:url))
          headers = request.fetch(:headers).except("accept", "content-type").reject do |name, _value|
            name.to_s.casecmp?("proxy-authorization")
          end

          request = request.merge(url: url, headers: headers)
          request = request_with_remaining_timeout(request, deadline) unless deadline.nil?
          [request, deadline]
        rescue Timeout::Error
          raise OpenAI::Errors::ResponsesConnectionError.new(url: error_url), cause: nil
        end

        private def with_responses_websocket_base_url(request, base_url)
          url = OpenAI::Internal::Util.join_parsed_uri(
            OpenAI::Internal::Util.parse_uri(base_url.to_s),
            {path: OpenAI::Internal::Util.interpolate_path("responses")}
          )
          request.merge(url: url)
        end

        private def parse_responses_websocket_base_url(value)
          return if value.nil?

          uri = URI(value.to_s)
          valid_scheme = %w[http https ws wss].include?(uri.scheme)
          ambiguous = uri.userinfo || uri.query || uri.fragment
          unless uri.absolute? && uri.host && valid_scheme && !ambiguous
            raise(
              ArgumentError,
              "websocket_base_url must be an absolute HTTP or WebSocket URL without credentials, query, or fragment"
            )
          end

          uri
        rescue URI::Error
          raise ArgumentError, "websocket_base_url is not a valid URL", cause: nil
        end

        private def responses_websocket_url(url)
          url = url.dup
          url.scheme = {"http" => "ws", "https" => "wss"}.fetch(url.scheme, url.scheme)
          url
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::ResponsesWebSocket::ClientExtension)

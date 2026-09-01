# frozen_string_literal: true

module OpenAI
  module Helpers
    module ResponsesWebSocket
      # Responses WebSocket request integration kept outside generated client code.
      module ClientExtension
        include OpenAI::WebSocket::ClientRequest

        # @api private
        def with_responses_websocket_connection_request(websocket_base_url: nil, options: nil)
          build = lambda do |deadline|
            build_responses_websocket_connection_request(
              websocket_base_url: websocket_base_url,
              options: options,
              deadline: deadline
            )
          end

          with_websocket_connection_retry(
            error_class: OpenAI::Errors::ResponsesConnectionError,
            build: build
          ) { |request, marker| yield(request, marker) }
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
          opts = shared_websocket_request_options(
            options,
            extra_query_message: "request_options extra_query is not supported for Responses WebSocket connections",
            max_retries_message: "request_options max_retries is not supported for Responses WebSocket connections"
          )

          request = build_request(
            {method: :get, path: "responses", query: {}, security: {bearer_auth: true}},
            opts
          )
          error_request = websocket_uri ? with_responses_websocket_base_url(request, websocket_uri) : request
          error_url = shared_websocket_url(error_request.fetch(:url))
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
          url = shared_websocket_url(request.fetch(:url))
          headers = shared_websocket_headers(request.fetch(:headers))

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

          parse_shared_websocket_base_url(
            value,
            invalid_message: "websocket_base_url must be an absolute HTTP or WebSocket URL without credentials, query, or fragment",
            malformed_message: "websocket_base_url is not a valid URL",
            preserve_cause: false
          )
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::ResponsesWebSocket::ClientExtension)

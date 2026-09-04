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
          build_shared_websocket_connection_request(
            path: "responses",
            query: {},
            websocket_base_url: websocket_base_url,
            options: options,
            deadline: deadline,
            validate: -> (_value) { validate_responses_websocket_request! },
            invalid_base_url_message: "websocket_base_url must be an absolute HTTP or WebSocket URL " \
              "without credentials, query, or fragment",
            malformed_base_url_message: "websocket_base_url is not a valid URL",
            preserve_base_url_cause: false,
            extra_query_message: "request_options extra_query is not supported for Responses WebSocket connections",
            max_retries_message: "request_options max_retries is not supported for Responses WebSocket connections",
            timeout_error: -> (url, _cause) { OpenAI::Errors::ResponsesConnectionError.new(url: url) }
          )
        end

        private def validate_responses_websocket_request!
          if x509_identity?(@copy_options.fetch(:workload_identity))
            raise OpenAI::Errors::Error, "X.509 workload identity does not support Responses WebSocket connections"
          end

          if @provider_runtime
            raise OpenAI::Errors::Error, "Responses WebSocket connections are not supported by providers."
          end
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::ResponsesWebSocket::ClientExtension)

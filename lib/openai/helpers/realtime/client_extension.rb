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
        def realtime_connection_request(path:, query:, options: nil)
          if @provider_runtime && @provider_runtime.name != "azure"
            message =
              "Realtime WebSocket connections are not supported by the " \
              "#{@provider_runtime.name} provider."
            raise OpenAI::Errors::Error, message
          end

          opts = options.to_h
          OpenAI::RequestOptions.validate!(opts)
          request = build_request(
            {
              method: :get,
              path: path,
              query: query,
              security: {bearer_auth: true}
            },
            opts
          )

          workload_identity_header = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
          if @workload_identity_auth && request.fetch(:headers)["authorization"] == workload_identity_header
            token = @workload_identity_auth.get_token
            request = request.merge(
              headers: request.fetch(:headers).merge("authorization" => "Bearer #{token}")
            )
          end

          request = prepare_request(request, redirect_count: 0, retry_count: 0)
          request = with_websocket_base_url(request, path: path) if @websocket_base_url

          url = request.fetch(:url).dup
          url.scheme = {"http" => "ws", "https" => "wss"}.fetch(url.scheme, url.scheme)
          headers = request.fetch(:headers).except("accept", "content-type")
          request.merge(url: url, headers: headers)
        end

        # Yield an authenticated WebSocket request, refreshing a rejected workload
        # identity token exactly once after a definitive upgrade 401.
        #
        # @api private
        def with_realtime_connection_request(path:, query:, options: nil)
          request = realtime_connection_request(path: path, query: query, options: options)
          yield(request)
        rescue OpenAI::Errors::RealtimeConnectionError => e
          raise unless e.http_status == 401 && @workload_identity_auth

          @workload_identity_auth.invalidate_token
          refreshed = realtime_connection_request(path: path, query: query, options: options)
          yield(refreshed)
        end

        private def with_websocket_base_url(request, path:)
          url = OpenAI::Internal::Util.join_parsed_uri(
            OpenAI::Internal::Util.parse_uri(@websocket_base_url.to_s),
            {path: OpenAI::Internal::Util.interpolate_path(path)}
          )
          url.query = request.fetch(:url).query
          request.merge(url: url)
        end
      end
    end
  end
end

OpenAI::Client.include(OpenAI::Helpers::Realtime::ClientExtension)

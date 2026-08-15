# frozen_string_literal: true

module OpenAI
  module Helpers
    module Realtime
      # Client integration kept outside the generated client implementation.
      module ClientExtension
        # Optional base URL used for WebSocket connections.
        #
        # @return [URI::Generic, nil]
        attr_reader :websocket_base_url

        def initialize(*args, websocket_base_url: nil, **kwargs, &block)
          if kwargs[:provider] && websocket_base_url
            provider_name = OpenAI::Internal::Provider.name(kwargs.fetch(:provider))
            message =
              "`provider` cannot be combined with top-level `websocket_base_url`. Move " \
              "provider authentication and routing options into `#{provider_name}(...)`."
            raise ArgumentError, message
          end

          @websocket_base_url = parse_websocket_base_url(websocket_base_url)
          super(*args, **kwargs, &block)
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

        private def with_websocket_base_url(request, path:)
          url = OpenAI::Internal::Util.join_parsed_uri(
            OpenAI::Internal::Util.parse_uri(@websocket_base_url.to_s),
            {path: OpenAI::Internal::Util.interpolate_path(path)}
          )
          url.query = request.fetch(:url).query
          request.merge(url: url)
        end

        private def parse_websocket_base_url(value)
          return if value.nil?

          uri = URI(value)
          valid_scheme = %w[http https ws wss].include?(uri.scheme)
          ambiguous_component = uri.userinfo || uri.query || uri.fragment
          unless uri.absolute? && uri.host && valid_scheme && !ambiguous_component
            message =
              "`websocket_base_url` must be an absolute HTTP or WebSocket URL " \
              "without credentials, query, or fragment"
            raise ArgumentError, message
          end
          uri
        rescue URI::Error => e
          raise ArgumentError, "`websocket_base_url` is not a valid URL", cause: e
        end
      end
    end
  end
end

OpenAI::Client.prepend(OpenAI::Helpers::Realtime::ClientExtension)

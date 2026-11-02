# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Owns ordinary per-attempt options and the selected target. It retains no
    # socket, application state or prepared bearer token between attempts.
    #
    # @api private
    class RecoveryRequest
      SELECTORS = %w[model deployment deployment_id intent call_id session_id graceful_close api-version api_version]
        .freeze
      CREDENTIAL_QUERY = %w[api_key api-key access_token token client_secret authorization organization project].freeze
      PROTECTED_HEADERS = %w[
        authorization
        api-key
        cookie
        openai-organization
        openai-project
        host
        origin
        openai-beta
        upgrade
        connection
        sec-websocket-key
        sec-websocket-version
        sec-websocket-protocol
        sec-websocket-extensions
        proxy-authorization
      ]
        .freeze
      private_constant :SELECTORS, :CREDENTIAL_QUERY, :PROTECTED_HEADERS

      attr_reader :query, :options

      def initialize(query:, options:)
        @initial_query = own(query.to_h.transform_keys(&:to_s))
        @initial_options = own(options.to_h)
        @query = @initial_query
        @options = @initial_options
      end

      def update(decision)
        decision = {} if decision.nil?
        raise ArgumentError, "Recovery options must be a Hash, nil, or false." unless decision.is_a?(Hash)
        unless (decision.keys - [:headers, :query, :open_new_fork_transport]).empty?
          raise ArgumentError, "Unknown recovery option."
        end

        query = decision.fetch(:query, @initial_query).to_h.transform_keys(&:to_s)
        if decision.key?(:query) && query.keys.any? { (SELECTORS + CREDENTIAL_QUERY).include?(_1.downcase) }
          raise ArgumentError, "Recovery query cannot change target selectors or credentials."
        end

        selected = @initial_query.select { |key,| SELECTORS.include?(key.downcase) }
        @query = own(selected.merge(query))
        headers = decision.fetch(:headers, {}).to_h
        if headers.keys.any? { PROTECTED_HEADERS.include?(_1.to_s.downcase) }
          raise ArgumentError, "Recovery headers cannot change credential or handshake policy."
        end

        @options = own(
          @initial_options.merge(extra_headers: @initial_options.fetch(:extra_headers, {}).to_h.merge(headers))
        )
        nil
      end

      def capture(request)
        @target ||= target(request.fetch(:url))
        @selected_headers ||= policy_headers(request.fetch(:headers))
        nil
      end

      def prepare(request)
        # Own values before validating them: middleware may retain its input.
        url = URI(request.fetch(:url).to_s)
        headers = request
          .fetch(:headers)
          .to_h do |key, value|
            [key.to_s.dup.freeze, value.to_s.dup.freeze]
          end
          .freeze
        unless target(url) == @target && policy_headers(headers) == @selected_headers
          raise ArgumentError, "Recovery cannot change the selected WebSocket target or header policy."
        end

        credential_headers = headers.transform_keys(&:downcase)
        credential_policy = [
          credential_headers.keys.grep(/\A(?:authorization|api-key|cookie)\z/).sort,
          credential_headers["authorization"]&.split(" ", 2)&.first&.downcase
        ]
        @credential_policy ||= credential_policy
        unless credential_policy == @credential_policy
          raise ArgumentError, "Recovery cannot change the selected WebSocket credential policy."
        end

        request.merge(url: url, headers: headers)
      end

      private def target(value)
        url = URI(value.to_s.sub(/\Aws:/, "http:").sub(/\Awss:/, "https:"))
        if url.userinfo || url.fragment
          raise ArgumentError, "Recovery requires a WebSocket target without URL credentials or fragments."
        end

        [
          OpenAI::Internal::Util.uri_origin(url).downcase,
          url.path,
          URI
            .decode_www_form(url.query.to_s)
            .select { |key,| (SELECTORS + CREDENTIAL_QUERY).include?(key.downcase) }
            .sort
        ]
      end

      private def policy_headers(headers)
        headers
          .to_h
          .filter_map do |key, value|
            name = key.to_s.downcase
            [name, value.to_s.dup.freeze] if (PROTECTED_HEADERS - ["authorization", "api-key", "cookie"]).include?(name)
          end
          .sort
          .freeze
      end

      private def own(value)
        case value
        when Hash
          value.to_h { |key, item| [own(key), own(item)] }.freeze
        when Array
          value.map { own(_1) }.freeze
        when String
          value.dup.freeze
        else
          value
        end
      end
    end
  end
end

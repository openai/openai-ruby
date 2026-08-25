# frozen_string_literal: true

module OpenAI
  module Auth
    # A caller-attested, application-owned transport for X.509 authentication.
    #
    # The caller attests that its native client consistently selects one static
    # certificate identity and the declared proxy configuration. This attestation
    # cannot cryptographically bind a bearer token to a client certificate.
    # Certificate rotation requires a new native client and transport capability.
    #
    # @api public
    class X509Transport
      ISSUER_ORIGIN = "https://mtls.auth.openai.com"
      ISSUER_PATH = "/oauth/token"
      API_HOSTS = %w[mtls.api.openai.com mtls-us.api.openai.com mtls-eu.api.openai.com].freeze
      PROXY_MODES = [:direct, :http_connect].freeze
      FORBIDDEN_HEADERS = %w[api-key x-api-key proxy-authorization content-length transfer-encoding].freeze
      EXCHANGE_FORBIDDEN_HEADERS = %w[authorization cookie openai-organization openai-project].freeze
      HEADER_NAME_PATTERN = /\A[!#$%&'*+.^_`|~0-9A-Za-z-]+\z/
      BEARER_PATTERN = /\ABearer [A-Za-z0-9\-._~+\/]+=*\z/
      GuardedVerificationCallback = Class.new(Proc)
      private_constant(
        :ISSUER_PATH,
        :API_HOSTS,
        :PROXY_MODES,
        :FORBIDDEN_HEADERS,
        :EXCHANGE_FORBIDDEN_HEADERS,
        :HEADER_NAME_PATTERN,
        :BEARER_PATTERN,
        :GuardedVerificationCallback
      )

      # The approved OpenAI API origin for this immutable capability.
      #
      # @return [String]
      attr_reader :api_origin

      # The proxy behavior explicitly attested by the application.
      #
      # @return [Symbol]
      attr_reader :proxy_mode

      # @param http_client [OpenAI::NetHTTPClient] caller-owned configured native transport
      # @param certificate_identity [Symbol] must explicitly be :static
      # @param proxy [Symbol] either :direct or :http_connect
      # @param api_origin [String] approved OpenAI mTLS API origin
      def initialize(
        http_client:,
        certificate_identity:,
        proxy: :direct,
        api_origin: "https://mtls.api.openai.com"
      )
        unless http_client.instance_of?(OpenAI::NetHTTPClient)
          raise ArgumentError, "X.509 transport requires a caller-owned OpenAI::NetHTTPClient"
        end

        unless certificate_identity == :static
          raise ArgumentError, "X.509 transport requires an explicitly attested static certificate identity"
        end

        unless PROXY_MODES.include?(proxy)
          raise ArgumentError, "X.509 transport supports only direct connections and HTTP CONNECT proxies"
        end

        @api_origin = normalize_api_origin(api_origin).freeze
        @proxy_mode = proxy
        @http_client = http_client
        freeze
      end

      # Sends one request through the caller's attested native transport.
      #
      # @param request [OpenAI::HTTPClient::Request]
      # @return [OpenAI::HTTPClient::Response]
      def execute(request)
        unless request.is_a?(OpenAI::HTTPClient::Request)
          raise ArgumentError, "X.509 transport requires an OpenAI::HTTPClient::Request"
        end

        url = normalize_destination(request.url)
        exchange = exchange_request?(url, request.method)
        headers = validated_headers(request.headers, url: url, exchange: exchange)
        safe_request = OpenAI::HTTPClient::Request.new(
          method: request.method,
          url: url.freeze,
          headers: headers,
          body: request.body,
          timeout: request.timeout
        )
        response = begin
          native_response = @http_client.execute(safe_request) do |connection|
            validate_tls_policy!(connection)
            validate_proxy_policy!(connection)
          end

          unless native_response.is_a?(OpenAI::HTTPClient::Response)
            raise TypeError, "`http_client#execute` must return an OpenAI::HTTPClient::Response"
          end

          reject_redirect!(native_response, url: url) if (300..399).cover?(native_response.status)
          native_response

        rescue OpenAI::Errors::APIConnectionError => error
          raise error.class.new(url: sanitized_url(url)), cause: nil
        end

        stream = Enumerator.new do |chunks|
          response.body.each { |chunk| chunks << chunk }

        rescue OpenAI::Errors::APIConnectionError => error
          raise error.class.new(url: sanitized_url(url)), cause: nil
        end

        body = OpenAI::Internal::Util.fused_enum(stream) do
          OpenAI::Internal::Util.close_fused!(response.body)

        rescue OpenAI::Errors::APIConnectionError => error
          raise error.class.new(url: sanitized_url(url)), cause: nil
        end

        OpenAI::HTTPClient::Response.new(status: response.status, headers: response.headers, body: body)
      end

      # Validates the effective API destination before a credential is acquired.
      #
      # @api private
      def validate_api_request!(url:, headers:)
        destination = normalize_destination(url)
        unless "https://#{destination.host.downcase}" == @api_origin
          raise ArgumentError, "X.509 API request must use its attested API origin"
        end

        validated_headers(headers, url: destination, exchange: false)
      end

      private def normalize_api_origin(value)
        url = URI.parse(value.to_s)
        valid = url.is_a?(URI::HTTPS) &&
          url.userinfo.nil? &&
          url.port == URI::HTTPS::DEFAULT_PORT &&
          API_HOSTS.include?(url.host&.downcase) &&
          url.path.empty? &&
          url.query.nil? &&
          url.fragment.nil?
        raise ArgumentError unless valid

        "https://#{url.host.downcase}"
      rescue ArgumentError, URI::InvalidURIError
        raise ArgumentError, "X.509 transport requires an approved OpenAI mTLS API origin"
      end

      private def normalize_destination(value)
        url = URI.parse(value.to_s)
        unless url.is_a?(URI::HTTPS) && url.userinfo.nil? && url.port == URI::HTTPS::DEFAULT_PORT
          raise ArgumentError, "X.509 transport requires an approved HTTPS destination"
        end

        origin = "https://#{url.host&.downcase}"
        unless origin == ISSUER_ORIGIN || origin == @api_origin
          raise ArgumentError, "X.509 transport rejected an unapproved destination"
        end

        url
      rescue URI::InvalidURIError
        raise ArgumentError, "X.509 transport requires an approved HTTPS destination"
      end

      private def exchange_request?(url, method)
        return false if "https://#{url.host.downcase}" == @api_origin

        unless method == :post && url.path == ISSUER_PATH && url.query.nil? && url.fragment.nil?
          raise ArgumentError, "X.509 exchange requires the exact POST issuer endpoint"
        end

        true
      end

      private def validated_headers(headers, url:, exchange:)
        normalized = {}
        comparison_keys = {}
        headers.each do |name, value|
          field = String.new(name.to_s)
          unless HEADER_NAME_PATTERN.match?(field)
            raise ArgumentError, "X.509 request header names must be valid HTTP field tokens"
          end

          field = field.downcase.freeze
          key = field.tr("_", "-")
          safe_value = String.new(value.to_s).freeze
          protected_header = key == "host" ||
            key == "authorization" ||
            FORBIDDEN_HEADERS.include?(key) ||
            EXCHANGE_FORBIDDEN_HEADERS.include?(key)
          if normalized.key?(field) || (protected_header && comparison_keys.key?(key))
            raise ArgumentError, "X.509 request contains duplicate credential headers"
          end

          if FORBIDDEN_HEADERS.include?(key) || (exchange && EXCHANGE_FORBIDDEN_HEADERS.include?(key))
            raise ArgumentError, "X.509 request contains an unsupported credential or framing header"
          end

          if key == "host" && !allowed_authority?(safe_value, url)
            raise ArgumentError, "X.509 request Host must match its approved destination"
          end

          if key == "authorization" && !BEARER_PATTERN.match?(safe_value)
            raise ArgumentError, "X.509 API authorization must contain one valid bearer token"
          end

          comparison_keys[key] = true if protected_header
          normalized[field] = safe_value
        end

        normalized.freeze
      end

      private def allowed_authority?(authority, url)
        [url.host.downcase, "#{url.host.downcase}:443"].include?(authority.to_s.downcase)
      end

      private def validate_tls_policy!(connection)
        reject_debug_output!(connection)

        if connection.verify_mode == OpenSSL::SSL::VERIFY_NONE
          raise ArgumentError, "X.509 transport requires server peer verification"
        end

        if connection.verify_hostname == false
          raise ArgumentError, "X.509 transport requires server hostname verification"
        end

        callback = connection.verify_callback
        return if callback.nil? || callback.instance_of?(GuardedVerificationCallback)

        if connection.started?
          raise ArgumentError, "X.509 transport rejects an existing unguarded TLS verification callback"
        end

        connection.verify_callback = GuardedVerificationCallback.new do |verified, context|
          result = callback.call(verified, context)
          reject_debug_output!(connection)
          result && verified
        end
      end

      private def reject_debug_output!(connection)
        # Net::HTTP supports setting unredacted wire logging but provides no public reader.
        if connection.instance_variable_get(:@debug_output)
          raise ArgumentError, "X.509 transport rejects unredacted HTTP debug output"
        end
      end

      private def validate_proxy_policy!(connection)
        if @proxy_mode == :direct
          raise ArgumentError, "X.509 direct transport rejects ambient proxies" if connection.proxy?
          return
        end

        unless connection.proxy?
          raise ArgumentError, "X.509 HTTP CONNECT transport requires an active HTTP proxy"
        end

        unsupported_proxy = connection.proxy_from_env? && connection.proxy_uri&.scheme != "http"
        proxy_tls = if connection.respond_to?(:proxy_use_ssl)
          connection.proxy_use_ssl
        elsif connection.respond_to?(:proxy_use_ssl=)
          # Supported Net::HTTP releases expose only a per-connection public writer.
          connection.instance_variable_get(:@proxy_use_ssl)
        end

        unsupported_proxy ||= proxy_tls
        if unsupported_proxy
          raise ArgumentError, "X.509 HTTP CONNECT transport rejects non-HTTP proxy schemes"
        end
      end

      private def sanitized_url(url)
        safe = url.dup
        safe.query = nil
        safe.fragment = nil
        safe
      end

      private def reject_redirect!(response, url:)
        OpenAI::Internal::Util.close_fused!(response.body)
        raise(
          OpenAI::Errors::APIError.new(
            url: sanitized_url(url),
            status: response.status,
            message: "X.509 transport does not follow redirect responses"
          )
        )
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Auth
    # Binds workload-identity authentication to an API request.
    #
    # @api private
    class WorkloadIdentityRequestPolicy
      AUTHENTICATED = :openai_workload_identity_authenticated
      HTTP_SCHEMES = %w[http https].freeze
      PROVIDER_OWNED_HOST_SUFFIXES = %w[openai.azure.com openai.azure.us openai.azure.cn].freeze
      private_constant :AUTHENTICATED, :HTTP_SCHEMES, :PROVIDER_OWNED_HOST_SUFFIXES

      # Selects the request policy once at client construction.
      #
      # @api private
      def self.build(config, base_url:)
        case config
        when nil
          nil
        when OpenAI::Auth::X509WorkloadIdentity
          X509.new(base_url)
        else
          new(base_url)
        end
      end

      # @api private
      def initialize(base_url)
        @api_origin = api_origin(parse_url(base_url))
        raise ArgumentError, invalid_base_url_message if @api_origin.nil?
        return unless provider_owned_origin?(@api_origin)

        raise ArgumentError,
              "Workload identity cannot authenticate a provider-owned API origin."
      end

      # @api private
      def decorate_request(request, **)
        request
      end

      # @api private
      def authenticated?(request)
        request[:workload_identity_auth] == AUTHENTICATED
      end

      # @api private
      def validate_before_token!(request)
        validate_api_request!(request)
      end

      # @api private
      def authorize(request, token)
        headers = request.fetch(:headers).merge("authorization" => "Bearer #{token}")
        request.merge(headers: headers, workload_identity_auth: AUTHENTICATED)
      end

      # @api private
      def validate_prepared!(request, **)
        validate_api_request!(request)
      end

      private

      def parse_url(url)
        return url if url.is_a?(URI::Generic)

        URI.parse(url.to_s)
      rescue URI::Error
        nil
      end

      def api_origin(uri)
        return nil unless uri.is_a?(URI::Generic)

        scheme = uri.scheme&.downcase
        host = uri.host&.downcase&.delete_suffix(".")
        valid =
          valid_scheme?(scheme) &&
          !host.nil? &&
          !host.empty? &&
          uri.userinfo.nil? &&
          !host.include?("%") &&
          !host.include?("\\")
        return nil unless valid

        port = uri.port || (scheme == "https" ? 443 : 80)
        [scheme, host, port].freeze
      end

      def invalid_base_url_message
        "Workload identity requires an absolute HTTP or HTTPS API base URL without userinfo."
      end

      def valid_scheme?(scheme)
        HTTP_SCHEMES.include?(scheme)
      end

      def provider_owned_origin?(origin)
        host = origin.fetch(1)
        PROVIDER_OWNED_HOST_SUFFIXES.any? do |suffix|
          host == suffix || host.end_with?(".#{suffix}")
        end
      end

      def validate_api_request!(request)
        return if api_origin(request.fetch(:url)) == @api_origin

        raise OpenAI::Errors::Error,
              "Workload identity requests must use the configured API origin."
      end

      # Enforces the X.509 bearer request trust boundary.
      #
      # @api private
      class X509 < WorkloadIdentityRequestPolicy
        REQUIRED = :openai_x509_workload_identity_required
        API_KEY_HEADERS = %w[api-key x-api-key].freeze
        PROXY_AUTHORIZATION_HEADER = "proxy-authorization"
        private_constant :REQUIRED, :API_KEY_HEADERS, :PROXY_AUTHORIZATION_HEADER

        # @api private
        def decorate_request(request, bearer_auth:, expected_authorization:)
          actual_authorization = request.fetch(:headers)["authorization"]
          if bearer_auth
            placeholder = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
            unless expected_authorization == placeholder && actual_authorization == placeholder
              raise OpenAI::Errors::Error,
                    "X.509 workload identity cannot be combined with a custom Authorization header."
            end

            return request.merge(workload_identity_auth: REQUIRED)
          end
          return request if actual_authorization == expected_authorization

          raise OpenAI::Errors::Error,
                "X.509 workload identity cannot be combined with a custom Authorization header."
        end

        # @api private
        def validate_before_token!(request)
          super

          if request[:workload_identity_auth] == REQUIRED
            expected = "Bearer #{OpenAI::Client::WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
            unless request.fetch(:headers)["authorization"] == expected
              raise OpenAI::Errors::Error,
                    "X.509 workload identity cannot be combined with a custom Authorization header."
            end
          end
        end

        # @api private
        def validate_prepared!(request, original_headers:)
          super
          return if credential_headers(request.fetch(:headers)) == credential_headers(original_headers)

          raise OpenAI::Errors::Error,
                "X.509 workload identity request hooks cannot modify credential headers."
        end

        private

        def invalid_base_url_message
          "X.509 workload identity requires an absolute HTTPS API base URL without userinfo."
        end

        def valid_scheme?(scheme)
          scheme == "https"
        end

        def validate_api_request!(request)
          super
          header_names = request.fetch(:headers).each_key.map { _1.to_s.downcase.tr("_", "-") }
          if header_names.intersect?(API_KEY_HEADERS)
            raise OpenAI::Errors::Error,
                  "X.509 workload identity cannot be combined with a custom API-key header."
          end
          if header_names.include?(PROXY_AUTHORIZATION_HEADER)
            raise OpenAI::Errors::Error,
                  "X.509 workload identity requires Proxy-Authorization to be configured by the transport."
          end
          return unless header_names.include?("host")

          raise OpenAI::Errors::Error,
                "X.509 workload identity requests cannot override the Host header."
        end

        def credential_headers(headers)
          headers.each_with_object({}) do |(name, value), selected|
            next unless OpenAI::Internal::Logging.credential_header?(name)

            normalized_name = name.to_s.downcase
            selected[normalized_name] ||= []
            selected.fetch(normalized_name) << value.to_s
          end.transform_values { _1.sort.freeze }.freeze
        end
      end
    end
  end
end

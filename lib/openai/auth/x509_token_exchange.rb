# frozen_string_literal: true

module OpenAI
  module Auth
    # Performs the fixed certificate-authenticated OpenAI token exchange.
    #
    # @api private
    class X509TokenExchange
      MAX_TOKEN_LIFETIME = 3600
      TOKEN_URL = "#{X509Transport::ISSUER_ORIGIN}/oauth/token".freeze
      GRANT_TYPE = "urn:ietf:params:oauth:grant-type:token-exchange"
      SUBJECT_TOKEN_TYPE = "urn:openai:params:oauth:token-type:x509"
      ISSUED_TOKEN_TYPE = "urn:ietf:params:oauth:token-type:access_token"
      BEARER_PATTERN = /\A[A-Za-z0-9\-._~+\/]+=*\z/
      OAUTH_ERROR_CODES = %w[invalid_grant invalid_subject_token token_exchange_server_error].freeze
      private_constant(
        :MAX_TOKEN_LIFETIME,
        :TOKEN_URL,
        :GRANT_TYPE,
        :SUBJECT_TOKEN_TYPE,
        :ISSUED_TOKEN_TYPE,
        :BEARER_PATTERN,
        :OAUTH_ERROR_CODES
      )

      def initialize(config, transport:)
        unless X509Transport.exact_instance?(config, X509WorkloadIdentity)
          raise ArgumentError, "X.509 exchange requires an X509WorkloadIdentity"
        end

        unless X509Transport.exact_instance?(transport, X509Transport)
          raise ArgumentError, "X.509 exchange requires an attested X509Transport"
        end

        @config = config
        @transport = transport
      end

      # Avoid exposing nested workload identity configuration in diagnostics.
      #
      # @return [String]
      def inspect
        "#<#{self.class.name}:0x#{object_id.to_s(16)}>"
      end

      # @api private
      def bound_to?(identity, transport:)
        @config.equal?(identity) && @transport.equal?(transport)
      end

      # @param deadline [Float, nil] absolute monotonic request deadline
      # @return [Hash{Symbol=>String, Float}]
      def fetch(deadline: nil)
        request = OpenAI::HTTPClient::Request.new(
          method: :post,
          url: URI(TOKEN_URL),
          headers: {"accept" => "application/json", "content-type" => "application/json"},
          body: JSON.generate(
            grant_type: GRANT_TYPE,
            subject_token_type: SUBJECT_TOKEN_TYPE,
            identity_provider_id: @config.identity_provider_id,
            service_account_id: @config.service_account_id
          ),
          timeout: remaining_timeout(deadline)
        )
        response = @transport.execute(request)
        successful = (200..299).cover?(response.status)
        body = parse_response(response, deadline: deadline, strict: successful)
        if successful
          token = validate_token_response(body, response: response)
          remaining_timeout(deadline)
          return token
        end

        raise_error(response, body)
      rescue OpenAI::Errors::APIConnectionError => error
        raise error.class.new(url: URI(TOKEN_URL)), cause: nil
      end

      private def remaining_timeout(deadline)
        return if deadline.nil?

        remaining = deadline - OpenAI::Internal::Util.monotonic_secs
        unless remaining.positive?
          raise Timeout::Error, "request timed out during workload identity authentication"
        end

        remaining
      end

      private def parse_response(response, deadline:, strict:)
        body = +""
        response.body.each do |chunk|
          remaining_timeout(deadline)
          body << chunk
        end

        remaining_timeout(deadline)
        unless body.force_encoding(Encoding::UTF_8).valid_encoding?
          return nil unless strict

          raise invalid_response("response must use valid UTF-8", response: response)
        end

        parsed = JSON.parse(body, symbolize_names: true)
        remaining_timeout(deadline)
        parsed
      rescue JSON::ParserError
        return nil unless strict

        raise invalid_response("response must be a complete JSON object", response: response), cause: nil
      ensure
        OpenAI::Internal::Util.close_fused!(response.body)
      end

      private def validate_token_response(body, response:)
        unless body.is_a?(Hash)
          raise invalid_response("response must be a JSON object", response: response)
        end

        token = body[:access_token]
        unless token.is_a?(String) && token.valid_encoding? && BEARER_PATTERN.match?(token)
          raise invalid_response("access_token must use the bearer token grammar", response: response)
        end

        token_type = body[:token_type]
        unless token_type.is_a?(String) && token_type.valid_encoding? && token_type.casecmp?("Bearer")
          raise invalid_response("token_type must be Bearer", response: response)
        end

        unless body[:issued_token_type] == ISSUED_TOKEN_TYPE
          raise invalid_response("issued_token_type must identify an access token", response: response)
        end

        expires_in = body[:expires_in]
        unless expires_in.is_a?(Integer) || expires_in.is_a?(Float)
          raise invalid_response("expires_in must be a finite positive number", response: response)
        end

        valid_lifetime = expires_in.positive? && expires_in <= MAX_TOKEN_LIFETIME
        valid_lifetime &&= expires_in.finite? if expires_in.is_a?(Float)
        unless valid_lifetime
          raise invalid_response("expires_in must be greater than zero and at most one hour", response: response)
        end

        {id: token, expires_in: expires_in.to_f}
      end

      private def raise_error(response, body)
        headers = response.headers.slice("x-request-id")
        if [400, 401, 403].include?(response.status)
          error_code = body.is_a?(Hash) ? body[:error] : nil
          error_code = error_code[:code] if error_code.is_a?(Hash)
          safe_body = {error: error_code} if OAUTH_ERROR_CODES.include?(error_code)
          error = OpenAI::Errors::OAuthError.new(status: response.status, body: safe_body, headers: headers)
          error.url = URI(TOKEN_URL)
          raise error
        end

        if [408, 409, 429].include?(response.status) || (500..599).cover?(response.status)
          headers.merge!(response.headers.slice("retry-after", "retry-after-ms", "x-should-retry"))
        end

        raise(
          OpenAI::Errors::APIError.new(
            url: URI(TOKEN_URL),
            status: response.status,
            headers: headers,
            message: "X.509 token exchange failed with status #{response.status}"
          )
        )
      end

      private def invalid_response(reason, response:)
        OpenAI::Errors::APIError.new(
          url: URI(TOKEN_URL),
          status: response.status,
          headers: response.headers.slice("x-request-id"),
          message: "Invalid X.509 token exchange response: #{reason}"
        )
      end
    end
  end
end

# frozen_string_literal: true

module OpenAI
  module Auth
    # Token exchange implementations used by workload identity authentication.
    #
    # @api private
    module TokenExchange
      SUBJECT_TOKEN_TYPES = {
        TokenType::JWT => "urn:ietf:params:oauth:token-type:jwt",
        TokenType::ID => "urn:ietf:params:oauth:token-type:id_token"
      }.freeze

      GRANT_TYPE = "urn:ietf:params:oauth:grant-type:token-exchange"
      DEFAULT_URL = "https://auth.openai.com/oauth/token"
      X509_SUBJECT_TOKEN_TYPE = "urn:openai:params:oauth:token-type:x509"
      X509_URL = "https://mtls.auth.openai.com/oauth/token"
      TIMEOUT_SECONDS = 5.0
      MAX_RETRIES = 2
      INITIAL_RETRY_DELAY = 0.5
      MAX_RETRY_DELAY = 8.0
      MAX_RESPONSE_BYTES = 64 * 1024

      # Exchanges X.509 workload identity through the caller's HTTP transport.
      #
      # @api private
      class X509
        BEARER_TOKEN_PATTERN = /\A[A-Za-z0-9\-._~+\/]+=*\z/
        OAUTH_ERROR_CODES = %w[
          invalid_client
          invalid_grant
          invalid_request
          invalid_scope
          invalid_subject_token
          invalid_target
          unauthorized_client
          unsupported_grant_type
        ]
          .freeze
        private_constant :BEARER_TOKEN_PATTERN, :OAUTH_ERROR_CODES

        # @api private
        attr_reader :url

        # @api private
        def initialize(config, token_exchange_url:, http_client:, sleeper:)
          if token_exchange_url != DEFAULT_URL
            raise ArgumentError, "The X.509 token exchange URL cannot be overridden"
          end

          unless http_client.respond_to?(:execute)
            raise ArgumentError, "X.509 workload identity requires an http_client that responds to execute"
          end

          @identity_provider_id = config.identity_provider_id.to_s.dup.freeze
          @service_account_id = config.service_account_id.to_s.dup.freeze
          @url = URI(X509_URL)
          @http_client = http_client
          @sleeper = sleeper
        end

        # @api private
        def fetch(timeout: nil)
          deadline = timeout&.then { OpenAI::Internal::Util.monotonic_secs + _1 }
          request_options = {
            method: :post,
            url: @url,
            headers: {"accept" => "application/json", "content-type" => "application/json"},
            body: JSON.generate(
              grant_type: GRANT_TYPE,
              subject_token_type: X509_SUBJECT_TOKEN_TYPE,
              identity_provider_id: @identity_provider_id,
              service_account_id: @service_account_id
            )
          }

          retry_count = 0
          loop do
            timeout = [remaining_timeout(deadline), TIMEOUT_SECONDS].compact.min
            request = OpenAI::HTTPClient::Request.new(**request_options, timeout: timeout)
            response = @http_client.execute(request)
            unless response.is_a?(OpenAI::HTTPClient::Response)
              raise TypeError, "`http_client#execute` must return an OpenAI::HTTPClient::Response"
            end

            if retry_count < MAX_RETRIES && retryable_status?(response.status)
              headers = response.headers
              OpenAI::Internal::Util.close_fused!(response.body)
              wait_before_retry(headers, retry_count: retry_count, deadline: deadline)
              retry_count += 1
              next
            end

            return handle_response(response)
          rescue OpenAI::Errors::APIConnectionError
            raise if retry_count >= MAX_RETRIES

            wait_before_retry({}, retry_count: retry_count, deadline: deadline)
            retry_count += 1
          end
        end

        private

        def handle_response(response)
          body = parse_response_body(response)

          case response.status
          when 400, 401, 403
            error_code = body[:error] if body.is_a?(Hash)
            sanitized_body = {error: error_code} if OAUTH_ERROR_CODES.include?(error_code)
            raise(
              OpenAI::Errors::OAuthError.new(
                status: response.status,
                body: sanitized_body,
                headers: sanitized_error_headers(response.headers),
                url: @url
              )
            )
          when 200..299
            validate_token_response!(body)
          else
            message = if (300..399).cover?(response.status)
              "X.509 token exchange refused redirect response with status #{response.status}"
            else
              "X.509 token exchange failed with status #{response.status}"
            end

            raise(
              OpenAI::Errors::APIError.new(
                url: @url,
                status: response.status,
                headers: sanitized_error_headers(response.headers),
                body: nil,
                message: message
              )
            )
          end
        end

        def validate_token_response!(body)
          access_token = nil
          expires_in = nil
          access_token = body[:access_token] if body.is_a?(Hash)
          expires_in = body[:expires_in] if body.is_a?(Hash)
          if body.is_a?(Hash) && body.key?(:token_type)
            token_type = body[:token_type]
            unless token_type.is_a?(String) && token_type.casecmp?("Bearer")
              raise invalid_token_response("token_type must be Bearer when present")
            end
          end

          unless access_token.is_a?(String) && !access_token.empty?
            raise invalid_token_response("access_token must be a non-empty string")
          end

          unless BEARER_TOKEN_PATTERN.match?(access_token)
            raise invalid_token_response("access_token must use the RFC 6750 bearer token grammar")
          end

          unless expires_in.is_a?(Integer) || expires_in.is_a?(Float)
            raise invalid_token_response("expires_in must be a positive number")
          end

          within_float_range = expires_in.is_a?(Integer) ? expires_in <= Float::MAX : expires_in.finite?
          unless within_float_range && expires_in.positive?
            raise invalid_token_response("expires_in must be a positive number")
          end

          expires_in = expires_in.to_f

          {id: access_token, expires_in: expires_in}
        end

        def invalid_token_response(reason)
          OpenAI::Errors::APIError.new(
            url: @url,
            status: 200,
            headers: nil,
            body: nil,
            message: "Invalid X.509 token exchange response: #{reason}"
          )
        end

        def sanitized_error_headers(headers)
          headers.reject do |name, _|
            OpenAI::Internal::Logging.credential_header?(name) ||
              OpenAI::Internal::Logging::URL_HEADER_KEY.match?(name.to_s)
          end
        end

        def parse_response_body(response)
          body = read_body(response)
          return nil if body.empty?

          JSON.parse(body, symbolize_names: true)
        rescue JSON::ParserError
          nil
        end

        def read_body(response)
          body = String.new(capacity: [MAX_RESPONSE_BYTES, 4096].min)
          response.body.each do |chunk|
            remaining = MAX_RESPONSE_BYTES - body.bytesize
            if chunk.bytesize > remaining
              raise invalid_token_response("response body exceeds #{MAX_RESPONSE_BYTES} bytes")
            end

            body << chunk
          end

          body
        ensure
          OpenAI::Internal::Util.close_fused!(response.body)
        end

        def retryable_status?(status)
          status == 408 || status == 409 || status == 429 || status >= 500
        end

        def wait_before_retry(headers, retry_count:, deadline:)
          delay = retry_delay(headers, retry_count: retry_count)
          @sleeper.call([delay, remaining_timeout(deadline)].compact.min)
        end

        def remaining_timeout(deadline)
          return if deadline.nil?

          remaining = deadline - OpenAI::Internal::Util.monotonic_secs
          return remaining if remaining.positive?

          raise Timeout::Error, "request timed out during workload identity authentication"
        end

        def retry_delay(headers, retry_count:)
          retry_after = headers["retry-after"]
          server_delay = Float(retry_after, exception: false)
          if server_delay.nil? && retry_after
            server_delay = Time.httpdate(retry_after) - Time.now
          end

          if server_delay&.finite? && !server_delay.negative?
            return [server_delay, MAX_RETRY_DELAY].min
          end

          default_retry_delay(retry_count)
        rescue ArgumentError
          default_retry_delay(retry_count)
        end

        def default_retry_delay(retry_count)
          (INITIAL_RETRY_DELAY * (2 ** retry_count)).clamp(0, MAX_RETRY_DELAY)
        end
      end
    end
  end
end

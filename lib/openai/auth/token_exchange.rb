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

      # Selects the exchange implementation once at client construction.
      #
      # @api private
      def self.build(config, token_exchange_url:, http_client:, sleeper:)
        case config
        when OpenAI::Auth::X509WorkloadIdentity
          X509.new(
            config,
            token_exchange_url: token_exchange_url,
            http_client: http_client,
            sleeper: sleeper
          )
        when OpenAI::Auth::WorkloadIdentity
          SubjectToken.new(config, token_exchange_url: token_exchange_url)
        else
          raise ArgumentError, "Unsupported workload identity configuration: #{config.class}"
        end
      end

      # Exchanges the existing JWT/ID subject-token workload identity flow.
      #
      # @api private
      class SubjectToken
        # @api private
        attr_reader :url

        # @api private
        def initialize(config, token_exchange_url: DEFAULT_URL)
          @config = config
          @url = URI(token_exchange_url)
        end

        # @api private
        def fetch
          subject_token = @config.provider.get_token
          token_type = @config.provider.token_type
          subject_token_type = SUBJECT_TOKEN_TYPES.fetch(token_type) do
            raise ArgumentError,
                  "Unsupported token type: #{token_type.inspect}. " \
                  "Supported types: #{SUBJECT_TOKEN_TYPES.keys.join(', ')}"
          end

          request = Net::HTTP::Post.new(@url)
          request["Content-Type"] = "application/json"
          body = {
            grant_type: GRANT_TYPE,
            subject_token: subject_token,
            subject_token_type: subject_token_type,
            identity_provider_id: @config.identity_provider_id,
            service_account_id: @config.service_account_id
          }
          body[:client_id] = @config.client_id unless @config.client_id.nil?
          request.body = JSON.generate(body)

          response = Net::HTTP.start(
            @url.hostname,
            @url.port,
            use_ssl: @url.scheme == "https",
            open_timeout: TIMEOUT_SECONDS,
            read_timeout: TIMEOUT_SECONDS,
            write_timeout: TIMEOUT_SECONDS
          ) do |http|
            http.request(request)
          end

          handle_response(response)
        end

        private

        def handle_response(response)
          body = parse_response_body(response)

          case response
          in Net::HTTPBadRequest | Net::HTTPUnauthorized | Net::HTTPForbidden
            raise OpenAI::Errors::OAuthError.new(
              status: response.code.to_i,
              body: body,
              headers: response.to_hash,
              url: @url
            )
          in Net::HTTPSuccess
            {
              id: body&.dig(:access_token),
              expires_in: body&.dig(:expires_in)
            }
          else
            raise OpenAI::Errors::APIError.new(
              url: @url,
              status: response.code.to_i,
              headers: response.to_hash,
              body: body,
              message: "Token exchange failed with status #{response.code}"
            )
          end
        end

        def parse_response_body(response)
          return nil if response.body.nil? || response.body.empty?

          JSON.parse(response.body, symbolize_names: true)
        rescue JSON::ParserError
          nil
        end
      end

      # Exchanges X.509 workload identity through the caller's HTTP transport.
      #
      # @api private
      class X509
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

          @config = config
          @url = URI(X509_URL)
          @http_client = http_client
          @sleeper = sleeper
        end

        # @api private
        def fetch
          request = OpenAI::HTTPClient::Request.new(
            method: :post,
            url: @url,
            headers: {"accept" => "application/json", "content-type" => "application/json"},
            body: JSON.generate(
              grant_type: GRANT_TYPE,
              subject_token_type: X509_SUBJECT_TOKEN_TYPE,
              identity_provider_id: @config.identity_provider_id,
              service_account_id: @config.service_account_id
            ),
            timeout: TIMEOUT_SECONDS
          )

          retry_count = 0
          loop do
            response = @http_client.execute(request)
            unless response.is_a?(OpenAI::HTTPClient::Response)
              raise TypeError, "`http_client#execute` must return an OpenAI::HTTPClient::Response"
            end

            if retry_count < MAX_RETRIES && retryable_status?(response.status)
              headers = response.headers
              OpenAI::Internal::Transport::BaseClient.reap_connection!(
                response.status,
                stream: response.body
              )
              wait_before_retry(headers, retry_count: retry_count)
              retry_count += 1
              next
            end

            return handle_response(response)
          rescue OpenAI::Errors::APIConnectionError
            raise if retry_count >= MAX_RETRIES

            wait_before_retry({}, retry_count: retry_count)
            retry_count += 1
          end
        end

        private

        def handle_response(response)
          body = parse_response_body(response)

          case response.status
          when 400, 401, 403
            error_code = body[:error] if body.is_a?(Hash)
            sanitized_body = error_code.nil? ? nil : {error: error_code}
            raise OpenAI::Errors::OAuthError.new(
              status: response.status,
              body: sanitized_body,
              headers: response.headers,
              url: @url
            )
          when 200..299
            validate_token_response!(body)
          else
            message =
              if (300..399).cover?(response.status)
                "X.509 token exchange refused redirect response with status #{response.status}"
              else
                "X.509 token exchange failed with status #{response.status}"
              end
            raise OpenAI::Errors::APIError.new(
              url: @url,
              status: response.status,
              headers: response.headers,
              body: nil,
              message: message
            )
          end
        end

        def validate_token_response!(body)
          access_token = nil
          expires_in = nil
          access_token = body[:access_token] if body.is_a?(Hash)
          expires_in = body[:expires_in] if body.is_a?(Hash)
          unless access_token.is_a?(String) && !access_token.empty?
            raise invalid_token_response("access_token must be a non-empty string")
          end
          unless expires_in.is_a?(Integer) || (expires_in.is_a?(Float) && expires_in.finite?)
            raise invalid_token_response("expires_in must be a positive number")
          end
          unless expires_in.positive?
            raise invalid_token_response("expires_in must be a positive number")
          end

          {id: access_token, expires_in: expires_in.to_f}
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
            break unless remaining.positive?

            body << chunk.byteslice(0, remaining)
          end
          body
        ensure
          OpenAI::Internal::Util.close_fused!(response.body)
        end

        def retryable_status?(status)
          status == 408 || status == 409 || status == 429 || status >= 500
        end

        def wait_before_retry(headers, retry_count:)
          @sleeper.call(retry_delay(headers, retry_count: retry_count))
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
          (INITIAL_RETRY_DELAY * (2**retry_count)).clamp(0, MAX_RETRY_DELAY)
        end
      end
    end
  end
end

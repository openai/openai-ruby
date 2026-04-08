# frozen_string_literal: true

module OpenAI
  module Auth
    class WorkloadIdentityAuth
      SUBJECT_TOKEN_TYPES = {
        TokenType::JWT => "urn:ietf:params:oauth:token-type:jwt",
        TokenType::ID => "urn:ietf:params:oauth:token-type:id_token"
      }.freeze

      TOKEN_EXCHANGE_GRANT_TYPE = "urn:ietf:params:oauth:grant-type:token-exchange"
      DEFAULT_TOKEN_EXCHANGE_URL = "https://auth.openai.com/oauth/token"
      DEFAULT_REFRESH_BUFFER_SECONDS = 1200

      def initialize(
        config,
        organization_id,
        token_exchange_url: DEFAULT_TOKEN_EXCHANGE_URL
      )
        @config = config
        @organization_id = organization_id
        @token_exchange_url = URI(token_exchange_url)

        @cached_token = nil
        @cached_token_expires_at_monotonic = nil
        @cached_token_refresh_at_monotonic = nil
        @refreshing = false
        @mutex = Mutex.new
        @cond_var = ConditionVariable.new
      end

      def get_token
        @mutex.synchronize do
          @cond_var.wait(@mutex) while @refreshing && token_unusable?

          unless token_unusable? || needs_refresh?
            return @cached_token
          end

          if @refreshing
            @cond_var.wait(@mutex) while @refreshing
            token = @cached_token
            raise OpenAI::Errors::AuthenticationError, "Token refresh failed" if token_unusable?
            return token
          end

          @refreshing = true
        end

        perform_refresh
        @mutex.synchronize do
          raise OpenAI::Errors::AuthenticationError, "Token refresh failed" if token_unusable?
          @cached_token
        end
      end

      def invalidate_token
        @mutex.synchronize do
          @cached_token = nil
          @cached_token_expires_at_monotonic = nil
          @cached_token_refresh_at_monotonic = nil
        end
      end

      private

      def perform_refresh
        token_data = fetch_token_from_exchange
        now = OpenAI::Internal::Util.monotonic_secs
        expires_in = token_data.fetch(:expires_in)

        @mutex.synchronize do
          @cached_token = token_data.fetch(:id)
          @cached_token_expires_at_monotonic = now + expires_in
          @cached_token_refresh_at_monotonic = now + refresh_delay_seconds(expires_in)
        end
      ensure
        @mutex.synchronize do
          @refreshing = false
          @cond_var.broadcast
        end
      end

      def fetch_token_from_exchange
        subject_token = @config.provider.get_token

        token_type = @config.provider.token_type
        subject_token_type = SUBJECT_TOKEN_TYPES.fetch(token_type) do
          raise ArgumentError,
                "Unsupported token type: #{token_type.inspect}. Supported types: #{SUBJECT_TOKEN_TYPES.keys.join(', ')}"
        end

        request = Net::HTTP::Post.new(@token_exchange_url)
        request["Content-Type"] = "application/json"
        request.body = JSON.generate(
          grant_type: TOKEN_EXCHANGE_GRANT_TYPE,
          client_id: @config.client_id,
          subject_token: subject_token,
          subject_token_type: subject_token_type,
          identity_provider_id: @config.identity_provider_id,
          service_account_id: @config.service_account_id
        )

        response = Net::HTTP.start(
          @token_exchange_url.hostname,
          @token_exchange_url.port,
          use_ssl: @token_exchange_url.scheme == "https",
          open_timeout: 5,
          read_timeout: 5,
          write_timeout: 5
        ) do |http|
          http.request(request)
        end

        handle_token_response(response)
      end

      def handle_token_response(response)
        body = parse_response_body(response)

        case response
        in Net::HTTPBadRequest | Net::HTTPUnauthorized | Net::HTTPForbidden
          raise OpenAI::Errors::OAuthError.new(
            status: response.code.to_i,
            body: body,
            headers: response.to_hash
          )
        in Net::HTTPSuccess
          {
            id: body&.dig(:access_token),
            expires_in: body&.dig(:expires_in)
          }
        else
          raise OpenAI::Errors::APIError.new(
            url: @token_exchange_url,
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

      def token_unusable?
        @cached_token.nil? || token_expired?
      end

      def token_expired?
        return true if @cached_token_expires_at_monotonic.nil?

        OpenAI::Internal::Util.monotonic_secs >= @cached_token_expires_at_monotonic
      end

      def needs_refresh?
        return false if @cached_token_refresh_at_monotonic.nil?

        OpenAI::Internal::Util.monotonic_secs >= @cached_token_refresh_at_monotonic
      end

      def refresh_delay_seconds(expires_in)
        configured_buffer = @config.refresh_buffer_seconds || DEFAULT_REFRESH_BUFFER_SECONDS
        effective_buffer = [configured_buffer, expires_in / 2].min

        [expires_in - effective_buffer, 0].max
      end
    end
  end
end

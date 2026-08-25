# frozen_string_literal: true

require "timeout"

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
        token_exchange_url: DEFAULT_TOKEN_EXCHANGE_URL,
        token_exchange: nil
      )
        @config = config
        @organization_id = organization_id
        @token_exchange_url = URI(token_exchange_url)
        @token_exchange = token_exchange

        @cached_token = nil
        @cached_token_expires_at_monotonic = nil
        @cached_token_refresh_at_monotonic = nil
        @refreshing = false
        @refresh_generation = nil
        @refresh_error = nil
        @mutex = Mutex.new
        @cond_var = ConditionVariable.new
      end

      # @api private
      #
      # @param deadline [Float, nil] absolute monotonic deadline for this request
      # @return [String]
      def get_token(deadline: nil)
        loop do
          check_deadline!(deadline)
          action = nil
          token = nil
          generation = nil

          # Installing refresh cleanup is part of the state transition. No async
          # exception may observe @refreshing after it changes but before the ensure.
          Thread.handle_interrupt(Exception => :never) do
            @mutex.synchronize do
              if @refreshing
                if token_unusable?
                  action = :wait
                  generation = @refresh_generation
                else
                  token = @cached_token
                  action = :return
                end
              elsif token_unusable? || needs_refresh?
                @refreshing = true
                generation = {complete: false, error: nil, token: nil, expires_at: nil}
                @refresh_generation = generation
                action = :refresh
              else
                token = @cached_token
                action = :return
              end
            end

            if action == :refresh
              begin
                Thread.handle_interrupt(Exception => :immediate) do
                  perform_refresh(deadline: deadline)
                end

              rescue StandardError => error
                @mutex.synchronize do
                  @refresh_error = error unless @token_exchange.nil?
                  generation[:error] = error
                end

                raise
              ensure
                @mutex.synchronize do
                  if generation[:error].nil?
                    generation[:token] = @cached_token
                    generation[:expires_at] = @cached_token_expires_at_monotonic
                  end

                  generation[:complete] = true
                  @refreshing = false
                  @cond_var.broadcast
                end
              end
            end
          end

          return token if action == :return
          if action == :wait
            token = wait_for_refresh(deadline, generation)
            return token unless token.nil?

            next
          end

          return current_token(deadline)
        end
      end

      # @api private
      def invalidate_token(rejected_token = nil)
        @mutex.synchronize do
          return nil unless rejected_token.nil? || rejected_token == @cached_token

          @cached_token = nil
          @cached_token_expires_at_monotonic = nil
          @cached_token_refresh_at_monotonic = nil
        end
      end

      # Avoid exposing cached access tokens or identity configuration in diagnostics.
      #
      # @return [String]
      def inspect
        "#<#{self.class.name}:0x#{object_id.to_s(16)}>"
      end

      private def current_token(deadline)
        check_deadline!(deadline)
        @mutex.synchronize do
          raise_refresh_error! if token_unusable?

          @cached_token
        end
      end

      private def wait_for_refresh(deadline, generation)
        @mutex.synchronize do
          until generation.fetch(:complete)
            remaining = remaining_timeout(deadline)
            if remaining.nil?
              @cond_var.wait(@mutex)
            else
              @cond_var.wait(@mutex, remaining)
            end
          end

          check_deadline!(deadline)
          if @token_exchange
            raise generation.fetch(:error) if generation[:error]
            if generation[:token]
              unless generation[:token] == @cached_token
                return nil if @cached_token.nil?

                raise_refresh_error! if token_unusable?

                return @cached_token
              end

              expires_at = generation.fetch(:expires_at)
              raise_refresh_error! if expires_at.nil? || OpenAI::Internal::Util.monotonic_secs >= expires_at

              return generation.fetch(:token)
            end
          end

          raise_refresh_error! if token_unusable?

          @cached_token
        end
      end

      private def raise_refresh_error!
        raise(
          OpenAI::Errors::AuthenticationError.new(
            url: @token_exchange_url,
            status: 401,
            headers: nil,
            body: nil,
            request: nil,
            response: nil,
            message: "Token refresh failed"
          )
        )
      end

      private def perform_refresh(deadline:)
        token_data = fetch_token_from_exchange(deadline: deadline)
        now = OpenAI::Internal::Util.monotonic_secs
        expires_in = token_data.fetch(:expires_in)

        @mutex.synchronize do
          @refresh_error = nil
          @cached_token = token_data.fetch(:id)
          @cached_token_expires_at_monotonic = now + expires_in
          @cached_token_refresh_at_monotonic = now + refresh_delay_seconds(expires_in)
        end
      end

      private def fetch_token_from_exchange(deadline:)
        return @token_exchange.fetch(deadline: deadline) unless @token_exchange.nil?

        subject_token = @config.provider.get_token
        check_deadline!(deadline)

        token_type = @config.provider.token_type
        subject_token_type = SUBJECT_TOKEN_TYPES.fetch(token_type) do
          raise(
            ArgumentError,
            "Unsupported token type: #{token_type.inspect}. Supported types: #{SUBJECT_TOKEN_TYPES.keys.join(", ")}"
          )
        end

        request = Net::HTTP::Post.new(@token_exchange_url)
        request["Content-Type"] = "application/json"
        body = {
          grant_type: TOKEN_EXCHANGE_GRANT_TYPE,
          subject_token: subject_token,
          subject_token_type: subject_token_type,
          identity_provider_id: @config.identity_provider_id,
          service_account_id: @config.service_account_id
        }
        body[:client_id] = @config.client_id unless @config.client_id.nil?
        request.body = JSON.generate(body)

        timeout = [remaining_timeout(deadline), 5].compact.min
        response = Net::HTTP
          .start(
            @token_exchange_url.hostname,
            @token_exchange_url.port,
            use_ssl: @token_exchange_url.scheme == "https",
            open_timeout: timeout,
            read_timeout: timeout,
            write_timeout: timeout
          ) do |http|
            http.request(request)
          end

        check_deadline!(deadline)

        handle_token_response(response)
      end

      private def check_deadline!(deadline)
        remaining_timeout(deadline)
        nil
      end

      private def remaining_timeout(deadline)
        return if deadline.nil?

        remaining = deadline - OpenAI::Internal::Util.monotonic_secs
        unless remaining.positive?
          raise Timeout::Error, "request timed out during workload identity authentication"
        end

        remaining
      end

      private def handle_token_response(response)
        body = parse_response_body(response)

        case response
        in Net::HTTPBadRequest | Net::HTTPUnauthorized | Net::HTTPForbidden
          raise(
            OpenAI::Errors::OAuthError.new(
              status: response.code.to_i,
              body: body,
              headers: response.to_hash
            )
          )
        in Net::HTTPSuccess
          {
            id: body&.dig(:access_token),
            expires_in: body&.dig(:expires_in)
          }
        else
          raise(
            OpenAI::Errors::APIError.new(
              url: @token_exchange_url,
              status: response.code.to_i,
              headers: response.to_hash,
              body: body,
              message: "Token exchange failed with status #{response.code}"
            )
          )
        end
      end

      private def parse_response_body(response)
        return nil if response.body.nil? || response.body.empty?

        JSON.parse(response.body, symbolize_names: true)
      rescue JSON::ParserError
        nil
      end

      private def token_unusable?
        @cached_token.nil? || token_expired?
      end

      private def token_expired?
        return true if @cached_token_expires_at_monotonic.nil?

        OpenAI::Internal::Util.monotonic_secs >= @cached_token_expires_at_monotonic
      end

      private def needs_refresh?
        return false if @cached_token_refresh_at_monotonic.nil?

        OpenAI::Internal::Util.monotonic_secs >= @cached_token_refresh_at_monotonic
      end

      private def refresh_delay_seconds(expires_in)
        configured_buffer = @config.refresh_buffer_seconds || DEFAULT_REFRESH_BUFFER_SECONDS
        effective_buffer = [configured_buffer, expires_in / 2].min

        [expires_in - effective_buffer, 0].max
      end
    end
  end
end

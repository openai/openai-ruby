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
      MAX_REJECTED_TOKEN_REFRESH_ATTEMPTS = 3
      private_constant :MAX_REJECTED_TOKEN_REFRESH_ATTEMPTS

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
        @issued_token_expirations = {}
        @rejected_tokens = {}
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
          previous_token = nil

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
                previous_token = @cached_token
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
                fallback = false
                @mutex.synchronize do
                  now = OpenAI::Internal::Util.monotonic_secs unless @token_exchange.nil?
                  if now && proactive_refresh_fallback?(error, previous_token, deadline, now)
                    remaining = @cached_token_expires_at_monotonic - now
                    @cached_token_refresh_at_monotonic = now + [5.0, remaining / 2].min
                    @refresh_error = error
                    fallback = true
                  else
                    @refresh_error = error unless @token_exchange.nil?
                    generation[:error] = error
                  end
                end

                raise unless fallback
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
          if @token_exchange && rejected_token
            expires_at = @issued_token_expirations[rejected_token]
            @rejected_tokens[rejected_token] = expires_at unless expires_at.nil?
          end

          return nil unless rejected_token.nil? || rejected_token == @cached_token

          @cached_token = nil
          @cached_token_expires_at_monotonic = nil
          @cached_token_refresh_at_monotonic = nil
        end
      end

      # @api private
      def bound_to?(identity, transport:)
        @config.equal?(identity) &&
          X509Transport.exact_instance?(@token_exchange, X509TokenExchange) &&
          @token_exchange.bound_to?(identity, transport: transport)
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

      private def proactive_refresh_fallback?(error, previous_token, deadline, now)
        return false if @token_exchange.nil? || previous_token.nil? || !@cached_token.equal?(previous_token)
        expires_at = @cached_token_expires_at_monotonic
        return false if expires_at.nil? || now >= expires_at
        return false if deadline && now >= deadline
        return true if error.is_a?(OpenAI::Errors::APIConnectionError)
        return false unless error.is_a?(OpenAI::Errors::APIError)

        status = error.status
        [408, 409, 429].include?(status) || (status.is_a?(Integer) && (500..599).cover?(status))
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
        raise @refresh_error if @token_exchange && @refresh_error

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
        rejected_attempts = 0

        loop do
          token_data = fetch_token_from_exchange(deadline: deadline)
          now = OpenAI::Internal::Util.monotonic_secs
          expires_in = token_data.fetch(:expires_in)
          token = token_data.fetch(:id)

          published = @mutex.synchronize do
            @issued_token_expirations.delete_if { |_issued, expires_at| expires_at <= now }
            @rejected_tokens.delete_if { |_rejected, expires_at| expires_at <= now }
            unless @token_exchange && @rejected_tokens.key?(token)
              expires_at = now + expires_in
              @refresh_error = nil
              @cached_token = token
              @cached_token_expires_at_monotonic = expires_at
              @cached_token_refresh_at_monotonic = now + refresh_delay_seconds(expires_in)
              @issued_token_expirations[token] = expires_at if @token_exchange
              true
            end
          end

          return if published

          rejected_attempts += 1
          if rejected_attempts >= MAX_REJECTED_TOKEN_REFRESH_ATTEMPTS
            raise(
              OpenAI::Errors::AuthenticationError.new(
                url: @token_exchange_url,
                status: 401,
                headers: nil,
                body: nil,
                request: nil,
                response: nil,
                message: "Token issuer repeatedly returned a rejected access token"
              )
            )
          end

          check_deadline!(deadline)
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

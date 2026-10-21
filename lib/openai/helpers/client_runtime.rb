# frozen_string_literal: true

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # @api private
    private def x509_identity?(identity)
      OpenAI::Auth::X509Transport.exact_instance?(identity, OpenAI::Auth::X509WorkloadIdentity)
    end

    # @api private
    private def x509_transport?(transport)
      OpenAI::Auth::X509Transport.exact_instance?(transport, OpenAI::Auth::X509Transport)
    end

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`.
    #   Mutually exclusive with `workload_identity`.
    #

    # @api private
    private def build_request(request, options)
      if @provider_runtime
        built = super
        body = built[:body]
        # Capture only the final model; provider hooks run after body encoding.
        model = body.reverse_each.find { |key, _| key == :model || key == "model" }&.last if body.is_a?(Hash)
        model = model.to_s if model.is_a?(Symbol)
        return built.merge(provider_request_model: model)
      end

      unless @workload_identity_auth && x509_transport?(@requester)
        return super
      end

      selected = {}.merge(request.fetch(:security, {bearer_auth: true, admin_api_key_auth: true})).freeze
      if selected.any? { |scheme, enabled| enabled && scheme != :bearer_auth && scheme != :admin_api_key_auth }
        raise ArgumentError, "Unsupported authentication security scheme for X.509 workload identity"
      end

      security = {
        bearer_auth: selected[:bearer_auth] == true,
        admin_api_key_auth: selected[:admin_api_key_auth] == true
      }.freeze
      expected = auth_headers(security: security)["authorization"]
      built = super(request.merge(security: security), options)
      canonical_headers = @requester.validate_api_request!(
        url: built.fetch(:url),
        headers: built.fetch(:headers)
      )
      unless expected == canonical_headers["authorization"]
        raise OpenAI::Errors::Error, "X.509 requests cannot override the selected authorization credential"
      end

      auth_max_retries = options.fetch(:max_retries, @max_retries)
      built.merge(headers: canonical_headers, x509_auth_max_retries: auth_max_retries)
    end

    # @api private
    private def prepare_request(request, redirect_count:, retry_count:)
      if workload_identity_request?(request)
        request = prepare_workload_identity_request(request, retry_count: retry_count)
      end

      preparer = @provider_runtime&.prepare_request
      return super(request, redirect_count: redirect_count, retry_count: retry_count) unless preparer
      preparer.call(request)
    end

    # @api private
    private def validate_prepared_request(request, original_request:)
      prepared_request = super
      return prepared_request unless @workload_identity_auth && x509_transport?(@requester)

      canonical_headers = @requester.validate_api_request!(
        url: prepared_request.fetch(:url),
        headers: prepared_request.fetch(:headers)
      )
      expected = if (context = original_request[:x509_request_context])
        "Bearer #{context.fetch(:token)}"
      else
        original_request.fetch(:headers)["authorization"]
      end

      unless canonical_headers["authorization"] == expected
        raise OpenAI::Errors::Error, "X.509 requests cannot override the selected authorization credential"
      end

      prepared_request.merge(headers: canonical_headers)
    end

    # @api private
    private def validate_retry_delay!(request, delay:)
      deadline = request[:x509_request_context]&.fetch(:deadline) || request[:workload_identity_deadline]
      if deadline && delay >= deadline - OpenAI::Internal::Util.monotonic_secs
        raise WORKLOAD_IDENTITY_DEADLINE_ERROR, "request timed out during workload identity authentication"
      end

      super
    end

    # @api private
    private def send_request(request, redirect_count:, retry_count:, send_retry_header:)
      if (wrapper = @provider_runtime&.wrap_request)
        return wrapper.call(request, request_replayable?(request)) do |attempt|
          super(attempt, redirect_count: redirect_count, retry_count: retry_count, send_retry_header: send_retry_header)
        end
      end

      if @workload_identity_auth && x509_transport?(@requester)
        canonical_headers = @requester.validate_api_request!(
          url: request.fetch(:url),
          headers: request.fetch(:headers)
        )
        request = request.merge(headers: canonical_headers)
        authorization = canonical_headers["authorization"]
        expected = "Bearer #{WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
        admin_authorization = @admin_api_key && "Bearer #{@admin_api_key}"
        unless authorization.nil? || authorization == expected || authorization == admin_authorization
          raise OpenAI::Errors::Error, "X.509 requests cannot override the selected authorization credential"
        end
      end

      return super unless workload_identity_request?(request)

      x509_request = x509_transport?(@requester)
      previous_context = request[:x509_request_context]
      deadline = if x509_request
        previous_context&.fetch(:deadline) ||
          request[:workload_identity_deadline] ||
          request[:timeout]&.then { OpenAI::Internal::Util.monotonic_secs + _1 }
      else
        request[:workload_identity_deadline] ||
          request[:timeout]&.then { OpenAI::Internal::Util.monotonic_secs + _1 }
      end

      request = request.merge(workload_identity_deadline: deadline)
      if x509_request
        replay_state = previous_context&.fetch(:replay_state) || []
        issuer_retries = previous_context&.fetch(:issuer_retries, 0) || 0
        auth_max_retries = previous_context&.fetch(:auth_max_retries) || request.fetch(:x509_auth_max_retries)
        api_max_retries = previous_context&.fetch(:api_max_retries) || request.fetch(:max_retries)
        log_context = previous_context&.fetch(:log_context) || yield
        context = {
          deadline: deadline,
          replay_state: replay_state,
          issuer_retries: issuer_retries,
          auth_max_retries: auth_max_retries,
          api_max_retries: api_max_retries,
          log_context: log_context,
          token: nil
        }
        request = request.merge(x509_request_context: context, max_retries: 0)
      end

      begin
        super(
          request,
          redirect_count: redirect_count,
          retry_count: retry_count,
          send_retry_header: send_retry_header
        )
      rescue OpenAI::Errors::AuthenticationError
        if x509_request
          rejected_token = request.fetch(:x509_request_context).fetch(:token)
          raise if rejected_token.nil?

          @workload_identity_auth.invalidate_token(rejected_token)
        end

        replay_allowed = request_replayable?(request)
        replay_allowed &&= x509_request ? replay_state.empty? : retry_count.zero?
        raise unless replay_allowed

        if x509_request
          replay_state << true
          replay_state.freeze
          issuer_retries = context.fetch(:issuer_retries)
          auth_max_retries = context.fetch(:auth_max_retries)
          api_max_retries = context.fetch(:api_max_retries)
          log_context = context.fetch(:log_context)
          context = {
            deadline: deadline,
            replay_state: replay_state,
            issuer_retries: issuer_retries,
            auth_max_retries: auth_max_retries,
            api_max_retries: api_max_retries,
            log_context: log_context,
            token: nil
          }
          request = request.merge(x509_request_context: context)
        else
          @workload_identity_auth.invalidate_token
        end

        begin
          super(
            request,
            redirect_count: redirect_count,
            retry_count: retry_count + 1,
            send_retry_header: send_retry_header
          )
        rescue OpenAI::Errors::AuthenticationError
          if x509_request && (rejected_token = request.fetch(:x509_request_context).fetch(:token))
            @workload_identity_auth.invalidate_token(rejected_token)
          end

          raise
        end
      end

    rescue Timeout::Error => error
      unless x509_request
        raise unless error.is_a?(WORKLOAD_IDENTITY_DEADLINE_ERROR)

        url = request.fetch(:url).dup
        url.query = nil
        url.fragment = nil
        cause = Timeout::Error.new(error.message)
        raise OpenAI::Errors::APITimeoutError.new(url: url, message: error.message), cause: cause
      end

      url = request.fetch(:url).dup
      url.query = nil
      url.fragment = nil
      message = "request timed out during workload identity authentication"
      raise OpenAI::Errors::APITimeoutError.new(url: url, message: message), cause: nil
    end

    private def workload_identity_request?(request)
      return false unless @workload_identity_auth

      expected = "Bearer #{WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
      request[:headers]["authorization"] == expected
    end

    private def prepare_workload_identity_request(request, retry_count:)
      deadline = request[:workload_identity_deadline]
      previous_issuer_retries = request[:x509_request_context]&.fetch(:issuer_retries, 0) || 0
      attempts = 0
      begin
        token = @workload_identity_auth.get_token(deadline: deadline)
      rescue OpenAI::Errors::APIError => error
        status = error.status
        connection_failure = error.is_a?(OpenAI::Errors::APIConnectionError)
        retryable_connection_failure = connection_failure &&
          false.equal?(error.request_may_have_been_sent?)
        retryable_status = retryable_connection_failure ||
          [408, 409, 429].include?(status) ||
          (status.is_a?(Integer) && (500..599).cover?(status))
        consumed_retries = attempts + previous_issuer_retries + retry_count
        unless x509_transport?(@requester) &&
            retryable_status &&
            consumed_retries < request.fetch(:x509_request_context).fetch(:auth_max_retries) &&
            (retryable_connection_failure || self.class.should_retry?(status, headers: error.headers || {}))
          raise
        end

        delay = retry_delay(error.headers || {}, retry_count: attempts)
        if deadline && delay >= deadline - OpenAI::Internal::Util.monotonic_secs
          raise Timeout::Error, "request timed out during workload identity authentication"
        end

        context = request.fetch(:x509_request_context)
        response = if connection_failure
          nil
        else
          OpenAI::ResponseMetadata.new(status: status, headers: error.headers || {})
        end

        context.fetch(:log_context).retry_scheduled(
          connection_failure ? error : status,
          delay: delay,
          response: response,
          retry_count: consumed_retries,
          max_retries: context.fetch(:auth_max_retries)
        )
        sleep(delay)
        attempts += 1
        retry
      end

      if (context = request[:x509_request_context])
        context[:issuer_retries] = previous_issuer_retries + attempts
        context[:token] = token.dup.freeze
        context.freeze
      end

      updated_headers = request[:headers].merge("authorization" => "Bearer #{token}")
      updated_request = request
        .except(:workload_identity_deadline, :x509_request_context, :x509_auth_max_retries)
        .merge(headers: updated_headers)
      if context
        updated_request = updated_request.merge(
          max_retries: [context.fetch(:api_max_retries) - context.fetch(:issuer_retries), 0].max
        )
      end

      request_with_remaining_timeout(
        updated_request,
        deadline
      )
    rescue Timeout::Error => e
      raise if x509_transport?(@requester)

      url = request.fetch(:url).dup
      url.query = nil
      url.fragment = nil
      raise OpenAI::Errors::APITimeoutError.new(url: url, message: e.message)
    end

    # @api private
    private def request_with_remaining_timeout(request, deadline)
      return request if deadline.nil?

      remaining = deadline - OpenAI::Internal::Util.monotonic_secs
      unless remaining.positive?
        raise Timeout::Error, "request timed out during workload identity authentication"
      end

      request.merge(timeout: remaining)
    end

    # Returns a new client of the same class with the supplied constructor options overridden.
    # Other settings and the HTTP transport are inherited. The original client
    # is unchanged. Header overrides are merged; nil removes an individual
    # header, and default_headers: nil clears all custom default headers.
    # Subclasses with incompatible constructors or a private .new must override
    # this method if they need to support copying.
    #
    # @example Select a regional endpoint for a call
    #   client.with_options(base_url: "https://eu.api.openai.com/v1").responses.create(...)
    # @param overrides [Hash{Symbol=>Object}] Options accepted by {#initialize}.
    # @return [self]
    def with_options(**overrides)
      if overrides.key?(:workload_identity) && !overrides.key?(:http_client)
        selected_identity = overrides.fetch(:workload_identity)
        if x509_identity?(selected_identity) && (configured_transport = selected_identity.transport)
          overrides = overrides.merge(http_client: configured_transport)
        end
      end

      previous_transport = @copy_options.fetch(:http_client)
      transport = overrides.fetch(:http_client, previous_transport)
      if overrides[:data_residency] && x509_transport?(transport)
        residency = overrides.fetch(:data_residency)
        options = OpenAI::Internal::ClientOptions.copy(@copy_options, overrides.except(:data_residency))
        options.delete(:base_url) unless overrides.key?(:base_url)
        return copy_with_workload_identity_auth(options.merge(data_residency: residency))
      end

      options = OpenAI::Internal::ClientOptions.copy(@copy_options, overrides)
      adopted_identity = x509_identity?(options.fetch(:workload_identity)) &&
        !x509_identity?(@copy_options.fetch(:workload_identity))
      previous_origin = previous_transport.api_origin if x509_transport?(previous_transport)
      selected_origin = transport.api_origin if x509_transport?(transport)
      if adopted_identity && selected_origin
        inherited_origin = OpenAI::Internal::Util.uri_origin(URI(options.fetch(:base_url).to_s))
        adopted_identity = !inherited_origin.casecmp?(selected_origin)
      end

      if (adopted_identity || previous_origin != selected_origin) &&
          !overrides.key?(:base_url) &&
          !overrides[:data_residency]
        options.delete(:base_url)
      end

      copy_with_workload_identity_auth(options)
    end

    # @api private
    private def copy_with_workload_identity_auth(options)
      copied = self.class.new(**options)
      identity = @copy_options.fetch(:workload_identity)
      if x509_identity?(identity) &&
          identity.equal?(options.fetch(:workload_identity)) &&
          copied.requester.equal?(@requester)
        copied.adopt_workload_identity_auth!(@workload_identity_auth)
      end

      copied
    end

    # @api private
    def adopt_workload_identity_auth!(authenticator)
      identity = @copy_options.fetch(:workload_identity)
      unless x509_identity?(identity) &&
          x509_transport?(@requester) &&
          OpenAI::Auth::X509Transport.exact_instance?(authenticator, OpenAI::Auth::WorkloadIdentityAuth) &&
          authenticator.bound_to?(identity, transport: @requester)
        raise ArgumentError, "X.509 authenticator must match its workload identity and attested transport"
      end

      @workload_identity_auth = authenticator
    end
  end
end

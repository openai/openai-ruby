# frozen_string_literal: true

require_relative "helpers/data_residency"

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # Default max number of retries to attempt after a failed retryable request.
    DEFAULT_MAX_RETRIES = 2

    # Default per-request timeout.
    DEFAULT_TIMEOUT_IN_SECONDS = 600.0

    # Default initial retry delay in seconds.
    # Overall delay is calculated using exponential backoff + jitter.
    DEFAULT_INITIAL_RETRY_DELAY = 0.5

    # Default max retry delay in seconds.
    DEFAULT_MAX_RETRY_DELAY = 8.0

    WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER = "workload-identity-auth"

    # @return [String, nil]
    attr_reader :api_key

    # @return [String, nil]
    attr_reader :admin_api_key

    # @return [String, nil]
    attr_reader :organization

    # @return [String, nil]
    attr_reader :project

    # @return [String, nil]
    attr_reader :webhook_secret

    # @return [OpenAI::Auth::WorkloadIdentityAuth, nil]
    # @api private
    attr_reader :workload_identity_auth

    # Given a prompt, the model will return one or more predicted completions, and can
    # also return the probabilities of alternative tokens at each position.
    # @return [OpenAI::Resources::Completions]
    attr_reader :completions

    # @return [OpenAI::Resources::Chat]
    attr_reader :chat

    # Get a vector representation of a given input that can be easily consumed by
    # machine learning models and algorithms.
    # @return [OpenAI::Resources::Embeddings]
    attr_reader :embeddings

    # Files are used to upload documents that can be used with features like
    # Assistants and Fine-tuning.
    # @return [OpenAI::Resources::Files]
    attr_reader :files

    # Given a prompt and/or an input image, the model will generate a new image.
    # @return [OpenAI::Resources::Images]
    attr_reader :images

    # @return [OpenAI::Resources::ContentProvenanceChecks]
    attr_reader :content_provenance_checks

    # @return [OpenAI::Resources::Audio]
    attr_reader :audio

    # Given text and/or image inputs, classifies if those inputs are potentially
    # harmful.
    # @return [OpenAI::Resources::Moderations]
    attr_reader :moderations

    # List and describe the various models available in the API.
    # @return [OpenAI::Resources::Models]
    attr_reader :models

    # @return [OpenAI::Resources::FineTuning]
    attr_reader :fine_tuning

    # @return [OpenAI::Resources::Graders]
    attr_reader :graders

    # @return [OpenAI::Resources::VectorStores]
    attr_reader :vector_stores

    # @return [OpenAI::Resources::Webhooks]
    attr_reader :webhooks

    # @return [OpenAI::Resources::Beta]
    attr_reader :beta

    # Create large batches of API requests to run asynchronously.
    # @return [OpenAI::Resources::Batches]
    attr_reader :batches

    # Use Uploads to upload large files in multiple parts.
    # @return [OpenAI::Resources::Uploads]
    attr_reader :uploads

    # @return [OpenAI::Resources::Admin]
    attr_reader :admin

    # @return [OpenAI::Resources::Responses]
    attr_reader :responses

    # @return [OpenAI::Resources::Realtime]
    attr_reader :realtime

    # Manage conversations and conversation items.
    # @return [OpenAI::Resources::Conversations]
    attr_reader :conversations

    # Manage and run evals in the OpenAI platform.
    # @return [OpenAI::Resources::Evals]
    attr_reader :evals

    # @return [OpenAI::Resources::Containers]
    attr_reader :containers

    # @return [OpenAI::Resources::Skills]
    attr_reader :skills

    # @return [OpenAI::Resources::Videos]
    attr_reader :videos

    # @api private
    #
    # @param security [Hash{Symbol=>Boolean}]
    #
    # @return [Hash{String=>String}]
    private def auth_headers(security:)
      return {} if @provider_runtime

      enabled_security = security.select { |_, enabled| enabled }
      enabled_auth = {bearer_auth:, admin_api_key_auth:}.select { |scheme, _| enabled_security.key?(scheme) }
      headers = enabled_auth.values.reduce({}) do |merged, authentication|
        merged.merge(authentication) do |header, previous, current|
          header == "authorization" ? previous : current
        end
      end

      if headers.empty? && enabled_security.any?
        raise(
          ArgumentError,
          "Could not resolve authentication method. Expected either api_key or admin_api_key to be set."
        )
      end

      headers
    end

    # @api private
    #
    # @return [Hash{String=>String}]
    private def bearer_auth
      return {} if @api_key.nil?

      {"authorization" => "Bearer #{@api_key}"}
    end

    # @api private
    #
    # @return [Hash{String=>String}]
    private def admin_api_key_auth
      return {} if @admin_api_key.nil?

      {"authorization" => "Bearer #{@admin_api_key}"}
    end

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
        raise Timeout::Error, "request timed out during workload identity authentication"
      end

      super
    end

    # @api private
    private def send_request(request, redirect_count:, retry_count:, send_retry_header:)
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
        raise unless request.key?(:workload_identity_deadline)

        raise OpenAI::Errors::APITimeoutError.new(url: request.fetch(:url), message: error.message)
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
        retryable_status = connection_failure ||
          [408, 409, 429].include?(status) ||
          (status.is_a?(Integer) && (500..599).cover?(status))
        consumed_retries = attempts + previous_issuer_retries + retry_count
        unless x509_transport?(@requester) &&
            retryable_status &&
            consumed_retries < request.fetch(:x509_request_context).fetch(:auth_max_retries) &&
            (connection_failure || self.class.should_retry?(status, headers: error.headers || {}))
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

      raise OpenAI::Errors::APITimeoutError.new(url: request.fetch(:url), message: e.message)
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

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`.
    #   Mutually exclusive with `workload_identity`.
    #
    # @param admin_api_key [String, nil] Defaults to `ENV["OPENAI_ADMIN_KEY"]`
    #
    # @param workload_identity [OpenAI::Auth::WorkloadIdentity, OpenAI::Auth::X509WorkloadIdentity, nil]
    #   OAuth2 workload identity configuration for token exchange authentication.
    #   Mutually exclusive with `api_key`.
    #
    # @param organization [String, nil] Defaults to `ENV["OPENAI_ORG_ID"]`.
    #
    # @param project [String, nil] Defaults to `ENV["OPENAI_PROJECT_ID"]`.
    #
    # @param webhook_secret [String, nil] Defaults to `ENV["OPENAI_WEBHOOK_SECRET"]`
    #
    # @param provider [OpenAI::Provider, nil] Configure a supported
    #   third-party provider. Provider authentication and routing cannot be combined
    #   with top-level `api_key`, `admin_api_key`, `workload_identity`, or `base_url`.
    #
    # @param base_url [String, nil] Override the default base URL for the API, e.g.,
    # `"https://api.example.com/v2/"`. Defaults to `ENV["OPENAI_BASE_URL"]`
    #
    # @param data_residency [Symbol, String, nil] Select `global`, `us`, `eu`, or
    #   `ae`. Mutually exclusive with an explicit `base_url` or `provider`.
    #   This selects an endpoint; project and model eligibility still apply.
    #
    # @param default_headers [Hash{String=>String, nil}, nil] Extra headers to send
    #   with every request. Explicit values override `ENV["OPENAI_CUSTOM_HEADERS"]`.
    #
    # @param max_retries [Integer] Max number of retries to attempt after a failed retryable request.
    #
    # @param timeout [Float, nil]
    #
    # @param initial_retry_delay [Float]
    #
    # @param max_retry_delay [Float]
    #
    # @param http_client [#execute, nil] The HTTP client used to
    #   execute SDK requests. Defaults to {OpenAI::NetHTTPClient}.
    #
    # @param logger [#debug, #info, #warn, #error, nil] Logger for SDK request diagnostics.
    #
    # @param log_level [Symbol, String, nil] SDK request log level. Defaults to
    #   `ENV["OPENAI_LOG"]`, `:info` when `logger` is provided, and `:off` otherwise.
    #
    # @param on_retry [Proc, nil] Callback invoked immediately before an API retry delay.
    def initialize(
      api_key: OpenAI::Internal::OMIT,
      admin_api_key: OpenAI::Internal::OMIT,
      workload_identity: nil,
      organization: OpenAI::Internal::OMIT,
      project: OpenAI::Internal::OMIT,
      webhook_secret: OpenAI::Internal::OMIT,
      provider: nil,
      base_url: OpenAI::Internal::OMIT,
      data_residency: nil,
      default_headers: nil,
      max_retries: self.class::DEFAULT_MAX_RETRIES,
      timeout: self.class::DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: self.class::DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: self.class::DEFAULT_MAX_RETRY_DELAY,
      http_client: nil,
      logger: nil,
      log_level: nil,
      on_retry: nil
    )
      if Object.instance_method(:is_a?).bind_call(workload_identity, OpenAI::Auth::X509WorkloadIdentity) &&
          !x509_identity?(workload_identity)
        raise ArgumentError, "X509WorkloadIdentity subclasses are not supported"
      end

      x509_identity = x509_identity?(workload_identity)
      if x509_identity && (configured_transport = workload_identity.transport)
        if !http_client.nil? && !http_client.equal?(configured_transport)
          raise ArgumentError, "X.509 workload identity must use its configured X.509 transport"
        end

        http_client = configured_transport
      end

      if x509_identity && !x509_transport?(http_client)
        raise ArgumentError, "X.509 workload identity requires an attested X509Transport"
      end

      base_url = OpenAI::Internal::ClientOptions.resolve_data_residency(
        data_residency,
        base_url: base_url,
        provider: provider
      )
      if x509_transport?(http_client) && !data_residency.nil?
        unless http_client.supports_data_residency?(data_residency)
          raise ArgumentError, "X.509 data residency must match its attested OpenAI mTLS API origin"
        end

        base_url = "#{http_client.api_origin}/v1"
      end

      provider_runtime = nil
      unless provider.nil?
        provider_name = OpenAI::Internal::Provider.name(provider)
        conflicts = {
          api_key: api_key,
          admin_api_key: admin_api_key,
          workload_identity: workload_identity,
          base_url: base_url
        }.filter_map do |name, value|
          name unless value.equal?(OpenAI::Internal::OMIT) || value.nil?
        end

        unless conflicts.empty?
          formatted = conflicts.map { "`#{_1}`" }.join(", ")
          message = "`provider` cannot be combined with top-level #{formatted}. Move provider " \
            "authentication and routing options into `#{provider_name}(...)`."
          raise ArgumentError, message
        end

        provider_runtime = OpenAI::Internal::Provider.configure(provider)
      end

      api_key = ENV["OPENAI_API_KEY"] if api_key.equal?(OpenAI::Internal::OMIT) && provider_runtime.nil?
      if admin_api_key.equal?(OpenAI::Internal::OMIT) && provider_runtime.nil?
        admin_api_key = ENV["OPENAI_ADMIN_KEY"]
      end

      if organization.equal?(OpenAI::Internal::OMIT) && provider_runtime.nil?
        organization = ENV["OPENAI_ORG_ID"]
      end

      project = ENV["OPENAI_PROJECT_ID"] if project.equal?(OpenAI::Internal::OMIT) && provider_runtime.nil?
      webhook_secret = ENV["OPENAI_WEBHOOK_SECRET"] if webhook_secret.equal?(OpenAI::Internal::OMIT)
      base_url = ENV["OPENAI_BASE_URL"] if base_url.equal?(OpenAI::Internal::OMIT) && provider_runtime.nil?

      api_key = nil if api_key.equal?(OpenAI::Internal::OMIT)
      admin_api_key = nil if admin_api_key.equal?(OpenAI::Internal::OMIT)
      organization = nil if organization.equal?(OpenAI::Internal::OMIT)
      project = nil if project.equal?(OpenAI::Internal::OMIT)
      webhook_secret = nil if webhook_secret.equal?(OpenAI::Internal::OMIT)
      base_url = provider_runtime.base_url if provider_runtime
      base_url = nil if base_url.equal?(OpenAI::Internal::OMIT)
      base_url ||= if x509_transport?(http_client)
        "#{http_client.api_origin}/v1"
      else
        "https://api.openai.com/v1"
      end

      if x509_identity
        configured_uri = URI(base_url.to_s)
        unless configured_uri.is_a?(URI::HTTPS) &&
            configured_uri.userinfo.nil? &&
            configured_uri.port == URI::HTTPS::DEFAULT_PORT &&
            OpenAI::Internal::Util.uri_origin(configured_uri).casecmp?(http_client.api_origin)
          raise ArgumentError, "X.509 workload identity requires its attested OpenAI mTLS API origin"
        end
      end

      if !api_key.nil? && !workload_identity.nil?
        raise ArgumentError, "`api_key` and `workload_identity` are mutually exclusive"
      end

      if provider_runtime.nil? && api_key.nil? && admin_api_key.nil? && workload_identity.nil?
        raise(
          ArgumentError,
          "Missing credentials. Please pass an `api_key`, `workload_identity`, `admin_api_key`, or set the `OPENAI_API_KEY` or `OPENAI_ADMIN_KEY` environment variable."
        )
      end

      headers = {
        "openai-organization" => (@organization = organization&.to_s),
        "openai-project" => (@project = project&.to_s)
      }
      parsed = {}
      resolved_headers = default_headers.is_a?(OpenAI::Internal::ClientOptions::ResolvedHeaders)
      custom_headers_env = ENV["OPENAI_CUSTOM_HEADERS"] unless provider_runtime || resolved_headers
      unless custom_headers_env.nil?
        custom_headers_env.split("\n").each do |line|
          colon = line.index(":")
          unless colon.nil?
            parsed[line[0...colon].strip] = line[(colon + 1)..].strip
          end
        end
      end

      client_headers = OpenAI::Internal::Util.normalized_headers(default_headers.to_h)
      unless provider_runtime.nil?
        provider_runtime.authentication_headers.each { client_headers.delete(_1) }
      end

      headers = OpenAI::Internal::Util.normalized_headers(parsed, headers, client_headers)

      if workload_identity.nil?
        @api_key = api_key&.to_s
        @workload_identity_auth = nil
      else
        @api_key = WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER
        token_exchange = if x509_identity
          OpenAI::Auth::X509TokenExchange.new(workload_identity, transport: http_client)
        end

        @workload_identity_auth = OpenAI::Auth::WorkloadIdentityAuth.new(
          workload_identity,
          organization&.to_s,
          token_exchange_url: if x509_identity
            "#{OpenAI::Auth::X509Transport::ISSUER_ORIGIN}/oauth/token"
          else
            OpenAI::Auth::WorkloadIdentityAuth::DEFAULT_TOKEN_EXCHANGE_URL
          end,
          token_exchange: token_exchange
        )
      end

      @admin_api_key = admin_api_key&.to_s
      @webhook_secret = webhook_secret&.to_s
      @provider_runtime = provider_runtime

      super(
        base_url: base_url,
        timeout: timeout,
        max_retries: max_retries,
        initial_retry_delay: initial_retry_delay,
        max_retry_delay: max_retry_delay,
        headers: headers,
        http_client: http_client,
        logger: logger,
        log_level: log_level,
        on_retry: on_retry
      )

      @copy_options = OpenAI::Internal::ClientOptions.capture(
        api_key: api_key,
        admin_api_key: @admin_api_key,
        workload_identity: workload_identity,
        organization: @organization,
        project: @project,
        webhook_secret: @webhook_secret,
        provider: provider,
        base_url: provider.nil? ? self.base_url.to_s : nil,
        default_headers: OpenAI::Internal::Util.normalized_headers(parsed, client_headers),
        max_retries: self.max_retries(),
        timeout: self.timeout(),
        initial_retry_delay: self.initial_retry_delay(),
        max_retry_delay: self.max_retry_delay(),
        http_client: requester,
        logger: self.logger(),
        log_level: self.log_level(),
        on_retry: self.on_retry()
      )

      @completions = OpenAI::Resources::Completions.new(client: self)
      @chat = OpenAI::Resources::Chat.new(client: self)
      @embeddings = OpenAI::Resources::Embeddings.new(client: self)
      @files = OpenAI::Resources::Files.new(client: self)
      @images = OpenAI::Resources::Images.new(client: self)
      @content_provenance_checks = OpenAI::Resources::ContentProvenanceChecks.new(client: self)
      @audio = OpenAI::Resources::Audio.new(client: self)
      @moderations = OpenAI::Resources::Moderations.new(client: self)
      @models = OpenAI::Resources::Models.new(client: self)
      @fine_tuning = OpenAI::Resources::FineTuning.new(client: self)
      @graders = OpenAI::Resources::Graders.new(client: self)
      @vector_stores = OpenAI::Resources::VectorStores.new(client: self)
      @webhooks = OpenAI::Resources::Webhooks.new(client: self)
      @beta = OpenAI::Resources::Beta.new(client: self)
      @batches = OpenAI::Resources::Batches.new(client: self)
      @uploads = OpenAI::Resources::Uploads.new(client: self)
      @admin = OpenAI::Resources::Admin.new(client: self)
      @responses = OpenAI::Resources::Responses.new(client: self)
      @realtime = OpenAI::Resources::Realtime.new(client: self)
      @conversations = OpenAI::Resources::Conversations.new(client: self)
      @evals = OpenAI::Resources::Evals.new(client: self)
      @containers = OpenAI::Resources::Containers.new(client: self)
      @skills = OpenAI::Resources::Skills.new(client: self)
      @videos = OpenAI::Resources::Videos.new(client: self)
    end
  end
end

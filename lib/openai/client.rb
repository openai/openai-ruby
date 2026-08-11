# frozen_string_literal: true

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

    # Optional base URL used for WebSocket connections.
    #
    # @return [URI::Generic, nil]
    attr_reader :websocket_base_url

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
      headers = {bearer_auth:, admin_api_key_auth:}.slice(*enabled_security.keys).values.reduce({}, :merge)
      if headers.empty? && enabled_security.any?
        raise ArgumentError,
              "Could not resolve authentication method. Expected either api_key or admin_api_key to be set."
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

    # Build a fully authenticated Realtime WebSocket handshake request. Realtime
    # transports use this boundary so provider authentication and request options stay
    # consistent with ordinary SDK requests.
    #
    # @api private
    #
    # @param path [String]
    # @param query [Hash{String=>String}]
    # @param options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
    #
    # @return [Hash{Symbol=>Object}]
    def realtime_connection_request(path:, query:, options: nil)
      if @provider_runtime && @provider_runtime.name != "azure"
        raise OpenAI::Errors::Error,
              "Realtime WebSocket connections are not supported by the #{@provider_runtime.name} provider."
      end

      opts = options.to_h
      OpenAI::RequestOptions.validate!(opts)
      request = build_request(
        {
          method: :get,
          path: path,
          query: query,
          security: {bearer_auth: true}
        },
        opts
      )

      workload_identity_header = "Bearer #{WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
      if @workload_identity_auth && request.fetch(:headers)["authorization"] == workload_identity_header
        token = @workload_identity_auth.get_token
        request = request.merge(
          headers: request.fetch(:headers).merge("authorization" => "Bearer #{token}")
        )
      end

      request = prepare_request(request, redirect_count: 0, retry_count: 0)
      if @websocket_base_url
        url = OpenAI::Internal::Util.join_parsed_uri(
          OpenAI::Internal::Util.parse_uri(@websocket_base_url.to_s),
          {path: OpenAI::Internal::Util.interpolate_path(path)}
        )
        url.query = request.fetch(:url).query
        request = request.merge(url: url)
      end

      url = request.fetch(:url).dup
      url.scheme = {"http" => "ws", "https" => "wss"}.fetch(url.scheme, url.scheme)
      headers = request.fetch(:headers).except("accept", "content-type")
      request.merge(url: url, headers: headers)
    end

    # @api private
    #
    # @param value [String, nil]
    # @return [URI::Generic, nil]
    private def parse_websocket_base_url(value)
      return if value.nil?

      uri = URI(value)
      valid_scheme = %w[http https ws wss].include?(uri.scheme)
      ambiguous_component = uri.userinfo || uri.query || uri.fragment
      unless uri.absolute? && uri.host && valid_scheme && !ambiguous_component
        message =
          "`websocket_base_url` must be an absolute HTTP or WebSocket URL " \
          "without credentials, query, or fragment"
        raise ArgumentError, message
      end
      uri
    rescue URI::Error => e
      raise ArgumentError, "`websocket_base_url` is not a valid URL", cause: e
    end

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`.
    #   Mutually exclusive with `workload_identity`.
    #

    # @api private
    private def prepare_request(request, redirect_count:, retry_count:)
      request = prepare_workload_identity_request(request) if workload_identity_request?(request)
      preparer = @provider_runtime&.prepare_request
      return super(request, redirect_count: redirect_count, retry_count: retry_count) unless preparer
      preparer.call(request)
    end

    # @api private
    private def send_request(request, redirect_count:, retry_count:, send_retry_header:)
      return super unless workload_identity_request?(request)

      deadline = request[:timeout]&.then { OpenAI::Internal::Util.monotonic_secs + _1 }
      request = request.merge(workload_identity_deadline: deadline)

      begin
        super(
          request,
          redirect_count: redirect_count,
          retry_count: retry_count,
          send_retry_header: send_retry_header
        )
      rescue OpenAI::Errors::AuthenticationError
        raise unless retry_count.zero? && request_replayable?(request)
        @workload_identity_auth.invalidate_token

        super(
          request,
          redirect_count: redirect_count,
          retry_count: retry_count + 1,
          send_retry_header: send_retry_header
        )
      end
    end

    private def workload_identity_request?(request)
      return false unless @workload_identity_auth

      expected = "Bearer #{WORKLOAD_IDENTITY_API_KEY_PLACEHOLDER}"
      request[:headers]["authorization"] == expected
    end

    private def prepare_workload_identity_request(request)
      deadline = request[:workload_identity_deadline]
      token = @workload_identity_auth.get_token(deadline: deadline)
      updated_headers = request[:headers].merge("authorization" => "Bearer #{token}")
      request_with_remaining_timeout(
        request.except(:workload_identity_deadline).merge(headers: updated_headers),
        deadline
      )
    rescue Timeout::Error => e
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
      self.class.new(**OpenAI::Internal::ClientOptions.copy(@copy_options, overrides))
    end

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`.
    #   Mutually exclusive with `workload_identity`.
    #
    # @param admin_api_key [String, nil] Defaults to `ENV["OPENAI_ADMIN_KEY"]`
    #
    # @param workload_identity [OpenAI::Auth::WorkloadIdentity, nil]
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
    # @param default_headers [Hash{String=>String, nil}, nil] Extra headers to send
    #   with every request. Explicit values override `ENV["OPENAI_CUSTOM_HEADERS"]`.
    #
    # @param websocket_base_url [String, nil] Override the base URL for WebSocket
    #   connections. The HTTP base URL is used when omitted.
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
      default_headers: nil,
      websocket_base_url: nil,
      max_retries: self.class::DEFAULT_MAX_RETRIES,
      timeout: self.class::DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: self.class::DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: self.class::DEFAULT_MAX_RETRY_DELAY,
      http_client: nil,
      logger: nil,
      log_level: nil,
      on_retry: nil
    )
      provider_runtime = nil
      unless provider.nil?
        provider_name = OpenAI::Internal::Provider.name(provider)
        conflicts = {
          api_key: api_key,
          admin_api_key: admin_api_key,
          workload_identity: workload_identity,
          base_url: base_url,
          websocket_base_url: websocket_base_url
        }.filter_map do |name, value|
          name unless value.equal?(OpenAI::Internal::OMIT) || value.nil?
        end
        unless conflicts.empty?
          formatted = conflicts.map { "`#{_1}`" }.join(", ")
          message =
            "`provider` cannot be combined with top-level #{formatted}. Move provider " \
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
      base_url ||= "https://api.openai.com/v1"

      if !api_key.nil? && !workload_identity.nil?
        raise ArgumentError, "`api_key` and `workload_identity` are mutually exclusive"
      end

      if provider_runtime.nil? && api_key.nil? && admin_api_key.nil? && workload_identity.nil?
        raise ArgumentError,
              "Missing credentials. Please pass an `api_key`, `workload_identity`, `admin_api_key`, or set the `OPENAI_API_KEY` or `OPENAI_ADMIN_KEY` environment variable."
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
        @workload_identity_auth = OpenAI::Auth::WorkloadIdentityAuth.new(
          workload_identity,
          organization&.to_s
        )
      end
      @admin_api_key = admin_api_key&.to_s
      @webhook_secret = webhook_secret&.to_s
      @provider_runtime = provider_runtime
      @websocket_base_url = parse_websocket_base_url(websocket_base_url)

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
        max_retries: self.max_retries,
        timeout: self.timeout,
        initial_retry_delay: self.initial_retry_delay,
        max_retry_delay: self.max_retry_delay,
        http_client: requester,
        logger: self.logger,
        log_level: self.log_level,
        on_retry: self.on_retry
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

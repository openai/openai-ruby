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
      headers = {bearer_auth:, admin_api_key_auth:}.slice(*security.keys).values.reduce({}, :merge)
      if headers.empty? && security.any? { |_, enabled| enabled }
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

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`.
    #   Mutually exclusive with `workload_identity`.
    #

    # @api private
    private def request_replayable?(request)
      body = request[:body]
      return true if body.nil? || body.is_a?(String)
      return false if body.respond_to?(:read)
      true
    end

    # @api private
    private def send_request(request, redirect_count:, retry_count:, send_retry_header:)
      return super unless @workload_identity_auth

      token = @workload_identity_auth.get_token
      updated_headers = request[:headers].merge("authorization" => "Bearer #{token}")
      updated_request = request.merge(headers: updated_headers)

      begin
        super(updated_request, redirect_count: redirect_count, retry_count: retry_count, send_retry_header: send_retry_header)
      rescue OpenAI::Errors::AuthenticationError
        raise unless retry_count.zero? && request_replayable?(request)
        @workload_identity_auth.invalidate_token

        fresh_token = @workload_identity_auth.get_token
        refreshed_headers = request[:headers].merge("authorization" => "Bearer #{fresh_token}")
        refreshed_request = request.merge(headers: refreshed_headers)

        super(refreshed_request, redirect_count: redirect_count, retry_count: retry_count + 1, send_retry_header: send_retry_header)
      end
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
    # @param base_url [String, nil] Override the default base URL for the API, e.g.,
    # `"https://api.example.com/v2/"`. Defaults to `ENV["OPENAI_BASE_URL"]`
    #
    # @param max_retries [Integer] Max number of retries to attempt after a failed retryable request.
    #
    # @param timeout [Float]
    #
    # @param initial_retry_delay [Float]
    #
    # @param max_retry_delay [Float]
    def initialize(
      api_key: ENV["OPENAI_API_KEY"],
      admin_api_key: ENV["OPENAI_ADMIN_KEY"],
      workload_identity: nil,
      organization: ENV["OPENAI_ORG_ID"],
      project: ENV["OPENAI_PROJECT_ID"],
      webhook_secret: ENV["OPENAI_WEBHOOK_SECRET"],
      base_url: ENV["OPENAI_BASE_URL"],
      max_retries: self.class::DEFAULT_MAX_RETRIES,
      timeout: self.class::DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: self.class::DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: self.class::DEFAULT_MAX_RETRY_DELAY
    )
      base_url ||= "https://api.openai.com/v1"

      if !api_key.nil? && !workload_identity.nil?
        raise ArgumentError, "`api_key` and `workload_identity` are mutually exclusive"
      end

      if api_key.nil? && admin_api_key.nil? && workload_identity.nil?
        raise ArgumentError,
              "Missing credentials. Please pass an `api_key`, `workload_identity`, `admin_api_key`, or set the `OPENAI_API_KEY` or `OPENAI_ADMIN_KEY` environment variable."
      end

      headers = {
        "openai-organization" => (@organization = organization&.to_s),
        "openai-project" => (@project = project&.to_s)
      }
      custom_headers_env = ENV["OPENAI_CUSTOM_HEADERS"]
      unless custom_headers_env.nil?
        parsed = {}
        custom_headers_env.split("\n").each do |line|
          colon = line.index(":")
          unless colon.nil?
            parsed[line[0...colon].strip] = line[(colon + 1)..].strip
          end
        end
        headers = parsed.merge(headers)
      end

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

      super(
        base_url: base_url,
        timeout: timeout,
        max_retries: max_retries,
        initial_retry_delay: initial_retry_delay,
        max_retry_delay: max_retry_delay,
        headers: headers
      )

      @completions = OpenAI::Resources::Completions.new(client: self)
      @chat = OpenAI::Resources::Chat.new(client: self)
      @embeddings = OpenAI::Resources::Embeddings.new(client: self)
      @files = OpenAI::Resources::Files.new(client: self)
      @images = OpenAI::Resources::Images.new(client: self)
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

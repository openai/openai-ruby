# frozen_string_literal: true

module OpenAI
  class Client < OpenAI::Transport::BaseClient
    # Default max number of retries to attempt after a failed retryable request.
    DEFAULT_MAX_RETRIES = 2

    # Default per-request timeout.
    DEFAULT_TIMEOUT_IN_SECONDS = 600.0

    # Default initial retry delay in seconds.
    # Overall delay is calculated using exponential backoff + jitter.
    DEFAULT_INITIAL_RETRY_DELAY = 0.5

    # Default max retry delay in seconds.
    DEFAULT_MAX_RETRY_DELAY = 8.0

    # @return [String]
    attr_reader :api_key

    # @return [String, nil]
    attr_reader :organization

    # @return [String, nil]
    attr_reader :project

    # @return [OpenAI::Resources::Completions]
    attr_reader :completions

    # @return [OpenAI::Resources::Chat]
    attr_reader :chat

    # @return [OpenAI::Resources::Embeddings]
    attr_reader :embeddings

    # @return [OpenAI::Resources::Files]
    attr_reader :files

    # @return [OpenAI::Resources::Images]
    attr_reader :images

    # @return [OpenAI::Resources::Audio]
    attr_reader :audio

    # @return [OpenAI::Resources::Moderations]
    attr_reader :moderations

    # @return [OpenAI::Resources::Models]
    attr_reader :models

    # @return [OpenAI::Resources::FineTuning]
    attr_reader :fine_tuning

    # @return [OpenAI::Resources::VectorStores]
    attr_reader :vector_stores

    # @return [OpenAI::Resources::Beta]
    attr_reader :beta

    # @return [OpenAI::Resources::Batches]
    attr_reader :batches

    # @return [OpenAI::Resources::Uploads]
    attr_reader :uploads

    # @return [OpenAI::Resources::Responses]
    attr_reader :responses

    # @api private
    #
    # @return [Hash{String=>String}]
    private def auth_headers
      return {} if @api_key.nil?

      {"authorization" => "Bearer #{@api_key}"}
    end

    # Creates and returns a new client for interacting with the API.
    #
    # @param api_key [String, nil] Defaults to `ENV["OPENAI_API_KEY"]`
    #
    # @param organization [String, nil] Defaults to `ENV["OPENAI_ORG_ID"]`
    #
    # @param project [String, nil] Defaults to `ENV["OPENAI_PROJECT_ID"]`
    #
    # @param base_url [String, nil] Override the default base URL for the API, e.g., `"https://api.example.com/v2/"`
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
      organization: ENV["OPENAI_ORG_ID"],
      project: ENV["OPENAI_PROJECT_ID"],
      base_url: nil,
      max_retries: DEFAULT_MAX_RETRIES,
      timeout: DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: DEFAULT_MAX_RETRY_DELAY
    )
      base_url ||= "https://api.openai.com/v1"

      if api_key.nil?
        raise ArgumentError.new("api_key is required, and can be set via environ: \"OPENAI_API_KEY\"")
      end

      headers = {
        "openai-organization" => (@organization = organization&.to_s),
        "openai-project" => (@project = project&.to_s)
      }

      @api_key = api_key.to_s

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
      @vector_stores = OpenAI::Resources::VectorStores.new(client: self)
      @beta = OpenAI::Resources::Beta.new(client: self)
      @batches = OpenAI::Resources::Batches.new(client: self)
      @uploads = OpenAI::Resources::Uploads.new(client: self)
      @responses = OpenAI::Resources::Responses.new(client: self)
    end
  end
end

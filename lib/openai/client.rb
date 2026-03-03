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

    # @return [String]
    attr_reader :api_key

    # @return [String, nil]
    attr_reader :organization

    # @return [String, nil]
    attr_reader :project

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
      organization: ENV["OPENAI_ORG_ID"],
      project: ENV["OPENAI_PROJECT_ID"],
      base_url: ENV["OPENAI_BASE_URL"],
      max_retries: self.class::DEFAULT_MAX_RETRIES,
      timeout: self.class::DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: self.class::DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: self.class::DEFAULT_MAX_RETRY_DELAY
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
      @graders = OpenAI::Resources::Graders.new(client: self)
      @vector_stores = OpenAI::Resources::VectorStores.new(client: self)
      @webhooks = OpenAI::Resources::Webhooks.new(client: self)
      @beta = OpenAI::Resources::Beta.new(client: self)
      @batches = OpenAI::Resources::Batches.new(client: self)
      @uploads = OpenAI::Resources::Uploads.new(client: self)
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

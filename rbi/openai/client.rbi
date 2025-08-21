# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    DEFAULT_MAX_RETRIES = 2

    DEFAULT_TIMEOUT_IN_SECONDS = T.let(600.0, Float)

    DEFAULT_INITIAL_RETRY_DELAY = T.let(0.5, Float)

    DEFAULT_MAX_RETRY_DELAY = T.let(8.0, Float)

    sig { returns(String) }
    attr_reader :api_key

    sig { returns(T.nilable(String)) }
    attr_reader :organization

    sig { returns(T.nilable(String)) }
    attr_reader :project

    sig { returns(OpenAI::Resources::Completions) }
    attr_reader :completions

    sig { returns(OpenAI::Resources::Chat) }
    attr_reader :chat

    sig { returns(OpenAI::Resources::Embeddings) }
    attr_reader :embeddings

    sig { returns(OpenAI::Resources::Files) }
    attr_reader :files

    sig { returns(OpenAI::Resources::Images) }
    attr_reader :images

    sig { returns(OpenAI::Resources::Audio) }
    attr_reader :audio

    sig { returns(OpenAI::Resources::Moderations) }
    attr_reader :moderations

    sig { returns(OpenAI::Resources::Models) }
    attr_reader :models

    sig { returns(OpenAI::Resources::FineTuning) }
    attr_reader :fine_tuning

    sig { returns(OpenAI::Resources::Graders) }
    attr_reader :graders

    sig { returns(OpenAI::Resources::VectorStores) }
    attr_reader :vector_stores

    sig { returns(OpenAI::Resources::Webhooks) }
    attr_reader :webhooks

    sig { returns(OpenAI::Resources::Beta) }
    attr_reader :beta

    sig { returns(OpenAI::Resources::Batches) }
    attr_reader :batches

    sig { returns(OpenAI::Resources::Uploads) }
    attr_reader :uploads

    sig { returns(OpenAI::Resources::Responses) }
    attr_reader :responses

    sig { returns(OpenAI::Resources::Conversations) }
    attr_reader :conversations

    sig { returns(OpenAI::Resources::Evals) }
    attr_reader :evals

    sig { returns(OpenAI::Resources::Containers) }
    attr_reader :containers

    # @api private
    sig { override.returns(T::Hash[String, String]) }
    private def auth_headers
    end

    # Creates and returns a new client for interacting with the API.
    sig do
      params(
        api_key: T.nilable(String),
        organization: T.nilable(String),
        project: T.nilable(String),
        base_url: T.nilable(String),
        max_retries: Integer,
        timeout: Float,
        initial_retry_delay: Float,
        max_retry_delay: Float
      ).returns(T.attached_class)
    end
    def self.new(
      # Defaults to `ENV["OPENAI_API_KEY"]`
      api_key: ENV["OPENAI_API_KEY"],
      # Defaults to `ENV["OPENAI_ORG_ID"]`
      organization: ENV["OPENAI_ORG_ID"],
      # Defaults to `ENV["OPENAI_PROJECT_ID"]`
      project: ENV["OPENAI_PROJECT_ID"],
      # Override the default base URL for the API, e.g.,
      # `"https://api.example.com/v2/"`. Defaults to `ENV["OPENAI_BASE_URL"]`
      base_url: ENV["OPENAI_BASE_URL"],
      # Max number of retries to attempt after a failed retryable request.
      max_retries: OpenAI::Client::DEFAULT_MAX_RETRIES,
      timeout: OpenAI::Client::DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: OpenAI::Client::DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: OpenAI::Client::DEFAULT_MAX_RETRY_DELAY
    )
    end
  end
end

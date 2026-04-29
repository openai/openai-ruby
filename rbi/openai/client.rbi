# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    DEFAULT_MAX_RETRIES = 2

    DEFAULT_TIMEOUT_IN_SECONDS = T.let(600.0, Float)

    DEFAULT_INITIAL_RETRY_DELAY = T.let(0.5, Float)

    DEFAULT_MAX_RETRY_DELAY = T.let(8.0, Float)

    sig { returns(T.nilable(String)) }
    attr_reader :api_key

    sig { returns(T.nilable(String)) }
    attr_reader :admin_api_key

    sig { returns(T.nilable(String)) }
    attr_reader :organization

    sig { returns(T.nilable(String)) }
    attr_reader :project

    sig { returns(T.nilable(String)) }
    attr_reader :webhook_secret

    # Given a prompt, the model will return one or more predicted completions, and can
    # also return the probabilities of alternative tokens at each position.
    sig { returns(OpenAI::Resources::Completions) }
    attr_reader :completions

    sig { returns(OpenAI::Resources::Chat) }
    attr_reader :chat

    # Get a vector representation of a given input that can be easily consumed by
    # machine learning models and algorithms.
    sig { returns(OpenAI::Resources::Embeddings) }
    attr_reader :embeddings

    # Files are used to upload documents that can be used with features like
    # Assistants and Fine-tuning.
    sig { returns(OpenAI::Resources::Files) }
    attr_reader :files

    # Given a prompt and/or an input image, the model will generate a new image.
    sig { returns(OpenAI::Resources::Images) }
    attr_reader :images

    sig { returns(OpenAI::Resources::Audio) }
    attr_reader :audio

    # Given text and/or image inputs, classifies if those inputs are potentially
    # harmful.
    sig { returns(OpenAI::Resources::Moderations) }
    attr_reader :moderations

    # List and describe the various models available in the API.
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

    # Create large batches of API requests to run asynchronously.
    sig { returns(OpenAI::Resources::Batches) }
    attr_reader :batches

    # Use Uploads to upload large files in multiple parts.
    sig { returns(OpenAI::Resources::Uploads) }
    attr_reader :uploads

    sig { returns(OpenAI::Resources::Admin) }
    attr_reader :admin

    sig { returns(OpenAI::Resources::Responses) }
    attr_reader :responses

    sig { returns(OpenAI::Resources::Realtime) }
    attr_reader :realtime

    # Manage conversations and conversation items.
    sig { returns(OpenAI::Resources::Conversations) }
    attr_reader :conversations

    # Manage and run evals in the OpenAI platform.
    sig { returns(OpenAI::Resources::Evals) }
    attr_reader :evals

    sig { returns(OpenAI::Resources::Containers) }
    attr_reader :containers

    sig { returns(OpenAI::Resources::Skills) }
    attr_reader :skills

    sig { returns(OpenAI::Resources::Videos) }
    attr_reader :videos

    # @api private
    sig do
      override
        .params(
          security: {
            bearer_auth: T::Boolean,
            admin_api_key_auth: T::Boolean
          }
        )
        .returns(T::Hash[String, String])
    end
    private def auth_headers(security:)
    end

    # @api private
    sig { returns(T::Hash[String, String]) }
    private def bearer_auth
    end

    # @api private
    sig { returns(T::Hash[String, String]) }
    private def admin_api_key_auth
    end

    # Creates and returns a new client for interacting with the API.
    sig do
      params(
        api_key: T.nilable(String),
        admin_api_key: T.nilable(String),
        organization: T.nilable(String),
        project: T.nilable(String),
        webhook_secret: T.nilable(String),
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
      # Defaults to `ENV["OPENAI_ADMIN_KEY"]`
      admin_api_key: ENV["OPENAI_ADMIN_KEY"],
      # Defaults to `ENV["OPENAI_ORG_ID"]`
      organization: ENV["OPENAI_ORG_ID"],
      # Defaults to `ENV["OPENAI_PROJECT_ID"]`
      project: ENV["OPENAI_PROJECT_ID"],
      # Defaults to `ENV["OPENAI_WEBHOOK_SECRET"]`
      webhook_secret: ENV["OPENAI_WEBHOOK_SECRET"],
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

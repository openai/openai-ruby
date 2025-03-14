# typed: strong

module OpenAI
  class Client < OpenAI::BaseClient
    DEFAULT_MAX_RETRIES = 2

    DEFAULT_TIMEOUT_IN_SECONDS = T.let(600.0, Float)

    DEFAULT_INITIAL_RETRY_DELAY = T.let(0.5, Float)

    DEFAULT_MAX_RETRY_DELAY = T.let(8.0, Float)

    sig { returns(String) }
    def api_key
    end

    sig { returns(T.nilable(String)) }
    def organization
    end

    sig { returns(T.nilable(String)) }
    def project
    end

    sig { returns(OpenAI::Resources::Completions) }
    def completions
    end

    sig { returns(OpenAI::Resources::Chat) }
    def chat
    end

    sig { returns(OpenAI::Resources::Embeddings) }
    def embeddings
    end

    sig { returns(OpenAI::Resources::Files) }
    def files
    end

    sig { returns(OpenAI::Resources::Images) }
    def images
    end

    sig { returns(OpenAI::Resources::Audio) }
    def audio
    end

    sig { returns(OpenAI::Resources::Moderations) }
    def moderations
    end

    sig { returns(OpenAI::Resources::Models) }
    def models
    end

    sig { returns(OpenAI::Resources::FineTuning) }
    def fine_tuning
    end

    sig { returns(OpenAI::Resources::Beta) }
    def beta
    end

    sig { returns(OpenAI::Resources::Batches) }
    def batches
    end

    sig { returns(OpenAI::Resources::Uploads) }
    def uploads
    end

    # @api private
    sig { override.returns(T::Hash[String, String]) }
    private def auth_headers
    end

    # Creates and returns a new client for interacting with the API.
    sig do
      params(
        base_url: T.nilable(String),
        api_key: T.nilable(String),
        organization: T.nilable(String),
        project: T.nilable(String),
        max_retries: Integer,
        timeout: Float,
        initial_retry_delay: Float,
        max_retry_delay: Float
      )
        .returns(T.attached_class)
    end
    def self.new(
      # Override the default base URL for the API, e.g., `"https://api.example.com/v2/"`
      base_url: nil,
      # Defaults to `ENV["OPENAI_API_KEY"]`
      api_key: ENV["OPENAI_API_KEY"],
      # Defaults to `ENV["OPENAI_ORG_ID"]`
      organization: ENV["OPENAI_ORG_ID"],
      # Defaults to `ENV["OPENAI_PROJECT_ID"]`
      project: ENV["OPENAI_PROJECT_ID"],
      # Max number of retries to attempt after a failed retryable request.
      max_retries: DEFAULT_MAX_RETRIES,
      timeout: DEFAULT_TIMEOUT_IN_SECONDS,
      initial_retry_delay: DEFAULT_INITIAL_RETRY_DELAY,
      max_retry_delay: DEFAULT_MAX_RETRY_DELAY
    )
    end
  end
end

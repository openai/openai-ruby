# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # @api private
    sig do
      override
        .params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          redirect_count: Integer,
          retry_count: Integer
        )
        .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
    end
    private def prepare_request(request, redirect_count:, retry_count:)
    end

    # @api private
    sig do
      override
        .params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          original_request: OpenAI::Internal::Transport::BaseClient::RequestInput
        )
        .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
    end
    private def validate_prepared_request(request, original_request:)
    end

    # @api private
    sig do
      override
        .params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          delay: Float
        )
        .void
    end
    private def validate_retry_delay!(request, delay:)
    end

    # @api private
    sig { params(identity: T.untyped).returns(T::Boolean) }
    private def x509_identity?(identity)
    end

    # @api private
    sig { params(transport: T.untyped).returns(T::Boolean) }
    private def x509_transport?(transport)
    end

    # @api private
    sig { params(options: T::Hash[Symbol, T.untyped]).returns(T.self_type) }
    private def copy_with_workload_identity_auth(options)
    end

    # @api private
    sig { params(authenticator: OpenAI::Auth::WorkloadIdentityAuth).void }
    def adopt_workload_identity_auth!(authenticator)
    end

    # Returns a new client with the supplied options overridden.
    sig do
      params(
        api_key: T.nilable(String),
        admin_api_key: T.nilable(String),
        workload_identity: T.nilable(T.any(OpenAI::Auth::WorkloadIdentity, OpenAI::Auth::X509WorkloadIdentity)),
        organization: T.nilable(String),
        project: T.nilable(String),
        webhook_secret: T.nilable(String),
        provider: T.nilable(OpenAI::Provider),
        base_url: T.nilable(String),
        data_residency: T.nilable(T.any(Symbol, String)),
        default_headers: T.nilable(T::Hash[String, T.nilable(String)]),
        max_retries: Integer,
        timeout: T.nilable(Float),
        initial_retry_delay: Float,
        max_retry_delay: Float,
        http_client: T.untyped,
        logger: T.untyped,
        log_level: T.nilable(T.any(Symbol, String)),
        on_retry: T.nilable(T.proc.params(event: OpenAI::RetryEvent).void)
      )
        .returns(T.self_type)
    end
    def with_options(
      api_key: T.unsafe(nil),
      admin_api_key: T.unsafe(nil),
      workload_identity: T.unsafe(nil),
      organization: T.unsafe(nil),
      project: T.unsafe(nil),
      webhook_secret: T.unsafe(nil),
      provider: T.unsafe(nil),
      base_url: T.unsafe(nil),
      data_residency: T.unsafe(nil),
      default_headers: T.unsafe(nil),
      max_retries: T.unsafe(nil),
      timeout: T.unsafe(nil),
      initial_retry_delay: T.unsafe(nil),
      max_retry_delay: T.unsafe(nil),
      http_client: T.unsafe(nil),
      logger: T.unsafe(nil),
      log_level: T.unsafe(nil),
      on_retry: T.unsafe(nil)
    )
    end
  end
end

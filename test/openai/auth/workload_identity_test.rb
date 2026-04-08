# frozen_string_literal: true

require_relative "../test_helper"

class WorkloadIdentityTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @token_path = File.join(Dir.tmpdir, "test_k8s_token_#{SecureRandom.hex}")
  end

  def teardown
    FileUtils.rm_f(@token_path)
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_kubernetes_provider_success
    File.write(@token_path, "k8s-jwt-token\n")

    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)
    assert_equal(OpenAI::Auth::TokenType::JWT, provider.token_type)
    assert_equal("k8s-jwt-token", provider.get_token)
  end

  def test_kubernetes_provider_missing_file
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/nonexistent/path/#{SecureRandom.hex}"
    )

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("kubernetes", error.provider)
    assert_match(/Failed to read/, error.message)
    assert_kind_of(Errno::ENOENT, error.cause)
  end

  def test_azure_imds_provider_success
    stub_request(:get, "http://169.254.169.254/metadata/identity/oauth2/token")
      .with(
        query: hash_including("api-version" => "2018-02-01", "resource" => "https://management.azure.com/"),
        headers: {"Metadata" => "true"}
      )
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "azure-id-token", "expires_in" => 3600}),
        headers: {"Content-Type" => "application/json"}
      )

    provider = OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new

    assert_equal(OpenAI::Auth::TokenType::JWT, provider.token_type)
    assert_equal("azure-id-token", provider.get_token)
  end

  def test_azure_imds_provider_error
    stub_request(:get, "http://169.254.169.254/metadata/identity/oauth2/token")
      .with(query: hash_including("api-version" => "2018-02-01", "resource" => "https://management.azure.com/"))
      .to_return(status: 500, body: "Internal Server Error")

    provider = OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("azure-imds", error.provider)
    assert_match(/Azure IMDS returned 500/, error.message)
  end

  def test_gcp_metadata_provider_success
    stub_request(:get, "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity")
      .with(
        query: hash_including("audience" => "https://api.openai.com/v1"),
        headers: {"Metadata-Flavor" => "Google"}
      )
      .to_return(status: 200, body: "gcp-jwt-token")

    provider = OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new

    assert_equal(OpenAI::Auth::TokenType::ID, provider.token_type)
    assert_equal("gcp-jwt-token", provider.get_token)
  end

  def test_gcp_metadata_provider_error
    stub_request(:get, "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity")
      .with(query: hash_including("audience" => "https://api.openai.com/v1"))
      .to_return(status: 404, body: "Not Found")

    provider = OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("gcp-metadata", error.provider)
    assert_match(/GCP Metadata Server returned 404/, error.message)
  end

  def test_workload_identity_auth_token_exchange
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .with(
        body: hash_including(
          "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
          "client_id" => "test-client",
          "subject_token" => "k8s-jwt-token",
          "subject_token_type" => "urn:ietf:params:oauth:token-type:jwt",
          "identity_provider_id" => "idp-123",
          "service_account_id" => "sa-456"
        )
      )
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "oauth-access-token", "expires_in" => 3600})
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "test-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
    token = auth.get_token

    assert_equal("oauth-access-token", token)
  end

  def test_workload_identity_auth_oauth_error
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 401,
        body: JSON.generate(
          {
            "error" => "invalid_client",
            "error_description" => "Invalid client credentials"
          }
        )
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "bad-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")

    error = assert_raises(OpenAI::Errors::OAuthError) do
      auth.get_token
    end

    assert_equal(401, error.status)
    assert_equal("invalid_client", error.error_code)
    assert_match(/Invalid client credentials/, error.message)
  end

  def test_workload_identity_client_initialization
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)

    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "test-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    refute_nil(client.workload_identity_auth)
  end

  def test_workload_identity_mutually_exclusive_with_api_key
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "test-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(
        api_key: "my-api-key",
        workload_identity: config,
        organization: "org-123",
        project: "proj-456"
      )
    end

    assert_match(/mutually exclusive/, error.message)
  end

  def test_401_retry_with_token_invalidation
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(status: 200, body: JSON.generate({"access_token" => "first-token", "expires_in" => 3600}))
      .then
      .to_return(status: 200, body: JSON.generate({"access_token" => "second-token", "expires_in" => 3600}))

    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        {
          status: 401,
          body: JSON.generate({"error" => {"message" => "invalid_token"}}),
          headers: {"Content-Type" => "application/json"}
        },
        {
          status: 200,
          body: JSON.generate(
            {
              "id" => "chatcmpl-123",
              "choices" => [
                {
                  "finish_reason" => "stop",
                  "index" => 0,
                  "message" => {
                    "content" => "test response",
                    "role" => "assistant"
                  }
                }
              ],
              "created" => Time.now.to_i,
              "model" => "gpt-5.2",
              "object" => "chat.completion",
              "usage" => {
                "completion_tokens" => 10,
                "prompt_tokens" => 5,
                "total_tokens" => 15
              }
            }
          ),
          headers: {"Content-Type" => "application/json"}
        }
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "test-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    response = client.chat.completions.create(
      messages: [{role: "user", content: "test"}],
      model: "gpt-5.2"
    )

    assert_equal("chatcmpl-123", response.id)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 2)
    assert_requested(:post, "http://localhost/chat/completions", times: 2)
  end

  def test_workload_identity_token_caching
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path)

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "cached-token", "expires_in" => 3600})
      )

    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        body: JSON.generate(
          {
            "id" => "chatcmpl-123",
            "choices" => [
              {
                "finish_reason" => "stop",
                "index" => 0,
                "message" => {"content" => "test response", "role" => "assistant"}
              }
            ],
            "created" => Time.now.to_i,
            "model" => "gpt-5.2",
            "object" => "chat.completion",
            "usage" => {
              "completion_tokens" => 10,
              "prompt_tokens" => 5,
              "total_tokens" => 15
            }
          }
        ),
        headers: {"Content-Type" => "application/json"}
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      client_id: "test-client",
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    response1 = client.chat.completions.create(messages: [{role: "user", content: "test1"}], model: "gpt-5.2")
    response2 = client.chat.completions.create(messages: [{role: "user", content: "test2"}], model: "gpt-5.2")

    assert_equal("chatcmpl-123", response1.id)
    assert_equal("chatcmpl-123", response2.id)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 1)
    assert_requested(:post, "http://localhost/chat/completions", times: 2)
  end
end

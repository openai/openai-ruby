# frozen_string_literal: true

require "logger"
require "stringio"

require_relative "test_helper"

class OpenAI::Test::EnvironmentCredentialsTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  Vaults = OpenAI::Beta::Agents::Vaults
  CREATE_URL = "http://localhost/vaults/vault_test/credentials"
  CREDENTIAL_URL = "#{CREATE_URL}/credential_test".freeze

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def setup
    super
    @logs = StringIO.new
    @openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "fake-credential-api-key",
      max_retries: 0,
      logger: Logger.new(@logs),
      log_level: :debug
    )
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_create_with_limited_networking
    networking = {type: "limited", allowed_hosts: ["service.example.test"]}
    auth = {
      type: "environment_variable",
      secret_name: "SDK_TEST_KEY",
      secret_value: "fake-environment-secret",
      networking: networking
    }
    stub_request(:post, CREATE_URL)
      .with(
        body: {name: "Environment credential", auth: auth},
        headers: {"Authorization" => "Bearer fake-credential-api-key", "OpenAI-Beta" => "agents=v1"}
      )
      .to_return_json(body: credential_body(auth.except(:secret_value)))

    response = @openai.beta.agents.vaults.credentials.create(
      "vault_test",
      name: "Environment credential",
      auth: auth
    )

    assert_requested(:post, CREATE_URL, times: 1)
    assert_not_requested(:any, /service\.example\.test/)
    assert_instance_of(Vaults::CredentialAuth::EnvironmentVariable, response.auth)
    assert_instance_of(Vaults::CredentialNetworking::Limited, response.auth.networking)
    assert_equal(["service.example.test"], response.auth.networking.allowed_hosts)
    assert_equal("SDK_TEST_KEY", response.auth.secret_name)
    refute_includes(response.auth.to_h, :secret_value)
  end

  def test_create_accepts_typed_unrestricted_networking
    auth = Vaults::CredentialAuthCreateParam::EnvironmentVariable.new(
      secret_name: "SDK_TEST_KEY",
      secret_value: "fake-environment-secret",
      networking: Vaults::CredentialNetworkingParam::Unrestricted.new
    )
    metadata = {
      type: "environment_variable",
      secret_name: "SDK_TEST_KEY",
      networking: {type: "unrestricted"}
    }
    stub_request(:post, CREATE_URL)
      .with(body: {name: "Environment credential", auth: {**metadata, secret_value: "fake-environment-secret"}})
      .to_return_json(body: credential_body(metadata))

    response = @openai.beta.agents.vaults.credentials.create(
      "vault_test",
      name: "Environment credential",
      auth: auth
    )

    assert_requested(:post, CREATE_URL, times: 1)
    assert_instance_of(Vaults::CredentialAuth::EnvironmentVariable, response.auth)
    assert_instance_of(Vaults::CredentialNetworking::Unrestricted, response.auth.networking)
  end

  def test_rotation_sends_only_the_replacement_secret
    auth = Vaults::CredentialAuthRotateParam::EnvironmentVariable.new(
      secret_value: "fake-replacement-secret"
    )
    metadata = {
      type: "environment_variable",
      secret_name: "SDK_TEST_KEY",
      networking: {type: "limited", allowed_hosts: ["service.example.test"]}
    }
    stub_request(:post, CREDENTIAL_URL)
      .with(body: {auth: {type: "environment_variable", secret_value: "fake-replacement-secret"}})
      .to_return_json(body: credential_body(metadata))

    response = @openai.beta.agents.vaults.credentials.update(
      "credential_test",
      vault_id: "vault_test",
      auth: auth
    )

    assert_requested(:post, CREDENTIAL_URL, times: 1)
    assert_instance_of(Vaults::CredentialAuth::EnvironmentVariable, response.auth)
    assert_equal("SDK_TEST_KEY", response.auth.secret_name)
    assert_equal(["service.example.test"], response.auth.networking.allowed_hosts)
    assert_equal([:secret_value, :type], Vaults::CredentialAuthRotateParam::EnvironmentVariable.known_fields.keys.sort)
  end

  def test_retrieve_decodes_metadata_without_a_declared_secret_field
    metadata = {
      type: "environment_variable",
      secret_name: "SDK_TEST_KEY",
      networking: {type: "unrestricted"}
    }
    stub_request(:get, CREDENTIAL_URL).to_return_json(body: credential_body(metadata))

    response = @openai.beta.agents.vaults.credentials.retrieve("credential_test", vault_id: "vault_test")

    assert_requested(:get, CREDENTIAL_URL, times: 1)
    assert_instance_of(Vaults::CredentialAuth::EnvironmentVariable, response.auth)
    assert_instance_of(Vaults::CredentialNetworking::Unrestricted, response.auth.networking)
    assert_equal(
      [:networking, :secret_name, :type],
      Vaults::CredentialAuth::EnvironmentVariable.known_fields.keys.sort
    )
    assert_equal(
      [:networking, :secret_name, :secret_value, :type],
      Vaults::CredentialAuthCreateParam::EnvironmentVariable.known_fields.keys.sort
    )
    refute_includes(response.auth.to_h, :secret_value)
  end

  def test_existing_oauth_credentials_keep_their_wire_shape
    auth = {type: "mcp_oauth", access_token: "fake-oauth-token", mcp_server_url: "https://service.example.test/mcp"}
    stub_request(:post, CREATE_URL)
      .with(body: {name: "OAuth credential", auth: auth})
      .to_return_json(body: credential_body(auth.except(:access_token)))

    response = @openai.beta.agents.vaults.credentials.create(
      "vault_test",
      name: "OAuth credential",
      auth: auth
    )

    assert_requested(:post, CREATE_URL, times: 1)
    assert_instance_of(Vaults::CredentialAuth::McpOauth, response.auth)
    assert_equal("https://service.example.test/mcp", response.auth.mcp_server_url)
    refute_includes(response.auth.to_h, :access_token)
  end

  def test_existing_bearer_credentials_keep_their_wire_shape
    auth = {type: "static_bearer", token: "fake-mcp-token", mcp_server_url: "https://service.example.test/mcp"}
    stub_request(:post, CREATE_URL)
      .with(body: {name: "Bearer credential", auth: auth})
      .to_return_json(body: credential_body(auth.except(:token)))

    response = @openai.beta.agents.vaults.credentials.create(
      "vault_test",
      name: "Bearer credential",
      auth: auth
    )

    assert_requested(:post, CREATE_URL, times: 1)
    assert_instance_of(Vaults::CredentialAuth::StaticBearer, response.auth)
    assert_equal("https://service.example.test/mcp", response.auth.mcp_server_url)
    refute_includes(response.auth.to_h, :token)
  end

  def test_debug_diagnostics_redact_environment_secrets
    metadata = {
      type: "environment_variable",
      secret_name: "SDK_TEST_KEY",
      networking: {type: "unrestricted"}
    }
    stub_request(:post, CREATE_URL).to_return_json(body: credential_body(metadata))

    @openai.beta.agents.vaults.credentials.create(
      "vault_test",
      name: "Environment credential",
      auth: {**metadata, secret_value: "fake-environment-secret"}
    )

    assert_requested(:post, CREATE_URL, times: 1)
    assert_includes(@logs.string, "request started")
    assert_includes(@logs.string, "[REDACTED]")
    refute_includes(@logs.string, "fake-environment-secret")
    refute_includes(@logs.string, "fake-credential-api-key")
  end

  private def credential_body(auth)
    {
      id: "credential_test",
      auth: auth,
      created_at: 1_700_000_000,
      name: "Test credential",
      object: "vault.credential",
      updated_at: 1_700_000_000,
      vault_id: "vault_test"
    }
  end
end

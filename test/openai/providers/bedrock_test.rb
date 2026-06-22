# frozen_string_literal: true

require_relative "../test_helper"

require "aws-sdk-core"
require "fileutils"
require "tmpdir"

class OpenAI::Test::BedrockProviderTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  ENVIRONMENT_VARIABLES = %w[
    AWS_ACCESS_KEY_ID
    AWS_BEARER_TOKEN_BEDROCK
    AWS_BEDROCK_BASE_URL
    AWS_CONFIG_FILE
    AWS_DEFAULT_PROFILE
    AWS_DEFAULT_REGION
    AWS_EC2_METADATA_DISABLED
    AWS_PROFILE
    AWS_REGION
    AWS_SDK_CONFIG_OPT_OUT
    AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN
    AWS_SHARED_CREDENTIALS_FILE
    OPENAI_ADMIN_KEY
    OPENAI_API_KEY
    OPENAI_BASE_URL
    OPENAI_CUSTOM_HEADERS
    OPENAI_ORG_ID
    OPENAI_PROJECT_ID
  ].freeze

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @environment = ENVIRONMENT_VARIABLES.to_h { [_1, ENV[_1]] }
    ENVIRONMENT_VARIABLES.each { ENV.delete(_1) }
    @aws_dir = Dir.mktmpdir("openai-bedrock-test")
    ENV["AWS_SHARED_CREDENTIALS_FILE"] = File.join(@aws_dir, "credentials")
    ENV["AWS_CONFIG_FILE"] = File.join(@aws_dir, "config")
    ENV["AWS_EC2_METADATA_DISABLED"] = "true"
    File.write(ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"), "")
    File.write(ENV.fetch("AWS_CONFIG_FILE"), "")
    reset_shared_config
  end

  def teardown
    Thread.current.thread_variable_set(:time_now, nil)
    WebMock.reset!
    FileUtils.rm_rf(@aws_dir)
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    reset_shared_config
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_bearer_provider_owns_endpoint_and_authentication
    stub_request(:get, "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models")
      .to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    client.request({method: :get, path: "models"})

    assert_equal("https://bedrock-mantle.us-east-1.api.aws/openai/v1", client.base_url.to_s)
    assert_requested(:get, "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models") do |request|
      assert_equal("Bearer bedrock-token", request.headers["Authorization"])
    end
  end

  def test_provider_ignores_ambient_openai_configuration
    ENV["OPENAI_API_KEY"] = "openai-key"
    ENV["OPENAI_ADMIN_KEY"] = "openai-admin-key"
    ENV["OPENAI_BASE_URL"] = "https://api.example.com/v1"
    ENV["OPENAI_ORG_ID"] = "org-example"
    ENV["OPENAI_PROJECT_ID"] = "project-example"
    ENV["OPENAI_CUSTOM_HEADERS"] = "x-openai-custom: should-not-leak"
    url = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("Bearer bedrock-token", headers["authorization"])
      refute_includes(headers, "openai-organization")
      refute_includes(headers, "openai-project")
      refute_includes(headers, "x-openai-custom")
    end
  end

  def test_provider_rejects_top_level_authentication_and_routing
    provider = OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")

    error = assert_raises(OpenAI::Errors::Error) do
      OpenAI::Client.new(provider: provider, api_key: "openai-key", base_url: "https://example.com")
    end

    assert_match(/`api_key`, `base_url`/, error.message)
    assert_match(/`bedrock\(\.\.\.\)`/, error.message)
  end

  def test_default_chain_reads_the_aws_credentials_file
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "ignored-bearer-token"
    File.write(
      ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"),
      <<~INI
        [default]
        aws_access_key_id = file-access-key
        aws_secret_access_key = file-secret-key
        aws_session_token = file-session-token
      INI
    )
    url = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: nil),
      max_retries: 0
    )
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      assert_includes(request.headers.fetch("Authorization"), "Credential=file-access-key/")
      assert_equal("file-session-token", request.headers["X-Amz-Security-Token"])
    end
  end

  def test_default_chain_reports_missing_credentials
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: nil)
    )

    error = assert_raises(OpenAI::Errors::Error) do
      runtime.prepare_request.call(bedrock_request)
    end

    assert_equal(OpenAI::Providers::Bedrock::MISSING_CREDENTIALS_MESSAGE, error.message)
  end

  def test_named_profile_resolves_credentials_and_region_from_shared_config
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "ignored-bearer-token"
    File.write(
      ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"),
      <<~INI
        [engineering]
        aws_access_key_id = profile-access-key
        aws_secret_access_key = profile-secret-key
      INI
    )
    File.write(
      ENV.fetch("AWS_CONFIG_FILE"),
      <<~INI
        [profile engineering]
        region = us-west-2
      INI
    )
    reset_shared_config
    url = "https://bedrock-mantle.us-west-2.api.aws/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(provider: OpenAI::Providers.bedrock(profile: "engineering"))
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      assert_includes(request.headers.fetch("Authorization"), "Credential=profile-access-key/")
      assert_includes(request.headers.fetch("Authorization"), "/us-west-2/bedrock-mantle/aws4_request")
    end
  end

  def test_named_profile_reads_shared_credentials_when_config_is_disabled
    ENV["AWS_SDK_CONFIG_OPT_OUT"] = "true"
    File.write(
      ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"),
      <<~INI
        [engineering]
        aws_access_key_id = profile-access-key
        aws_secret_access_key = profile-secret-key
      INI
    )
    reset_shared_config
    url = "https://bedrock-mantle.us-west-2.api.aws/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-west-2", profile: "engineering")
    )
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      assert_includes(request.headers.fetch("Authorization"), "Credential=profile-access-key/")
    end
  end

  def test_missing_named_profile_reports_a_credential_resolution_error
    error = assert_raises(OpenAI::Errors::Error) do
      OpenAI::Client.new(provider: OpenAI::Providers.bedrock(profile: "missing"))
    end
    assert_equal(OpenAI::Providers::Bedrock::MISSING_REGION_MESSAGE, error.message)

    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", profile: "missing")
    )

    error = assert_raises(OpenAI::Errors::Error) do
      runtime.prepare_request.call(bedrock_request)
    end

    assert_equal(OpenAI::Providers::Bedrock::CREDENTIAL_RESOLUTION_MESSAGE, error.message)
  end

  def test_default_chain_honors_aws_profile
    ENV["AWS_PROFILE"] = "selected"
    File.write(
      ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"),
      <<~INI
        [selected]
        aws_access_key_id = selected-access-key
        aws_secret_access_key = selected-secret-key
      INI
    )
    File.write(
      ENV.fetch("AWS_CONFIG_FILE"),
      <<~INI
        [profile selected]
        region = us-east-2
      INI
    )
    reset_shared_config
    url = "https://bedrock-mantle.us-east-2.api.aws/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(provider: OpenAI::Providers.bedrock(api_key: nil))
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      assert_includes(request.headers.fetch("Authorization"), "Credential=selected-access-key/")
    end
  end

  def test_endpoint_precedence_and_normalization
    ENV["AWS_BEDROCK_BASE_URL"] = "https://environment.example/openai/v1/responses/response-id"

    environment_client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    derived_client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        region: "us-west-2",
        base_url: nil,
        api_key: "bedrock-token"
      )
    )
    custom_client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        base_url: "https://explicit.example/openai/v1",
        api_key: "bedrock-token"
      )
    )

    assert_equal("https://environment.example/openai/v1", environment_client.base_url.to_s)
    assert_equal("https://bedrock-mantle.us-west-2.api.aws/openai/v1", derived_client.base_url.to_s)
    assert_equal("https://explicit.example/openai/v1", custom_client.base_url.to_s)

    sigv4_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        base_url: "https://gateway.example/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    prepared = sigv4_runtime.prepare_request.call(
      bedrock_request("https://gateway.example/openai/v1/models")
    )
    assert_includes(prepared.dig(:headers, "authorization"), "bedrock-mantle/aws4_request")
  end

  def test_sigv4_matches_the_shared_fixture
    fixture = JSON.parse(
      File.read(File.expand_path("../../fixtures/bedrock/v1/sigv4.json", __dir__))
    )
    credentials = fixture.fetch("credentials")
    provider = OpenAI::Providers.bedrock(
      region: fixture.fetch("region"),
      access_key_id: credentials.fetch("accessKeyId"),
      secret_access_key: credentials.fetch("secretAccessKey"),
      session_token: credentials.fetch("sessionToken")
    )
    runtime = OpenAI::Internal::Provider.configure(provider)
    request_fixture = fixture.fetch("request")
    request = {
      method: request_fixture.fetch("method").downcase.to_sym,
      url: URI(request_fixture.fetch("url")),
      headers: {"content-type" => request_fixture.fetch("contentType")},
      body: request_fixture.fetch("body")
    }

    Thread.current.thread_variable_set(:time_now, Time.iso8601(fixture.fetch("signingDate")))
    prepared = runtime.prepare_request.call(request)
    headers = prepared.fetch(:headers)
    expected = fixture.fetch("expected")

    assert_equal(expected.fetch("date"), headers["x-amz-date"])
    assert_equal(expected.fetch("payloadHash"), headers["x-amz-content-sha256"])
    assert_equal(credentials.fetch("sessionToken"), headers["x-amz-security-token"])
    assert_equal(expected.fetch("authorization"), headers["authorization"])
    assert_equal(false, prepared.fetch(:follow_redirects))
  end

  def test_sigv4_signs_the_serialized_body_sent_by_the_transport
    url = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/responses"
    requests = []
    stub_request(:post, url).to_return do |request|
      requests << request
      {status: 200, body: "{}", headers: {"content-type" => "application/json"}}
    end
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        region: "us-east-1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )

    client.request(
      {
        method: :post,
        path: "responses",
        body: {model: "openai.test-model", input: "hello"}
      }
    )

    request = requests.fetch(0)
    assert_equal(Digest::SHA256.hexdigest(request.body), request.headers["X-Amz-Content-Sha256"])
    assert_includes(request.headers.fetch("Authorization"), "bedrock-mantle/aws4_request")
  end

  def test_custom_credentials_are_refreshed_and_request_is_resigned_on_retry
    calls = 0
    credential_provider = lambda do
      calls += 1
      Aws::Credentials.new("retry-access-#{calls}", "retry-secret-#{calls}")
    end
    url = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"
    authorizations = []
    retry_counts = []
    stub_request(:get, url).to_return do |request|
      authorizations << request.headers.fetch("Authorization")
      retry_counts << request.headers.fetch("X-Stainless-Retry-Count")
      {
        status: authorizations.length == 1 ? 500 : 200,
        body: "{}",
        headers: {"content-type" => "application/json"}
      }
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        region: "us-east-1",
        credentials_provider: credential_provider
      ),
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    client.request({method: :get, path: "models"})

    assert_equal(2, calls)
    assert_includes(authorizations[0], "Credential=retry-access-1/")
    assert_includes(authorizations[1], "Credential=retry-access-2/")
    assert_equal(%w[0 1], retry_counts)
  end

  def test_custom_credential_provider_shapes_and_errors
    credentials = Aws::Credentials.new("custom-access", "custom-secret")
    object_provider = Struct.new(:credentials).new(credentials)
    nested_provider = Struct.new(:credentials).new(credentials)

    [object_provider, -> { nested_provider }].each do |credential_provider|
      runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          region: "us-east-1",
          credentials_provider: credential_provider
        )
      )
      prepared = runtime.prepare_request.call(bedrock_request)

      assert_includes(prepared.dig(:headers, "authorization"), "Credential=custom-access/")
    end

    [-> { Aws::Credentials.new("", "custom-secret") }, -> {}].each do |credential_provider|
      invalid_runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          region: "us-east-1",
          credentials_provider: credential_provider
        )
      )
      error = assert_raises(OpenAI::Errors::Error) do
        invalid_runtime.prepare_request.call(bedrock_request)
      end
      assert_equal(OpenAI::Providers::Bedrock::CREDENTIAL_RESOLUTION_MESSAGE, error.message)
    end

    failing_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        credentials_provider: -> { raise "credential provider failed" }
      )
    )
    error = assert_raises(OpenAI::Errors::Error) do
      failing_runtime.prepare_request.call(bedrock_request)
    end
    assert_equal(OpenAI::Providers::Bedrock::CREDENTIAL_RESOLUTION_MESSAGE, error.message)
    assert_equal("credential provider failed", error.cause.message)
  end

  def test_bearer_provider_refreshes_the_environment_token_per_attempt
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "first-token"
    provider = OpenAI::Providers.bedrock(region: "us-east-1")
    runtime = OpenAI::Internal::Provider.configure(provider)
    request = {
      method: :get,
      url: URI("https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"),
      headers: {},
      body: nil
    }

    first = runtime.prepare_request.call(request)
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "second-token"
    second = runtime.prepare_request.call(request)

    assert_equal("Bearer first-token", first.dig(:headers, "authorization"))
    assert_equal("Bearer second-token", second.dig(:headers, "authorization"))
  end

  def test_bearer_provider_is_refreshed_and_validated
    tokens = %w[first-token second-token]
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", token_provider: -> { tokens.shift })
    )

    first = runtime.prepare_request.call(bedrock_request)
    second = runtime.prepare_request.call(first)

    assert_equal("Bearer second-token", second.dig(:headers, "authorization"))

    invalid_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", token_provider: -> { " " })
    )
    error = assert_raises(OpenAI::Errors::Error) do
      invalid_runtime.prepare_request.call(bedrock_request)
    end
    assert_match(/must return a non-empty string/, error.message)

    failing_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        token_provider: -> { raise "token provider failed" }
      )
    )
    error = assert_raises(OpenAI::Errors::Error) do
      failing_runtime.prepare_request.call(bedrock_request)
    end
    assert_equal("Failed to resolve a bearer credential for Bedrock.", error.message)
    assert_equal("token provider failed", error.cause.message)
  end

  def test_provider_rejects_cross_origin_authentication
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    request = bedrock_request("https://example.com/openai/v1/models")

    error = assert_raises(OpenAI::Errors::Error) { runtime.prepare_request.call(request) }

    assert_match(/Refusing to authenticate.*other than the configured provider URL/, error.message)
  end

  def test_provider_rejects_custom_authorization_and_non_replayable_bodies
    bearer_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    custom_auth = {
      method: :get,
      url: URI("https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"),
      headers: {"authorization" => "Bearer custom"},
      body: nil
    }
    error = assert_raises(OpenAI::Errors::Error) { bearer_runtime.prepare_request.call(custom_auth) }
    assert_match(/custom `Authorization` header/, error.message)

    sigv4_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    streaming_body = custom_auth.merge(headers: {}, method: :post, body: StringIO.new("body"))
    error = assert_raises(OpenAI::Errors::Error) { sigv4_runtime.prepare_request.call(streaming_body) }
    assert_match(/replayable request body/, error.message)
  end

  def test_sigv4_rejects_redirects_and_mismatched_canonical_regions
    provider = OpenAI::Providers.bedrock(
      region: "us-east-1",
      access_key_id: "access-key",
      secret_access_key: "secret-key"
    )
    source = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models"
    target = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/redirected"
    stub_request(:get, source).to_return(status: 307, headers: {"location" => target}, body: "")
    stub_request(:get, target).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(provider: provider, max_retries: 0)
    error = assert_raises(OpenAI::Errors::APIStatusError) do
      client.request({method: :get, path: "models"})
    end
    assert_equal(307, error.status)
    assert_not_requested(:get, target)

    mismatched = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        base_url: "https://bedrock-mantle.us-west-2.api.aws/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    request = {
      method: :get,
      url: URI("https://bedrock-mantle.us-west-2.api.aws/openai/v1/models"),
      headers: {},
      body: nil
    }
    error = assert_raises(OpenAI::Errors::Error) { mismatched.prepare_request.call(request) }
    assert_match(/region `us-west-2` does not match.*`us-east-1`/, error.message)
  end

  def test_authentication_modes_are_validated
    assert_raises(OpenAI::Errors::Error) do
      OpenAI::Providers.bedrock(region: "us-east-1", access_key_id: "access-key")
    end
    assert_raises(OpenAI::Errors::Error) do
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        api_key: "bedrock-token",
        profile: "engineering"
      )
    end
    assert_raises(OpenAI::Errors::Error) do
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        access_key_id: "access-key",
        secret_access_key: "secret-key",
        profile: "engineering"
      )
    end
  end

  def test_provider_handles_are_opaque_and_reject_foreign_values
    provider = OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")

    assert_equal("#<OpenAI::Provider>", provider.inspect)
    assert_predicate(provider, :frozen?)
    assert_raises(NoMethodError) { provider.definition }

    error = assert_raises(OpenAI::Errors::Error) do
      OpenAI::Internal::Provider.name(Object.new)
    end
    assert_match(/Invalid provider/, error.message)
  end

  def test_configuration_values_are_validated
    cases = [
      [{region: " "}, /AWS `region` must not be empty/],
      [{region: Object.new}, /AWS `region` must not be empty/],
      [{region: "us-east-1", profile: " "}, /AWS `profile` must not be empty/],
      [{region: "us-east-1", base_url: " "}, /`base_url` must not be empty/],
      [{region: "us-east-1", base_url: "relative", api_key: "token"}, /absolute HTTP or HTTPS/],
      [{region: "us-east-1", base_url: "https://[", api_key: "token"}, /absolute HTTP or HTTPS/],
      [
        {region: "us-east-1", access_key_id: " ", secret_access_key: "secret"},
        /require non-empty/
      ],
      [
        {
          region: "us-east-1",
          access_key_id: "access",
          secret_access_key: "secret",
          session_token: " "
        },
        /`session_token` must not be empty/
      ],
      [{region: "us-east-1", session_token: "token"}, /require both/],
      [{region: "us-east-1", api_key: " "}, /bearer credential must not be empty/],
      [
        {region: "us-east-1", api_key: "token", token_provider: -> { "token" }},
        /mutually exclusive/
      ],
      [{region: "us-east-1", token_provider: Object.new}, /must respond to `call`/],
      [{region: "us-east-1", credentials_provider: Object.new}, /must respond to `call` or `credentials`/],
      [{api_key: "token"}, /requires an AWS region/]
    ]

    cases.each do |options, message|
      error = assert_raises(OpenAI::Errors::Error, options.inspect) do
        OpenAI::Providers.bedrock(**options)
      end
      assert_match(message, error.message, options.inspect)
    end

    provider = OpenAI::Providers.bedrock(
      base_url: "https://example.com/",
      api_key: "token"
    )
    client = OpenAI::Client.new(provider: provider)
    assert_equal("https://example.com", client.base_url.to_s)
  end

  def test_unexpected_signing_errors_use_auth_specific_messages
    providers = [
      [
        OpenAI::Providers.bedrock(region: "us-east-1", api_key: nil),
        OpenAI::Providers::Bedrock::MISSING_CREDENTIALS_MESSAGE
      ],
      [
        OpenAI::Providers.bedrock(
          region: "us-east-1",
          access_key_id: "access-key",
          secret_access_key: "secret-key"
        ),
        OpenAI::Providers::Bedrock::CREDENTIAL_RESOLUTION_MESSAGE
      ]
    ]

    providers.each do |provider, message|
      runtime = OpenAI::Internal::Provider.configure(provider)
      request = bedrock_request.except(:method)

      error = assert_raises(OpenAI::Errors::Error) { runtime.prepare_request.call(request) }
      assert_equal(message, error.message)
      assert_instance_of(KeyError, error.cause)
    end
  end

  private def reset_shared_config
    Aws.instance_variable_set(:@shared_config, nil)
  end

  private def bedrock_request(url = "https://bedrock-mantle.us-east-1.api.aws/openai/v1/models")
    {method: :get, url: URI(url), headers: {}, body: nil}
  end
end

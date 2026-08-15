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
    stub_request(:get, "https://bedrock-mantle.us-east-1.api.aws/v1/models")
      .to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    client.request({method: :get, path: "models"})

    assert_equal("https://bedrock-mantle.us-east-1.api.aws/v1", client.base_url.to_s)
    assert_requested(:get, "https://bedrock-mantle.us-east-1.api.aws/v1/models") do |request|
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
    url = "https://bedrock-mantle.us-east-1.api.aws/v1/models"
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

  def test_provider_authentication_overrides_explicit_default_headers
    url = "https://bedrock-mantle.us-east-1.api.aws/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token"),
      default_headers: {
        "Authorization" => "Bearer string-custom",
        Authorization: "Bearer symbol-custom",
        :"X-Cost-Center" => "finance"
      }
    )
    refute_includes(client.headers, :authorization)
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("Bearer bedrock-token", headers["authorization"])
      assert_equal("finance", headers["x-cost-center"])
    end
  end

  def test_provider_rejects_top_level_authentication_and_routing
    provider = OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")

    error = assert_raises(ArgumentError) do
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
    url = "https://bedrock-mantle.us-east-1.api.aws/v1/models"
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
    url = "https://bedrock-mantle.us-west-2.api.aws/v1/models"
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
    url = "https://bedrock-mantle.us-west-2.api.aws/v1/models"
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
    error = assert_raises(ArgumentError) do
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
    url = "https://bedrock-mantle.us-east-2.api.aws/v1/models"
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
    assert_equal("https://bedrock-mantle.us-west-2.api.aws/v1", derived_client.base_url.to_s)
    assert_equal("https://explicit.example/openai/v1", custom_client.base_url.to_s)

    sigv4_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        endpoint: :mantle,
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
    url = "https://bedrock-mantle.us-east-1.api.aws/v1/responses"
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
      ),
      default_headers: {
        "X-Amz-Content-Sha256": "injected-hash",
        "X-Amz-Date": "injected-date",
        "X-Amz-Security-Token": "injected-token"
      }
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
    refute_equal("injected-date", request.headers["X-Amz-Date"])
    refute_includes(request.headers, "X-Amz-Security-Token")
    assert_includes(request.headers.fetch("Authorization"), "bedrock-mantle/aws4_request")
  end

  def test_custom_credentials_are_refreshed_and_request_is_resigned_on_retry
    calls = 0
    credential_provider = lambda do
      calls += 1
      Aws::Credentials.new("retry-access-#{calls}", "retry-secret-#{calls}")
    end
    url = "https://bedrock-mantle.us-east-1.api.aws/v1/models"
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
      url: URI("https://bedrock-mantle.us-east-1.api.aws/v1/models"),
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
      url: URI("https://bedrock-mantle.us-east-1.api.aws/v1/models"),
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

  def test_provider_rejects_symbol_request_authorization_header
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(
        {method: :get, path: "models", options: {extra_headers: {Authorization: "Bearer custom"}}}
      )
    end

    assert_match(/custom `Authorization` header/, error.message)
  end

  def test_sigv4_rejects_redirects_and_mismatched_canonical_regions
    provider = OpenAI::Providers.bedrock(
      region: "us-east-1",
      access_key_id: "access-key",
      secret_access_key: "secret-key"
    )
    source = "https://bedrock-mantle.us-east-1.api.aws/v1/models"
    target = "https://bedrock-mantle.us-east-1.api.aws/v1/redirected"
    stub_request(:get, source).to_return(status: 307, headers: {"location" => target}, body: "")
    stub_request(:get, target).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(provider: provider, max_retries: 0)
    error = assert_raises(OpenAI::Errors::APIStatusError) do
      client.request({method: :get, path: "models"})
    end
    assert_equal(307, error.status)
    assert_not_requested(:get, target)

    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        base_url: "https://bedrock-mantle.us-west-2.api.aws/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    end
    assert_match(/region `us-west-2` does not match.*`us-east-1`/, error.message)
  end

  def test_runtime_derives_partition_aware_hosts_and_signing_services
    endpoints = {
      "us-east-1" => "amazonaws.com",
      "cn-north-1" => "amazonaws.com.cn",
      "eusc-de-east-1" => "amazonaws.eu",
      "us-iso-east-1" => "c2s.ic.gov",
      "us-isob-east-1" => "sc2s.sgov.gov",
      "eu-isoe-west-1" => "cloud.adc-e.uk",
      "us-isof-south-1" => "csp.hci.ic.gov"
    }

    endpoints.each do |region, suffix|
      base_url = "https://bedrock-runtime.#{region}.#{suffix}/openai/v1"
      bearer_client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: region, api_key: "token")
      )
      assert_equal(base_url, bearer_client.base_url.to_s)

      runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          endpoint: "runtime",
          region: region,
          access_key_id: "access-key",
          secret_access_key: "secret-key",
          session_token: "session-token"
        )
      )
      prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

      assert_includes(prepared.dig(:headers, "authorization"), "/#{region}/bedrock/aws4_request")
      assert_equal("session-token", prepared.dig(:headers, "x-amz-security-token"))
    end
  end

  def test_runtime_infers_canonical_fips_dual_stack_and_partition_hosts
    hosts = {
      "bedrock-runtime.us-east-1.amazonaws.com" => "us-east-1",
      "bedrock-runtime.us-east-1.amazonaws.com." => "us-east-1",
      "bedrock-runtime.us-east-1.api.aws" => "us-east-1",
      "bedrock-runtime-fips.us-east-1.amazonaws.com" => "us-east-1",
      "bedrock-runtime-fips.us-east-1.api.aws" => "us-east-1",
      "bedrock-runtime.cn-north-1.api.amazonwebservices.com.cn" => "cn-north-1",
      "bedrock-runtime.eusc-de-east-1.api.amazonwebservices.eu" => "eusc-de-east-1",
      "bedrock-runtime.us-iso-east-1.api.aws.ic.gov" => "us-iso-east-1",
      "bedrock-runtime.us-isob-east-1.api.aws.scloud" => "us-isob-east-1",
      "bedrock-runtime.eu-isoe-west-1.api.cloud-aws.adc-e.uk" => "eu-isoe-west-1",
      "bedrock-runtime.us-isof-south-1.api.aws.hci.ic.gov" => "us-isof-south-1"
    }

    hosts.each do |host, region|
      base_url = "https://#{host}/openai/v1"
      client = OpenAI::Client.new(
        provider: OpenAI::Providers.bedrock(region: region, base_url: base_url, api_key: "token")
      )
      assert_equal(base_url, client.base_url.to_s)

      runtime = OpenAI::Internal::Provider.configure(
        OpenAI::Providers.bedrock(
          region: region,
          base_url: base_url,
          access_key_id: "access-key",
          secret_access_key: "secret-key"
        )
      )
      prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

      assert_includes(prepared.dig(:headers, "authorization"), "/#{region}/bedrock/aws4_request")
    end

    ENV["AWS_BEDROCK_BASE_URL"] = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(region: "us-east-1", api_key: "token")
    )
    assert_equal(ENV.fetch("AWS_BEDROCK_BASE_URL"), client.base_url.to_s)
  end

  def test_runtime_rejects_insecure_mismatched_or_invalid_configuration
    authentication_options = [
      {api_key: "token"},
      {access_key_id: "access-key", secret_access_key: "secret-key"}
    ]
    invalid_endpoints = [
      ["http://bedrock-runtime.us-east-1.amazonaws.com/openai/v1", :runtime, "us-east-1", /HTTPS/],
      [
        "https://bedrock-runtime.us-west-2.amazonaws.com/openai/v1",
        :runtime,
        "us-east-1",
        /region `us-west-2` does not match/
      ],
      [
        "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1",
        :mantle,
        "us-east-1",
        /hostname does not match/
      ],
      [
        "https://bedrock-mantle.us-east-1.api.aws/v1",
        :runtime,
        "us-east-1",
        /hostname does not match/
      ]
    ]

    authentication_options.each do |authentication|
      invalid_endpoints.each do |base_url, endpoint, region, message|
        error = assert_raises(ArgumentError) do
          OpenAI::Providers.bedrock(
            endpoint: endpoint,
            region: region,
            base_url: base_url,
            **authentication
          )
        end
        assert_match(message, error.message)
      end
    end

    [:invalid, "runtime-fips", true].each do |endpoint|
      error = assert_raises(ArgumentError) do
        OpenAI::Providers.bedrock(endpoint: endpoint, region: "us-east-1", api_key: "token")
      end
      assert_match(/must be either `mantle` or `runtime`/, error.message)
    end

    ["US-EAST-1", "us-east-1.example", "../us-east-1"].each do |region|
      error = assert_raises(ArgumentError) do
        OpenAI::Providers.bedrock(endpoint: :runtime, region: region, api_key: "token")
      end
      assert_match(/AWS `region` is invalid/, error.message)
    end

    ENV["AWS_REGION"] = "us-east-1.example"
    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(endpoint: :runtime, api_key: "token")
    end
    assert_match(/AWS `region` is invalid/, error.message)
  end

  def test_runtime_requires_explicit_endpoint_for_custom_signed_proxies
    error = assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        base_url: "http://localhost:8090/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    end
    assert_match(/requires an explicit `endpoint`/, error.message)

    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        endpoint: :runtime,
        region: "us-east-1",
        base_url: "http://localhost:8090/openai/v1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    prepared = runtime.prepare_request.call(bedrock_request("http://localhost:8090/openai/v1/models"))
    assert_includes(prepared.dig(:headers, "authorization"), "/us-east-1/bedrock/aws4_request")

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(
        endpoint: :runtime,
        base_url: "http://localhost:8090/openai/v1",
        api_key: "token"
      )
    )
    assert_equal("http://localhost:8090/openai/v1", client.base_url.to_s)
  end

  def test_runtime_authenticates_chat_and_responses_with_bearer_and_sigv4
    runtime_authentication_options.each { assert_runtime_api_requests(_1) }
  end

  private def assert_runtime_api_requests(authentication)
    WebMock.reset!
    model = "us.openai.gpt-5.6-sol"
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    chat_url = "#{base_url}/chat/completions"
    responses_url = "#{base_url}/responses"
    stub_request(:post, chat_url).to_return_json(
      status: 200,
      headers: {"x-request-id" => "runtime-chat-request"},
      body: {
        id: "chatcmpl_runtime",
        choices: [{finish_reason: "stop", index: 0, message: {content: "Hello", role: "assistant"}}],
        created: 1_700_000_000,
        model: model,
        object: "chat.completion",
        usage: {completion_tokens: 4, prompt_tokens: 3, total_tokens: 7}
      }
    )
    stub_request(:post, responses_url).to_return_json(
      status: 200,
      headers: {"x-request-id" => "runtime-response-request"},
      body: {
        id: "resp_runtime",
        object: "response",
        model: model,
        output: [
          {
            id: "msg_runtime",
            type: "message",
            role: "assistant",
            content: [{type: "output_text", text: "Hello", annotations: []}]
          }
        ],
        status: "completed"
      }
    )

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **authentication)
    )
    completion = client.chat.completions.create(model: model, messages: [{role: :user, content: "Hi"}])
    response = client.responses.create(model: model, input: "Hi")

    assert_equal("Hello", completion.choices.fetch(0).message.content)
    assert_equal(:stop, completion.choices.fetch(0).finish_reason)
    assert_equal(7, completion.usage.total_tokens)
    assert_equal("runtime-chat-request", completion._request_id)
    assert_equal("Hello", response.output_text)
    assert_equal("runtime-response-request", response._request_id)

    [chat_url, responses_url].each do |url|
      assert_requested(:post, url, times: 1) do |request|
        assert_runtime_authorization(request, authentication)
      end
    end
  end

  def test_runtime_streams_chat_and_responses_with_bearer_and_sigv4
    runtime_authentication_options.each { assert_runtime_streaming_requests(_1) }
  end

  private def assert_runtime_streaming_requests(authentication)
    WebMock.reset!
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1"
    chat_url = "#{base_url}/chat/completions"
    responses_url = "#{base_url}/responses"
    [chat_url, responses_url].each do |url|
      stub_request(:post, url).to_return(
        status: 200,
        body: "data: [DONE]\n\n",
        headers: {"content-type" => "text/event-stream", "x-request-id" => "runtime-stream-request"}
      )
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **authentication)
    )
    chat_stream = client.chat.completions.stream(
      model: "us.openai.gpt-5.6-terra",
      messages: [{role: :user, content: "Hi"}]
    )
    response_stream = client.responses.stream(model: "us.openai.gpt-5.6-luna", input: "Hi")

    assert_instance_of(OpenAI::Streaming::ChatCompletionStream, chat_stream)
    assert_instance_of(OpenAI::Streaming::ResponseStream, response_stream)
    assert_equal("runtime-stream-request", chat_stream.last_response.request_id)
    assert_equal("runtime-stream-request", response_stream.last_response.request_id)

    [chat_url, responses_url].each do |url|
      assert_requested(:post, url, times: 1) do |request|
        assert_equal(true, JSON.parse(request.body).fetch("stream"))
        assert_runtime_authorization(request, authentication)
      end
    end
    chat_stream.close
    response_stream.close
  end

  def test_runtime_refreshes_bearer_tokens_and_aws_credentials_on_retries
    [false, true].each { assert_runtime_retry_authentication(_1) }
  end

  private def assert_runtime_retry_authentication(use_aws_credentials)
    base_url = "https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1/models"
    WebMock.reset!
    calls = 0
    options =
      if use_aws_credentials
        {
          credentials_provider: lambda do
            calls += 1
            Aws::Credentials.new("runtime-access-#{calls}", "runtime-secret-#{calls}")
          end
        }
      else
        {
          token_provider: lambda do
            calls += 1
            "runtime-token-#{calls}"
          end
        }
      end
    authorizations = []
    stub_request(:get, base_url).to_return do |request|
      authorizations << request.headers.fetch("Authorization")
      {
        status: authorizations.length == 1 ? 429 : 200,
        body: "{}",
        headers: {"content-type" => "application/json"}
      }
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(endpoint: :runtime, region: "us-east-1", **options),
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    client.request({method: :get, path: "models"})

    assert_equal(2, calls)
    if use_aws_credentials
      assert_includes(authorizations.fetch(0), "Credential=runtime-access-1/")
      assert_includes(authorizations.fetch(1), "Credential=runtime-access-2/")
      assert_includes(authorizations.fetch(1), "/bedrock/aws4_request")
    else
      assert_equal(["Bearer runtime-token-1", "Bearer runtime-token-2"], authorizations)
    end
  end

  def test_runtime_preserves_environment_token_precedence_and_default_aws_chain
    ENV["AWS_REGION"] = "us-east-1"
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "environment-token"
    ENV["AWS_ACCESS_KEY_ID"] = "environment-access-key"
    ENV["AWS_SECRET_ACCESS_KEY"] = "environment-secret-key"
    ENV["AWS_SESSION_TOKEN"] = "environment-session-token"
    request = bedrock_request("https://bedrock-runtime.us-east-1.amazonaws.com/openai/v1/models")

    bearer_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime)
    )
    bearer_request = bearer_runtime.prepare_request.call(request)
    assert_equal("Bearer environment-token", bearer_request.dig(:headers, "authorization"))

    aws_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime, api_key: nil)
    )
    aws_request = aws_runtime.prepare_request.call(request)
    assert_includes(aws_request.dig(:headers, "authorization"), "Credential=environment-access-key/")
    assert_includes(aws_request.dig(:headers, "authorization"), "/bedrock/aws4_request")
    assert_equal("environment-session-token", aws_request.dig(:headers, "x-amz-security-token"))
  end

  def test_runtime_resolves_profile_region_without_changing_signing_service
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
    base_url = "https://bedrock-runtime.us-west-2.amazonaws.com/openai/v1"

    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(endpoint: :runtime, profile: "engineering")
    )
    prepared = runtime.prepare_request.call(bedrock_request("#{base_url}/models"))

    assert_includes(prepared.dig(:headers, "authorization"), "Credential=profile-access-key/")
    assert_includes(prepared.dig(:headers, "authorization"), "/us-west-2/bedrock/aws4_request")
  end

  def test_authentication_modes_are_validated
    assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(region: "us-east-1", access_key_id: "access-key")
    end
    assert_raises(ArgumentError) do
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        api_key: "bedrock-token",
        profile: "engineering"
      )
    end
    assert_raises(ArgumentError) do
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

    assert_instance_of(OpenAI::Provider, provider)
    assert_equal("#<OpenAI::Provider>", provider.inspect)
    assert_predicate(provider, :frozen?)
    assert_raises(NoMethodError) { provider.definition }
    assert_raises(NoMethodError) { OpenAI::Provider.new(Object.new) }

    error = assert_raises(ArgumentError) do
      OpenAI::Internal::Provider.name(Object.new)
    end
    assert_match(/Invalid provider/, error.message)

    error = assert_raises(ArgumentError) { OpenAI::Client.new(provider: false) }
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
      [{region: "us-east-1", token_provider: false}, /must respond to `call`/],
      [{region: "us-east-1", credentials_provider: Object.new}, /must respond to `call` or `credentials`/],
      [{region: "us-east-1", credentials_provider: false}, /must respond to `call` or `credentials`/],
      [{api_key: "token"}, /requires an AWS region/]
    ]

    cases.each do |options, message|
      error = assert_raises(ArgumentError, options.inspect) do
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

  def test_internal_request_errors_are_not_reported_as_credential_errors
    bearer_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    )
    error = assert_raises(KeyError) do
      bearer_runtime.prepare_request.call(bedrock_request.except(:url))
    end
    assert_match(/url/, error.message)

    sigv4_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.bedrock(
        region: "us-east-1",
        access_key_id: "access-key",
        secret_access_key: "secret-key"
      )
    )
    error = assert_raises(KeyError) do
      sigv4_runtime.prepare_request.call(bedrock_request.except(:method))
    end
    assert_match(/method/, error.message)
  end

  private def reset_shared_config
    Aws.instance_variable_set(:@shared_config, nil)
  end

  private def runtime_authentication_options
    [
      {api_key: "runtime-token"},
      {access_key_id: "runtime-access-key", secret_access_key: "runtime-secret-key"}
    ]
  end

  private def assert_runtime_authorization(request, authentication)
    authorization = request.headers.fetch("Authorization")
    if authentication.key?(:api_key)
      assert_equal("Bearer runtime-token", authorization)
    else
      assert_includes(authorization, "Credential=runtime-access-key/")
      assert_includes(authorization, "/us-east-1/bedrock/aws4_request")
    end
  end

  private def bedrock_request(url = "https://bedrock-mantle.us-east-1.api.aws/v1/models")
    {method: :get, url: URI(url), headers: {}, body: nil}
  end
end

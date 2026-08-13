# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::AzureProviderTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  ENVIRONMENT_VARIABLES = %w[
    AZURE_OPENAI_API_KEY
    AZURE_OPENAI_ENDPOINT
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
  end

  def teardown
    WebMock.reset!
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_api_key_provider_owns_endpoint_and_authentication
    url = "https://example-resource.openai.azure.com/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com/",
        api_key: "azure-key"
      )
    )
    client.request({method: :get, path: "models"})

    assert_equal("https://example-resource.openai.azure.com/openai/v1", client.base_url.to_s)
    assert_requested(:get, url) do |request|
      assert_equal("azure-key", request.headers["Api-Key"])
      refute_includes(request.headers, "Authorization")
    end
  end

  def test_environment_configuration_and_explicit_precedence
    ENV["AZURE_OPENAI_ENDPOINT"] = "https://environment.openai.azure.com"
    ENV["AZURE_OPENAI_API_KEY"] = "environment-key"

    environment_client = OpenAI::Client.new(provider: OpenAI::Providers.azure)
    explicit_client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://explicit.openai.azure.com/openai/v1/",
        api_key: "explicit-key"
      )
    )

    assert_equal("https://environment.openai.azure.com/openai/v1", environment_client.base_url.to_s)
    assert_equal("https://explicit.openai.azure.com/openai/v1", explicit_client.base_url.to_s)

    environment_runtime = OpenAI::Internal::Provider.configure(OpenAI::Providers.azure)
    explicit_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://explicit.openai.azure.com",
        api_key: "explicit-key"
      )
    )

    assert_equal(
      "environment-key",
      environment_runtime.prepare_request.call(
        azure_request("https://environment.openai.azure.com/openai/v1/models")
      ).dig(:headers, "api-key")
    )
    assert_equal(
      "explicit-key",
      explicit_runtime.prepare_request.call(
        azure_request("https://explicit.openai.azure.com/openai/v1/models")
      ).dig(:headers, "api-key")
    )
  end

  def test_explicit_token_provider_ignores_environment_api_key
    ENV["AZURE_OPENAI_API_KEY"] = "environment-key"
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        token_provider: -> { "entra-token" }
      )
    )

    prepared = runtime.prepare_request.call(azure_request)

    assert_equal("Bearer entra-token", prepared.dig(:headers, "authorization"))
    refute_includes(prepared.fetch(:headers), "api-key")
  end

  def test_token_provider_is_refreshed_for_each_retry_attempt
    url = "https://example-resource.openai.azure.com/openai/v1/models"
    calls = 0
    tokens = []
    stub_request(:get, url).to_return do |request|
      tokens << request.headers.fetch("Authorization")
      calls += 1
      calls == 1 ? {status: 500, body: "{}"} : {status: 200, body: "{}"}
    end

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        token_provider: -> { "token-#{calls + 1}" }
      ),
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    client.request({method: :get, path: "models"})

    assert_equal(["Bearer token-1", "Bearer token-2"], tokens)
  end

  def test_provider_ignores_ambient_openai_configuration
    ENV["OPENAI_API_KEY"] = "openai-key"
    ENV["OPENAI_ADMIN_KEY"] = "openai-admin-key"
    ENV["OPENAI_BASE_URL"] = "https://api.example.com/v1"
    ENV["OPENAI_ORG_ID"] = "org-example"
    ENV["OPENAI_PROJECT_ID"] = "project-example"
    ENV["OPENAI_CUSTOM_HEADERS"] = "x-openai-custom: should-not-leak"
    url = "https://example-resource.openai.azure.com/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      )
    )
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("azure-key", headers["api-key"])
      refute_includes(headers, "authorization")
      refute_includes(headers, "openai-organization")
      refute_includes(headers, "openai-project")
      refute_includes(headers, "x-openai-custom")
    end
  end

  def test_provider_authentication_overrides_explicit_default_headers
    url = "https://example-resource.openai.azure.com/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      ),
      default_headers: {
        "Authorization" => "Bearer string-custom",
        Authorization: "Bearer symbol-custom",
        "Api-Key" => "string-custom-key",
        :"Api-Key" => "symbol-custom-key",
        :"X-Cost-Center" => "finance"
      }
    )
    client.request({method: :get, path: "models"})

    assert_requested(:get, url) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("azure-key", headers["api-key"])
      refute_includes(headers, "authorization")
      assert_equal("finance", headers["x-cost-center"])
    end
  end

  def test_endpoint_normalization
    cases = {
      "https://example.openai.azure.com" => "https://example.openai.azure.com/openai/v1",
      "https://example.openai.azure.com/" => "https://example.openai.azure.com/openai/v1",
      "https://example.openai.azure.com/openai" => "https://example.openai.azure.com/openai/v1",
      "https://example.openai.azure.com/openai/" => "https://example.openai.azure.com/openai/v1",
      "https://example.openai.azure.com/openai/v1" => "https://example.openai.azure.com/openai/v1",
      "https://example.openai.azure.com/openai/v1/" => "https://example.openai.azure.com/openai/v1",
      "https://gateway.example.com/azure" => "https://gateway.example.com/azure/openai/v1"
    }

    cases.each do |endpoint, expected|
      client = OpenAI::Client.new(
        provider: OpenAI::Providers.azure(endpoint: endpoint, api_key: "azure-key")
      )
      assert_equal(expected, client.base_url.to_s, endpoint)
    end
  end

  def test_provider_rejects_top_level_authentication_and_routing
    provider = OpenAI::Providers.azure(
      endpoint: "https://example-resource.openai.azure.com",
      api_key: "azure-key"
    )

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(provider: provider, api_key: "openai-key", base_url: "https://example.com")
    end

    assert_match(/`api_key`, `base_url`/, error.message)
    assert_match(/`azure\(\.\.\.\)`/, error.message)
  end

  def test_token_provider_output_and_errors_are_validated
    invalid_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        token_provider: -> { " " }
      )
    )
    error = assert_raises(OpenAI::Errors::Error) do
      invalid_runtime.prepare_request.call(azure_request)
    end
    assert_match(/must return a non-empty string/, error.message)

    failing_runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        token_provider: -> { raise "token provider failed" }
      )
    )
    error = assert_raises(OpenAI::Errors::Error) do
      failing_runtime.prepare_request.call(azure_request)
    end
    assert_equal("Failed to resolve a bearer token for Azure OpenAI.", error.message)
    assert_equal("token provider failed", error.cause.message)
  end

  def test_provider_rejects_cross_origin_authentication
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      )
    )

    error = assert_raises(OpenAI::Errors::Error) do
      runtime.prepare_request.call(azure_request("https://example.com/openai/v1/models"))
    end

    assert_match(/Refusing to authenticate.*other than the configured Azure OpenAI endpoint/, error.message)
  end

  def test_provider_rejects_custom_authentication_headers
    runtime = OpenAI::Internal::Provider.configure(
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      )
    )

    [
      {"authorization" => "Bearer custom"},
      {"api-key" => "custom-key"}
    ].each do |headers|
      error = assert_raises(OpenAI::Errors::Error) do
        runtime.prepare_request.call(azure_request.merge(headers: headers))
      end
      assert_match(/cannot be combined with a custom/, error.message)
    end
  end

  def test_provider_rejects_symbol_request_authentication_headers
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      )
    )

    [{Authorization: "Bearer custom"}, {"Api-Key": "custom-key"}].each do |headers|
      error = assert_raises(OpenAI::Errors::Error) do
        client.request({method: :get, path: "models", options: {extra_headers: headers}})
      end

      assert_match(/cannot be combined with a custom/, error.message)
    end
  end

  def test_configuration_values_are_validated
    cases = [
      [{api_key: "azure-key"}, /requires an endpoint/],
      [{endpoint: " ", api_key: "azure-key"}, /endpoint.*must not be empty/],
      [{endpoint: "relative", api_key: "azure-key"}, /absolute HTTP or HTTPS/],
      [{endpoint: "https://[", api_key: "azure-key"}, /absolute HTTP or HTTPS/],
      [{endpoint: "https://example.com?query=yes", api_key: "azure-key"}, /must not include a query/],
      [{endpoint: "https://example.com#fragment", api_key: "azure-key"}, /must not include.*fragment/],
      [{endpoint: "https://user@example.com", api_key: "azure-key"}, /must not include user information/],
      [{endpoint: "https://example.com", api_key: " "}, /API key must not be empty/],
      [
        {endpoint: "https://example.com", api_key: "key", token_provider: -> { "token" }},
        /mutually exclusive/
      ],
      [{endpoint: "https://example.com", token_provider: Object.new}, /must respond to `call`/],
      [{endpoint: "https://example.com", token_provider: false}, /must respond to `call`/],
      [{endpoint: "https://example.com", api_key: nil}, /Could not find credentials/]
    ]

    cases.each do |options, message|
      error = assert_raises(ArgumentError, options.inspect) do
        OpenAI::Providers.azure(**options)
      end
      assert_match(message, error.message, options.inspect)
    end
  end

  private def azure_request(url = "https://example-resource.openai.azure.com/openai/v1/models")
    {method: :get, url: URI(url), headers: {}, body: nil}
  end
end

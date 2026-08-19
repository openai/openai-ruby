# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ClientAuthenticationTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_generic_request_uses_only_configured_normal_api_key
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key", admin_api_key: nil)

    assert_equal({}, openai.request(method: :get, path: "models"))

    assert_requested(:get, "http://localhost/models") do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
    end
  end

  def test_generic_request_uses_only_configured_admin_api_key
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: nil, admin_api_key: "My Admin API Key")

    openai.request(method: :get, path: "models")

    assert_requested(:get, "http://localhost/models") do |request|
      assert_equal("Bearer My Admin API Key", request.headers["Authorization"])
    end
  end

  def test_generic_request_prefers_normal_api_key_when_both_credentials_exist
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "models")

    assert_requested(:get, "http://localhost/models") do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
    end
  end

  def test_generic_request_prefers_normal_api_key_regardless_of_security_scheme_order
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "models", security: {admin_api_key_auth: true, bearer_auth: true})
    openai.request(method: :get, path: "models", security: {bearer_auth: true, admin_api_key_auth: true})

    assert_requested(:get, "http://localhost/models", times: 2) do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
    end
  end

  def test_generic_request_preserves_noncolliding_authentication_headers
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    client_class = Class.new(OpenAI::Client) do
      private def bearer_auth
        super.merge("x-ordinary-auth" => "ordinary", "x-shared-auth" => "ordinary")
      end

      private def admin_api_key_auth
        super.merge("x-admin-auth" => "admin", "x-shared-auth" => "admin")
      end
    end

    openai = client_class.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "models")

    assert_requested(:get, "http://localhost/models") do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("Bearer My API Key", headers["authorization"])
      assert_equal("ordinary", headers["x-ordinary-auth"])
      assert_equal("admin", headers["x-admin-auth"])
      assert_equal("admin", headers["x-shared-auth"])
    end
  end

  def test_generic_request_preserves_explicit_admin_authentication
    stub_request(:get, "http://localhost/organization/admin_api_keys").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "organization/admin_api_keys", security: {admin_api_key_auth: true})

    assert_requested(:get, "http://localhost/organization/admin_api_keys") do |request|
      assert_equal("Bearer My Admin API Key", request.headers["Authorization"])
    end
  end

  def test_disabled_security_schemes_do_not_send_authentication_headers
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "models", security: {bearer_auth: false, admin_api_key_auth: false})

    assert_requested(:get, "http://localhost/models") do |request|
      refute_includes(request.headers.transform_keys(&:downcase), "authorization")
    end
  end

  def test_generic_request_options_preserve_default_credential_and_header_overrides
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.request(method: :get, path: "models", options: {extra_headers: {"x-request-option" => "kept"}})
    openai.request(
      method: :get,
      path: "models",
      options: {extra_headers: {"authorization" => "Bearer explicit-request-key"}}
    )

    assert_requested(:get, "http://localhost/models", headers: {"X-Request-Option" => "kept"}) do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
    end

    assert_requested(
      :get,
      "http://localhost/models",
      headers: {"Authorization" => "Bearer explicit-request-key"}
    ) do |request|
      assert_equal("Bearer explicit-request-key", request.headers["Authorization"])
    end
  end

  def test_generated_resources_preserve_route_specific_authentication_and_request_options
    ordinary_url = "http://localhost/models"
    admin_url = "http://localhost/organization/admin_api_keys"
    response = {object: "list", data: [], has_more: false}
    stub_request(:get, ordinary_url).to_return_json(status: 200, body: response)
    stub_request(:get, admin_url).to_return_json(status: 200, body: response)
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.models.list(request_options: {extra_headers: {"x-resource" => "ordinary"}})
    openai.admin.organization.admin_api_keys.list(request_options: {extra_headers: {"x-resource" => "admin"}})

    assert_requested(:get, ordinary_url, headers: {"X-Resource" => "ordinary"}) do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
    end

    assert_requested(:get, admin_url, headers: {"X-Resource" => "admin"}) do |request|
      assert_equal("Bearer My Admin API Key", request.headers["Authorization"])
    end
  end

  def test_generated_resources_do_not_substitute_an_unrequested_credential
    ordinary_only = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key", admin_api_key: nil)
    admin_only = OpenAI::Client.new(base_url: "http://localhost", api_key: nil, admin_api_key: "My Admin API Key")

    ordinary_error = assert_raises(ArgumentError) { ordinary_only.admin.organization.admin_api_keys.list }
    admin_error = assert_raises(ArgumentError) { admin_only.models.list }

    assert_match(/Could not resolve authentication method/, ordinary_error.message)
    assert_match(/Could not resolve authentication method/, admin_error.message)
    assert_not_requested(:any, /./)
  end

  def test_provider_runtime_preserves_its_own_authentication
    url = "https://example.openai.azure.com/openai/v1/models"
    stub_request(:get, url).to_return_json(status: 200, body: {})
    provider = OpenAI::Providers.azure(endpoint: "https://example.openai.azure.com", api_key: "azure-key")
    openai = OpenAI::Client.new(provider: provider)

    openai.request(method: :get, path: "models")

    assert_requested(:get, url) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("azure-key", headers["api-key"])
      refute_includes(headers, "authorization")
    end
  end
end

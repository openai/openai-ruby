# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::BaseClientOriginTest < Minitest::Test
  def setup
    super
    @transport = OpenAI::HTTPClient.new
  end

  def test_rejects_cross_origin_paths_before_selecting_api_key_authentication
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )
    paths = [
      "https://attacker.example/stolen",
      "//attacker.example/stolen",
      "https://trusted.example@attacker.example/stolen?token=fake-query-secret",
      "https://trusted.example:8443/v1/models",
      "http://trusted.example/v1/models",
      "ftp://trusted.example/v1/models"
    ]

    client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
      paths.each { assert_rejected_before_transport(client, _1) }
    end
  end

  def test_rejects_cross_origin_paths_before_selecting_administrator_authentication
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )

    client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
      assert_rejected_before_transport(
        client,
        "//attacker.example/admin",
        security: {admin_api_key_auth: true}
      )
    end
  end

  def test_rejects_cross_origin_paths_before_materializing_workload_identity_tokens
    workload_identity = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "fake-identity-provider",
      service_account_id: "fake-service-account",
      provider: Object.new
    )
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: workload_identity,
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )

    client.workload_identity_auth.stub(:get_token, -> (**) { flunk("Workload token materialized") }) do
      assert_rejected_before_transport(client, "https://attacker.example/stolen")
    end
  end

  def test_rejects_cross_origin_paths_before_materializing_azure_credentials
    provider = OpenAI::Providers.azure(
      endpoint: "https://trusted.openai.azure.com",
      token_provider: -> { flunk("Azure credential materialized") }
    )
    client = OpenAI::Client.new(provider: provider, http_client: @transport)

    assert_rejected_before_transport(client, "//attacker.example/openai/v1/models")
  end

  def test_rejects_cross_origin_paths_before_materializing_bedrock_credentials
    provider = OpenAI::Providers.bedrock(
      region: "us-east-1",
      token_provider: -> { flunk("Bedrock credential materialized") }
    )
    client = OpenAI::Client.new(provider: provider, http_client: @transport)

    assert_rejected_before_transport(client, "https://attacker.example/v1/models")
  end

  def test_realtime_request_rejects_cross_origin_paths_before_authentication
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )

    client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
      error = assert_raises(OpenAI::Errors::Error) do
        client.realtime_connection_request(path: "//attacker.example/realtime", query: {})
      end

      assert_match(/configured base URL origin/, error.message)
    end
  end

  def test_preserves_relative_and_same_origin_absolute_paths_with_custom_transport
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    paths = [
      "models",
      "/v1/models",
      "https://trusted.example/v1/models",
      "//trusted.example/v1/models"
    ]
    paths.each do
      transport.expect(:execute, successful_response) do |request|
        assert_equal("https://trusted.example/v1/models", request.url.to_s)
        assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
        true
      end
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: transport
    )
    paths.each { client.request(method: :get, path: _1) }

    assert_mock(transport)
  end

  def test_preserves_equivalent_default_ports_and_hostname_casing
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    scenarios = [
      ["https://trusted.example/v1", "https://trusted.example:443/v1/models"],
      ["https://trusted.example:443/v1", "https://trusted.example/v1/models"],
      ["https://trusted.example/v1", "https://TRUSTED.EXAMPLE/v1/models"],
      ["https://TRUSTED.example:443/v1", "https://trusted.EXAMPLE/v1/models"],
      ["http://trusted.example/v1", "http://trusted.example:80/v1/models"],
      ["https://[::1]/v1", "https://[::1]:443/v1/models"]
    ]
    scenarios.each do |_base_url, expected_url|
      transport.expect(:execute, successful_response) do |request|
        assert_equal(expected_url, request.url.to_s)
        assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
        true
      end
    end

    scenarios.each do |base_url, path|
      client = OpenAI::Client.new(api_key: "fake-api-key", base_url: base_url, http_client: transport)
      client.request(method: :get, path: path)
    end

    assert_mock(transport)
  end

  def test_preserves_equivalent_ipv6_literals_in_absolute_and_network_paths
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    scenarios = [
      ["http://[::1]:8080/v1", "http://[0:0:0:0:0:0:0:1]:8080/v1/models"],
      ["http://[::1]:8080/v1", "//[0:0:0:0:0:0:0:1]:8080/v1/models"],
      ["http://[0:0:0:0:0:0:0:1]:8080/v1", "http://[::1]:8080/v1/models"],
      ["http://[0:0:0:0:0:0:0:1]:8080/v1", "//[::1]:8080/v1/models"],
      ["https://[2001:db8::1]/v1", "https://[2001:0DB8:0:0:0:0:0:1]:443/v1/models"],
      ["https://[::ffff:127.0.0.1]/v1", "https://[0:0:0:0:0:ffff:7f00:1]/v1/models"]
    ]
    scenarios.each do |base_url, path|
      expected_url = path.start_with?("//") ? "#{URI.parse(base_url).scheme}:#{path}" : path
      transport.expect(:execute, successful_response) do |request|
        assert_equal(expected_url, request.url.to_s)
        assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
        true
      end
    end

    scenarios.each do |base_url, path|
      client = OpenAI::Client.new(api_key: "fake-api-key", base_url: base_url, http_client: transport)
      client.request(method: :get, path: path)
    end

    assert_mock(transport)
  end

  def test_rejects_cross_origin_ipv6_addresses_ports_and_schemes
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://[::1]:8443/v1",
      http_client: @transport
    )
    paths = [
      "https://[::2]:8443/v1/models",
      "//[0:0:0:0:0:0:0:2]:8443/v1/models",
      "https://[0:0:0:0:0:0:0:1]:9443/v1/models",
      "http://[0:0:0:0:0:0:0:1]:8443/v1/models",
      "https://[::ffff:127.0.0.1]:8443/v1/models",
      "https://127.0.0.1:8443/v1/models",
      "https://localhost:8443/v1/models"
    ]

    client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
      paths.each { assert_rejected_before_transport(client, _1) }
    end
  end

  def test_preserves_same_origin_ipvfuture_literals_without_ipv6_canonicalization
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    paths = [
      "models",
      "https://[v1.foo:bar]:8443/v1/models",
      "//[v1.foo:bar]:8443/v1/models"
    ]
    paths.each do
      transport.expect(:execute, successful_response) do |request|
        assert_equal("https://[v1.foo:bar]:8443/v1/models", request.url.to_s)
        assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
        true
      end
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://[v1.foo:bar]:8443/v1",
      http_client: transport
    )
    paths.each { client.request(method: :get, path: _1) }

    assert_mock(transport)
  end

  def test_rejects_cross_origin_ipvfuture_literals_before_authentication
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://[v1.foo:bar]:8443/v1",
      http_client: @transport
    )
    paths = [
      "https://[v1.other:host]:8443/v1/models",
      "//[v1.other:host]:8443/v1/models",
      "https://[v1.foo:bar]:9443/v1/models",
      "http://[v1.foo:bar]:8443/v1/models"
    ]

    client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
      paths.each { assert_rejected_before_transport(client, _1) }
    end
  end

  def test_rejects_origins_trusted_only_by_mutating_the_public_base_url
    scenarios = [
      [-> (url) { url.host = "attacker.example" }, "https://attacker.example/v1/models"],
      [-> (url) { url.host = "attacker.example" }, "//attacker.example/v1/models"],
      [-> (url) { url.scheme = "http" }, "http://trusted.example/v1/models"],
      [-> (url) { url.port = 8443 }, "https://trusted.example:8443/v1/models"]
    ]

    scenarios.each do |mutate, path|
      client = OpenAI::Client.new(
        api_key: "fake-api-key",
        base_url: "https://trusted.example/v1",
        http_client: @transport
      )
      mutate.call(client.base_url)

      client.stub(:auth_headers, -> (security:) { flunk("Authentication selected: #{security}") }) do
        assert_rejected_before_transport(client, path)
      end
    end
  end

  def test_preserves_mutable_public_base_url_without_changing_configured_routing
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    transport.expect(:execute, successful_response) do |request|
      assert_equal("https://trusted.example/v1/models", request.url.to_s)
      assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
      true
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: transport
    )

    client.base_url.host = "modified.example"
    assert_equal("modified.example", client.base_url.host)
    client.request(method: :get, path: "models")

    assert_mock(transport)
  end

  def test_preserves_custom_ports_generated_resource_paths_and_return_types
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(id: "model/identifier", created: 1, object: "model", owned_by: "test")
    )
    transport.expect(:execute, response) do |request|
      assert_equal("https://trusted.example:8443/custom/v2/models/model%2Fidentifier", request.url.to_s)
      assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
      true
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example:8443/custom/v2",
      http_client: transport
    )

    model = client.models.retrieve("model/identifier")

    assert_instance_of(OpenAI::Model, model)
    assert_equal("model/identifier", model.id)
    assert_mock(transport)
  end

  def test_preserves_documented_custom_request_wire_format_and_return_value
    transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: "{\"ok\":true}"
    )
    transport.expect(:execute, response) do |request|
      assert_equal(
        "https://trusted.example:8443/undocumented/endpoint?inline=yes&request=value&extra=value",
        request.url.to_s
      )
      assert_equal("Bearer fake-api-key", request.headers.fetch("authorization"))
      assert_equal("request-value", request.headers.fetch("x-request-header"))
      assert_equal("option-value", request.headers.fetch("x-option-header"))
      assert_equal({"hello" => "world", "extra" => "included"}, JSON.parse(request.body))
      true
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example:8443/v1",
      http_client: transport
    )
    result = client.request(
      method: :post,
      path: "/undocumented/endpoint?inline=yes",
      query: {"request" => "value"},
      headers: {"x-request-header" => "request-value"},
      body: {"hello" => "world"},
      options: {
        extra_query: {"extra" => "value"},
        extra_headers: {"x-option-header" => "option-value"},
        extra_body: {"extra" => "included"}
      }
    )

    assert_equal({ok: true}, result)
    assert_mock(transport)
  end

  def test_preserves_request_and_option_validation_before_origin_validation
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )

    invalid_request = assert_raises(ArgumentError) do
      client.request(method: :get, path: "//attacker.example/stolen", unsupported: true)
    end

    assert_match(/Request `req` keys/, invalid_request.message)

    invalid_options = assert_raises(ArgumentError) do
      client.request(
        method: :get,
        path: "//attacker.example/stolen",
        options: {unsupported: true}
      )
    end

    assert_match(/Request `opts` keys/, invalid_options.message)
  end

  def test_preserves_authentication_errors_for_valid_same_origin_requests
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      base_url: "https://trusted.example/v1",
      http_client: @transport
    )

    error = assert_raises(ArgumentError) do
      client.request(method: :get, path: "models", security: {bearer_auth: true})
    end

    assert_match(/Could not resolve authentication method/, error.message)
  end

  private def assert_rejected_before_transport(client, path, security: {bearer_auth: true})
    unexpected_request = -> (request) { flunk("Unexpected request sent to #{request.url}") }

    @transport.stub(:execute, unexpected_request) do
      error = assert_raises(OpenAI::Errors::Error) do
        client.request(method: :get, path: path, security: security)
      end

      assert_match(/configured base URL origin/, error.message)
      refute_includes(error.message, "fake-api-key")
      refute_includes(error.message, "fake-admin-key")
      refute_includes(error.message, "fake-query-secret")
    end
  end

  private def successful_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: "{}"
    )
  end
end

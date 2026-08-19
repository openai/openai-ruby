# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::BaseClientRedirectTest < Minitest::Test
  def test_rejects_cross_origin_308_redirect_with_multipart_body_and_custom_transport
    destination = "https://example.com/redirected"
    requests = []
    client, http_client = client_with_responses(requests, redirect_response(308, destination))
    file = OpenAI::FilePart.new(StringIO.new("fake-private-file-contents"), filename: "private.txt")

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(
        method: :post,
        path: "uploads",
        headers: {"content-type" => "multipart/form-data"},
        body: {file: file}
      )
    end

    http_client.verify
    assert_equal("https://example.com", error.url.to_s)
    assert_equal("Cannot follow a cross-origin redirect with a request body.", error.message)
    assert_equal(["https://trusted.example/v1/uploads"], requests.map { _1.url.to_s })
    assert_includes(requests.fetch(0).body.to_a.join, "fake-private-file-contents")
  end

  def test_preserves_same_origin_307_and_308_redirect_bodies
    [307, 308].each do |status|
      destination = "https://trusted.example/v1/redirected/#{status}"
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, destination),
        successful_response
      )

      response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal([:post, :post], requests.map(&:method))
      assert_equal(destination, requests.last.url.to_s)
      assert_equal(requests.first.body, requests.last.body)
      assert_includes(requests.last.body, "fake-private-prompt")
      assert_equal("Bearer fake-api-key", requests.last.headers.fetch("authorization"))
    end
  end

  def test_preserves_same_origin_redirect_with_explicit_default_https_port
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://trusted.example:443/v1/redirected"),
      successful_response
    )

    response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal("https://trusted.example/v1/redirected", requests.last.url.to_s)
    assert_equal(requests.first.body, requests.last.body)
    assert_equal("Bearer fake-api-key", requests.last.headers.fetch("authorization"))
  end

  def test_preserves_same_origin_redirect_when_hostname_case_changes
    destination = "https://TRUSTED.EXAMPLE/v1/redirected"
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, destination),
      successful_response
    )

    response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal(destination, requests.last.url.to_s)
    assert_equal(requests.first.body, requests.last.body)
    assert_equal("Bearer fake-api-key", requests.last.headers.fetch("authorization"))
  end

  def test_preserves_bodyless_cross_origin_get_and_head_redirects
    [[:get, 307], [:get, 308], [:head, 307], [:head, 308], [:head, 303]].each do |method, status|
      destination = "https://example.com/redirected/#{method}/#{status}"
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, destination),
        successful_response
      )

      response = client.request(method: method, path: "probe")

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal([method, method], requests.map(&:method))
      assert_equal(destination, requests.last.url.to_s)
      assert_nil(requests.last.body)
      refute_includes(requests.last.headers, "authorization")
    end
  end

  def test_preserves_bodyless_cross_origin_307_post_redirect
    destination = "https://example.com/redirected"
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, destination),
      successful_response
    )

    response = client.request(method: :post, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal([:post, :post], requests.map(&:method))
    assert_nil(requests.last.body)
    refute_includes(requests.last.headers, "authorization")
  end

  def test_converts_cross_origin_301_302_and_303_post_redirects_to_bodyless_gets
    [301, 302, 303].each do |status|
      destination = "https://example.com/redirected/#{status}"
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, destination),
        successful_response
      )

      response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal([:post, :get], requests.map(&:method))
      assert_nil(requests.last.body)
      refute_includes(requests.last.headers, "authorization")
      refute_includes(requests.last.headers, "content-type")
    end
  end

  def test_rejects_cross_origin_redirect_when_only_the_https_port_changes
    destination = "https://trusted.example:444/v1/redirected"
    requests = []
    client, http_client = client_with_responses(requests, redirect_response(307, destination))

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    assert_equal("https://trusted.example:444", error.url.to_s)
    assert_equal("Cannot follow a cross-origin redirect with a request body.", error.message)
    assert_equal(1, requests.length)
  end

  def test_rejects_cross_origin_302_redirect_that_preserves_a_put_body
    destination = "https://example.com/redirected"
    requests = []
    client, http_client = client_with_responses(requests, redirect_response(302, destination))

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :put, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    assert_equal("https://example.com", error.url.to_s)
    assert_equal("Cannot follow a cross-origin redirect with a request body.", error.message)
    assert_equal(1, requests.length)
  end

  def test_rejects_https_downgrade_before_cross_origin_body_check
    destination = "http://example.com/redirected"
    requests = []
    client, http_client = client_with_responses(requests, redirect_response(307, destination))

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    assert_equal("https://trusted.example/v1/probe", error.url.to_s)
    assert_equal("Tried to redirect to a insecure URL", error.message)
    assert_equal(1, requests.length)
  end

  def test_rejected_cross_origin_redirect_closes_response_body
    body = StringIO.new("redirect response")
    response = OpenAI::HTTPClient::Response.new(
      status: 307,
      headers: {"location" => "https://example.com/redirected"},
      body: body
    )
    requests = []
    client, http_client = client_with_responses(requests, response)

    assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    assert_equal(1, requests.length)
    assert_predicate(body, :closed?)
  end

  def test_rejected_cross_origin_redirect_never_logs_customer_or_destination_credentials
    destination = "https://example.com/redirected?access_token=fake-redirect-token"
    requests = []
    output = StringIO.new
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, destination),
      logger: Logger.new(output),
      log_level: :debug
    )

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(
        method: :post,
        path: "probe",
        body: {prompt: "fake-private-prompt", tools: [{authorization: "fake-mcp-oauth-token"}]}
      )
    end

    http_client.verify
    assert_equal("Cannot follow a cross-origin redirect with a request body.", error.message)
    refute_includes(output.string, "fake-private-prompt")
    refute_includes(output.string, "fake-mcp-oauth-token")
    refute_includes(output.string, "fake-redirect-token")
  end

  def test_rejected_cross_origin_redirect_never_retains_destination_credentials_in_exception
    destination = "https://fake-user:fake-password@example.com:8443/private/fake-path-credential" \
      "?access_token=fake-query-token&opaque=fake-opaque-token#fake-fragment-token"
    requests = []
    client, http_client = client_with_responses(requests, redirect_response(307, destination))

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    refute_includes(error.url.to_s, "fake-query-token")
    assert_equal("https://example.com:8443", error.url.to_s)
    assert_nil(error.url.userinfo)
    assert_nil(error.url.query)
    assert_nil(error.url.fragment)

    serialized = Marshal.dump(error)
    %w[fake-password fake-path-credential fake-query-token fake-opaque-token fake-fragment-token].each do |secret|
      refute_includes(serialized, secret)
    end
  end

  private def client_with_responses(requests, *responses, **options)
    http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
    responses.each do |response|
      http_client.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://trusted.example/v1",
      http_client: http_client,
      **options
    )
    [client, http_client]
  end

  private def redirect_response(status, destination)
    OpenAI::HTTPClient::Response.new(status: status, headers: {"location" => destination}, body: "")
  end

  private def successful_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: "{\"ok\":true}"
    )
  end
end

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

  def test_preserves_redirects_within_the_initially_prepared_trusted_origin
    [307, 308].each do |status|
      destination = "https://prepared.example/v1/redirected/#{status}"
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, destination),
        successful_response,
        client_class: origin_rewriting_client_class
      )

      response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal(["prepared.example", "prepared.example"], requests.map { _1.url.host })
      assert_equal(requests.first.body, requests.last.body)
      assert_includes(requests.last.body, "fake-private-prompt")
      assert_equal("Bearer fake-prepared-origin-authorization", requests.last.headers.fetch("Authorization"))
      assert_equal("fake-prepared-origin-api-key", requests.last.headers.fetch("X-Api-Key"))
    end
  end

  def test_rewritten_trusted_origin_still_rejects_body_preserving_cross_origin_redirects
    [307, 308].each do |status|
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, "https://untrusted.example/redirected"),
        client_class: origin_rewriting_client_class
      )

      error = assert_raises(OpenAI::Errors::APIConnectionError) do
        client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
      end

      http_client.verify
      assert_equal("https://untrusted.example", error.url.to_s)
      assert_equal(["prepared.example"], requests.map { _1.url.host })
    end
  end

  def test_rewritten_trusted_origin_strips_prepared_credentials_on_cross_origin_hops
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://prepared.example/v1/same-origin"),
      redirect_response(307, "https://untrusted.example/redirected"),
      successful_response,
      client_class: origin_rewriting_client_class
    )

    response = client.request(method: :get, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal(["prepared.example", "prepared.example", "untrusted.example"], requests.map { _1.url.host })
    assert_equal("Bearer fake-prepared-origin-authorization", requests.fetch(1).headers.fetch("Authorization"))
    %w[authorization cookie x-api-key].each do |header|
      refute(requests.last.headers.keys.any? { _1.casecmp?(header) }, "#{header} reached the untrusted origin")
    end

    assert_equal("safe-trace-value", requests.last.headers.fetch("x-safe-trace"))
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

  def test_preserves_same_origin_redirect_when_ipv6_spelling_changes
    [307, 308].each do |status|
      destination = "https://[::1]/v1/redirected/#{status}"
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, destination),
        successful_response,
        base_url: "https://[0:0:0:0:0:0:0:1]/v1"
      )

      response = client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal(destination, requests.last.url.to_s)
      assert_equal(requests.first.body, requests.last.body)
      assert_equal("Bearer fake-api-key", requests.last.headers.fetch("authorization"))
    end
  end

  def test_rejects_cross_origin_redirect_between_distinct_ipv6_addresses
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://[::2]/v1/redirected"),
      base_url: "https://[0:0:0:0:0:0:0:1]/v1"
    )

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    assert_equal("https://[::2]", error.url.to_s)
    assert_equal(1, requests.length)
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

  def test_rejects_cross_origin_redirect_when_request_preparation_adds_a_body
    [307, 308].each do |status|
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, "https://example.com/redirected"),
        client_class: body_adding_client_class
      )

      error = assert_raises(OpenAI::Errors::APIConnectionError) do
        client.request(method: :post, path: "probe")
      end

      http_client.verify
      assert_equal("https://example.com", error.url.to_s)
      assert_equal(1, requests.length)
      assert_equal("fake-prepared-private-prompt", requests.first.body)
    end
  end

  def test_preserves_same_origin_redirect_when_request_preparation_adds_a_body
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://trusted.example/v1/redirected"),
      successful_response,
      client_class: body_adding_client_class
    )

    response = client.request(method: :post, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal(["fake-prepared-private-prompt", "fake-prepared-private-prompt"], requests.map(&:body))
    assert_equal("Bearer fake-api-key", requests.last.headers.fetch("authorization"))
  end

  def test_preserves_false_json_body_on_same_origin_redirect
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://trusted.example/v1/redirected"),
      successful_response
    )

    response = client.request(method: :post, path: "probe", body: false)

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal(["false", "false"], requests.map(&:body))
  end

  def test_preserves_bodyless_cross_origin_redirect_when_request_preparation_removes_a_body
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(body: nil)
      end
    end

    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://example.com/redirected"),
      successful_response,
      client_class: client_class
    )

    response = client.request(method: :post, path: "probe", body: {prompt: "fake-never-sent-prompt"})

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal([nil, nil], requests.map(&:body))
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

  def test_prevents_request_preparation_from_restoring_body_on_cross_origin_get_redirects
    [301, 302, 303].each do |status|
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, "https://example.com/redirected/#{status}"),
        successful_response,
        client_class: body_adding_client_class
      )

      response = client.request(method: :post, path: "probe")

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal([:post, :get], requests.map(&:method))
      assert_equal("fake-prepared-private-prompt", requests.first.body)
      assert_nil(requests.last.body)
    end
  end

  def test_keeps_converted_same_origin_redirects_bodyless_after_preparation
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(
          method: redirect_count.positive? ? :post : prepared.fetch(:method),
          body: "fake-prepared-private-prompt"
        )
      end
    end

    [[:post, 301, :get], [:post, 302, :get], [:post, 303, :get], [:head, 303, :head]].each do |
        method,
        status,
        next_method
      |
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(status, "https://trusted.example/v1/redirected/#{status}"),
        successful_response,
        client_class: client_class
      )

      response = client.request(method: method, path: "probe")

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal([method, next_method], requests.map(&:method))
      assert_equal("fake-prepared-private-prompt", requests.first.body)
      assert_nil(requests.last.body)
    end
  end

  def test_preserves_authorized_cross_origin_url_without_preparer_credentials_on_retry
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        return prepared if redirect_count.zero?

        url = prepared.fetch(:url)
        url.user = "fake-prepared-user"
        url.password = "fake-prepared-password"
        url.query = "#{url.query}&api_key=fake-prepared-query-key&opaque=fake-prepared-opaque-secret"
        prepared.merge(url: url)
      end
    end

    destination = "https://download.example/file?download=public&signature=fake-authorized-signature"
    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, destination),
      OpenAI::HTTPClient::Response.new(status: 500, headers: {}, body: ""),
      successful_response,
      client_class: client_class,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    response = client.request(method: :get, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    requests.drop(1).each do |request|
      assert_equal(destination, request.url.to_s)
      assert_nil(request.url.userinfo)
      refute_includes(request.url.query, "fake-prepared-query-key")
      refute_includes(request.url.query, "fake-prepared-opaque-secret")
    end
  end

  def test_prevents_redirect_preparation_from_escaping_the_authorized_origin
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        return prepared if redirect_count.zero?

        url = prepared.fetch(:url)
        url.host = "escaped.example"
        url.query = "api_key=fake-escaped-query-key"
        prepared.merge(url: url)
      end
    end

    ["https://download.example/file?download=public", "https://trusted.example/v1/file?download=public"].each do |
        destination
      |
      requests = []
      client, http_client = client_with_responses(
        requests,
        redirect_response(307, destination),
        successful_response,
        client_class: client_class
      )

      response = client.request(method: :get, path: "probe")

      http_client.verify
      assert_equal(true, response[:ok])
      assert_equal(destination, requests.last.url.to_s)
      refute_includes(requests.last.url.to_s, "fake-escaped-query-key")
    end
  end

  def test_preserves_same_origin_redirect_url_changes_during_preparation
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        return prepared if redirect_count.zero?

        url = prepared.fetch(:url)
        url.query = "safe_provider_parameter=fake-provider-value"
        prepared.merge(url: url)
      end
    end

    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://trusted.example/v1/redirected"),
      successful_response,
      client_class: client_class
    )

    response = client.request(method: :get, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal("safe_provider_parameter=fake-provider-value", requests.last.url.query)
  end

  def test_removes_entity_headers_when_redirect_preparation_restores_a_forbidden_body
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(
          body: "fake-prepared-private-prompt",
          headers: prepared.fetch(:headers).merge(
            "Content-Length" => "28",
            "Transfer-Encoding" => "chunked",
            "Content-Type" => "application/octet-stream",
            "Content-Encoding" => "gzip",
            "Content-Language" => "en",
            "Content-Location" => "/fake-content"
          )
        )
      end
    end

    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(301, "https://download.example/redirected"),
      successful_response,
      client_class: client_class
    )

    response = client.request(method: :post, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_nil(requests.last.body)
    %w[content-length transfer-encoding content-type content-encoding content-language content-location]
      .each do |header|
        refute(requests.last.headers.keys.any? { _1.casecmp?(header) }, "#{header} remained on the bodyless redirect")
      end
  end

  def test_strips_credentials_added_during_cross_origin_redirect_preparation
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(
          headers: prepared.fetch(:headers).merge(
            "Authorization" => "Bearer fake-prepared-authorization",
            "Cookie" => "session=fake-prepared-cookie",
            "X-Api-Key" => "fake-prepared-api-key",
            "x-safe-trace" => "safe-trace-value"
          )
        )
      end
    end

    requests = []
    client, http_client = client_with_responses(
      requests,
      redirect_response(307, "https://example.com/redirected"),
      successful_response,
      client_class: client_class
    )

    response = client.request(method: :get, path: "probe")

    http_client.verify
    assert_equal(true, response[:ok])
    assert_equal("Bearer fake-prepared-authorization", requests.first.headers.fetch("Authorization"))
    %w[authorization cookie x-api-key].each do |header|
      refute(requests.last.headers.keys.any? { _1.casecmp?(header) }, "#{header} reached the redirect")
    end

    assert_equal("safe-trace-value", requests.last.headers.fetch("x-safe-trace"))
  end

  def test_rejects_hostless_and_non_http_redirect_targets
    ["mailto:fake-user@example.com", "ftp://example.com/redirected", "file:///tmp/fake-private-file"].each do |target|
      requests = []
      client, http_client = client_with_responses(requests, redirect_response(307, target))

      error = assert_raises(OpenAI::Errors::APIConnectionError) do
        client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
      end

      http_client.verify
      assert_equal("https://trusted.example/v1/probe", error.url.to_s)
      assert_equal("Server responded with status 307 but no valid location header.", error.message)
      assert_equal(1, requests.length)
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

  def test_rejected_cross_origin_redirect_never_retains_sensitive_response_headers
    response = OpenAI::HTTPClient::Response.new(
      status: 307,
      headers: {
        "location" => "https://example.com/redirected",
        "set-cookie" => "session=fake-session-cookie",
        "x-provider-token" => "fake-provider-token",
        "authorization" => "Bearer fake-response-authorization"
      },
      body: ""
    )
    requests = []
    client, http_client = client_with_responses(requests, response)

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(method: :post, path: "probe", body: {prompt: "fake-private-prompt"})
    end

    http_client.verify
    serialized = Marshal.dump(error)
    %w[fake-session-cookie fake-provider-token fake-response-authorization].each do |secret|
      refute_includes(serialized, secret)
    end
  end

  private def client_with_responses(
    requests,
    *responses,
    base_url: "https://trusted.example/v1",
    client_class: OpenAI::Client,
    **options
  )
    http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
    responses.each do |response|
      http_client.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    client = client_class.new(
      api_key: "fake-api-key",
      base_url: base_url,
      http_client: http_client,
      **options
    )
    [client, http_client]
  end

  private def body_adding_client_class
    Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        raise "internal redirect body policy reached a preparer" if request.key?(:redirect_body_forbidden)

        prepared = super
        prepared.merge(body: "fake-prepared-private-prompt")
      end
    end
  end

  private def origin_rewriting_client_class
    Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        if [:redirect_trusted_origin, :redirect_body_forbidden].any? { request.key?(_1) }
          raise "internal redirect policy reached a preparer"
        end

        prepared = super
        if redirect_count.zero?
          rewritten_url = prepared.fetch(:url).dup
          rewritten_url.host = "prepared.example"
          prepared = prepared.merge(url: rewritten_url)
        end

        prepared.merge(
          headers: prepared.fetch(:headers).merge(
            "Authorization" => "Bearer fake-prepared-origin-authorization",
            "Cookie" => "session=fake-prepared-origin-cookie",
            "X-Api-Key" => "fake-prepared-origin-api-key",
            "x-safe-trace" => "safe-trace-value"
          )
        )
      end
    end
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

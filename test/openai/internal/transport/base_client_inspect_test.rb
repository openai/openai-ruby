# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::BaseClientInspectTest < Minitest::Test
  def test_inspect_omits_base_url_userinfo_and_fragment
    client = new_client(
      "https://fake-user:fake-password@example.test/v1#access_token=fake-fragment-token"
    )

    inspected = client.inspect

    assert_includes(inspected, "base_url=https://example.test/v1")
    refute_includes(inspected, "fake-user")
    refute_includes(inspected, "fake-password")
    refute_includes(inspected, "fake-fragment-token")
    refute_includes(inspected, "#access_token")
    assert_includes(client.base_url.to_s, "fake-user:fake-password@")
    assert_equal("access_token=fake-fragment-token", client.base_url.fragment)
  end

  def test_inspect_redacts_sensitive_base_url_query_values
    client = new_client(
      "https://example.test/v1?X-Amz-Signature=fake-signature&" \
        "access_token=fake-access-token&safe=visible"
    )

    inspected = client.inspect

    assert_includes(inspected, "X-Amz-Signature=%5BREDACTED%5D")
    assert_includes(inspected, "access_token=%5BREDACTED%5D")
    assert_includes(inspected, "safe=visible")
    refute_includes(inspected, "fake-signature")
    refute_includes(inspected, "fake-access-token")
  end

  def test_inspect_preserves_ordinary_base_url_diagnostics
    client = new_client("https://example.test:8443/custom/v2?region=us")

    inspected = client.inspect

    assert_match(/\A#<OpenAI::Client:0x[0-9a-f]+ /, inspected)
    assert_includes(
      inspected,
      "base_url=https://example.test:8443/custom/v2?region=us max_retries=2 timeout=600.0>"
    )
  end

  def test_inspect_redacts_a_normalized_malformed_base_url_query
    client = new_client("https://example.test/v1?token=fake-query-secret%GG")

    inspected = client.inspect

    assert_includes(inspected, "base_url=https://example.test/v1?token=%5BREDACTED%5D max_retries=")
    refute_includes(inspected, "fake-query-secret")
    assert_equal("token=fake-query-secret%25GG", client.base_url.query)
  end

  def test_malformed_base_url_still_raises
    assert_raises(URI::InvalidURIError) { new_client("https://[") }
  end

  private def new_client(base_url)
    OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: base_url,
      http_client: OpenAI::HTTPClient.new
    )
  end
end

# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509ClientSecurityTest < Minitest::Test
  def setup
    super
    @native = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)
    @identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "fake-sensitive-provider-id",
      service_account_id: "fake-sensitive-service-account-id"
    )
  end

  def teardown
    @native.close
    super
  end

  def test_authentication_timeouts_redact_signed_query_and_fragment_without_mutating_request
    client_class = Class.new(OpenAI::Client) do
      attr_reader(:original_url)

      private def build_request(request, options)
        built = super
        @original_url = built.fetch(:url)
        @original_url.fragment = "fake-sensitive-fragment"
        built
      end
    end

    client = client_class.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      timeout: 0.01,
      max_retries: 1
    )
    response = OpenAI::HTTPClient::Response.new(status: 429, headers: {"retry-after" => "60"}, body: "")

    error = @native.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::APITimeoutError) do
        client.models.retrieve(
          "fake-model",
          request_options: {extra_query: {"signature" => "fake-sensitive-query"}}
        )
      end
    end

    assert_equal("https://mtls.api.openai.com/v1/models/fake-model", error.url.to_s)
    assert_nil(error.url.query)
    assert_nil(error.url.fragment)
    assert_match(/fake-sensitive-query/, client.original_url.query)
    assert_equal("fake-sensitive-fragment", client.original_url.fragment)
    refute_match(/fake-sensitive-query|fake-sensitive-fragment/, error.inspect)
    assert_nil(error.cause)
  end

  def test_workload_identity_and_token_exchange_inspection_redacts_configuration
    exchange = OpenAI::Auth::X509TokenExchange.new(@identity, transport: @transport)

    [@identity, exchange].each do |object|
      expected = "#<#{object.class.name}:0x#{object.object_id.to_s(16)}>"

      assert_equal(expected, object.inspect)
      assert_match(/\A#<#{Regexp.escape(object.class.name)}:0x[0-9a-f]+>\z/, object.to_s)
      refute_includes(object.inspect, @identity.identity_provider_id)
      refute_includes(object.inspect, @identity.service_account_id)
    end
  end

  def test_authentication_timeout_messages_never_expose_underlying_customer_data
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    failure = -> (_request) { raise Timeout::Error, "fake-sensitive-signed-query=secret" }

    error = @native.stub(:execute, failure) do
      assert_raises(OpenAI::Errors::APITimeoutError) do
        client.models.retrieve("fake-model")
      end
    end

    assert_match(/timed out during workload identity authentication/, error.message)
    refute_includes(error.message, "fake-sensitive-signed-query")
    refute_includes(error.full_message(highlight: false), "fake-sensitive-signed-query")
    assert_nil(error.cause)
  end
end

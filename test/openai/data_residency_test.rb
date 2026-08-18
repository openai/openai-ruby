# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::DataResidencyTest < Minitest::Test
  extend Minitest::Serial

  URLS = {
global: "https://api.openai.com/v1",
us: "https://us.api.openai.com/v1",
eu: "https://eu.api.openai.com/v1",
ae: "https://ae.api.openai.com/v1"
}.freeze
  CUSTOM_URL = "https://example.com/v1"
  ENVIRONMENT_VARIABLES = [
    "OPENAI_API_KEY", "OPENAI_ADMIN_KEY", "OPENAI_BASE_URL", "OPENAI_CUSTOM_HEADERS",
    "OPENAI_ORG_ID", "OPENAI_PROJECT_ID", "OPENAI_WEBHOOK_SECRET", "OPENAI_LOG"
  ].freeze

  class Capture < OpenAI::HTTPClient
    attr_reader :requests

    def initialize
      super
      @requests = []
    end

    def execute(request)
      @requests << request
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: ['{"id":"resp_test","object":"response","output":[]}']
      )
    end
  end

  def setup
    super
    @environment = ENVIRONMENT_VARIABLES.to_h { [_1, ENV[_1]] }
    ENVIRONMENT_VARIABLES.each { ENV.delete(_1) }
    @transport = Capture.new
  end

  def teardown
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    super
  end

  def test_constructor_and_copy_accept_every_symbol_and_string
    original = new_client(base_url: CUSTOM_URL)

    URLS.each do |region, url|
      [region, region.to_s].each do |value|
        [new_client(data_residency: value), original.with_options(data_residency: value)].each do |client|
          client.responses.create(model: "gpt-5.6-sol", input: "Hello")
          request = @transport.requests.last
          assert_equal("#{url}/responses", request.url.to_s)
          assert_equal("Bearer test-key", request.headers["authorization"])
          refute(request.headers.keys.any? { _1.include?("residency") })
          assert_equal({"model" => "gpt-5.6-sol", "input" => "Hello"}, JSON.parse(request.body))
          assert_same(@transport, client.requester)
          refute_includes(client.instance_variable_get(:@copy_options), :data_residency)
        end
      end
    end

    assert_equal(CUSTOM_URL, original.base_url.to_s)
  end

  def test_explicit_base_url_conflicts_in_either_keyword_order
    original = new_client
    [CUSTOM_URL, nil].each do |url|
      [
        {data_residency: :eu, base_url: url},
        {base_url: url, data_residency: :eu}
      ].each do |options|
        error = assert_raises(ArgumentError) { new_client(**options) }
        assert_match(/mutually exclusive/, error.message)
        error = assert_raises(ArgumentError) { original.with_options(**options) }
        assert_match(/mutually exclusive/, error.message)
      end
    end
  end

  def test_nil_is_a_no_op_and_environment_is_not_an_explicit_url
    ENV["OPENAI_BASE_URL"] = CUSTOM_URL
    assert_equal(CUSTOM_URL, new_client(data_residency: nil).base_url.to_s)
    assert_equal(CUSTOM_URL, new_client(base_url: CUSTOM_URL, data_residency: nil).base_url.to_s)
    assert_equal(URLS[:eu], new_client(data_residency: :eu).base_url.to_s)

    original = new_client
    ENV["OPENAI_BASE_URL"] = URLS[:us]
    assert_equal(CUSTOM_URL, original.with_options(data_residency: nil).base_url.to_s)
    assert_equal(URLS[:eu], original.with_options(data_residency: :eu).base_url.to_s)
  end

  def test_copies_keep_only_the_resolved_url
    original = new_client(data_residency: :eu)
    assert_equal(URLS[:eu], original.with_options(timeout: 12).base_url.to_s)
    custom = original.with_options(base_url: CUSTOM_URL)
    assert_equal(CUSTOM_URL, custom.base_url.to_s)
    assert_equal(URLS[:global], custom.with_options(data_residency: :global).base_url.to_s)
    assert_equal(URLS[:ae], custom.with_options(data_residency: :ae).base_url.to_s)
    assert_equal(URLS[:eu], original.base_url.to_s)
  end

  def test_regional_copies_preserve_client_subclasses
    client_class = Class.new(OpenAI::Client) do
      private def auth_headers(security:)
        super.merge("x-subclass-auth" => "preserved")
      end
    end
    original = client_class.new(api_key: "test-key", data_residency: :us, http_client: @transport)
    copy = original.with_options(data_residency: :eu)
    copy.responses.create(model: "gpt-5.6-sol", input: "Hello")

    assert_instance_of(client_class, copy)
    assert_instance_of(client_class, copy.with_options(data_residency: :global))
    assert_equal("#{URLS[:eu]}/responses", @transport.requests.last.url.to_s)
    assert_equal("preserved", @transport.requests.last.headers["x-subclass-auth"])
    assert_equal(URLS[:us], original.base_url.to_s)
    assert_same(@transport, copy.requester)
  end

  def test_unknown_values_fail_without_making_requests
    original = new_client
    [:uk, "EU", "", false, 1, Object.new].each do |value|
      error = assert_raises(ArgumentError) { new_client(data_residency: value) }
      assert_includes(error.message, URLS.keys.join(", "))
      assert_raises(ArgumentError) { original.with_options(data_residency: value) }
    end
    assert_empty(@transport.requests)
  end

  def test_provider_conflicts_and_explicit_provider_switching
    providers = [
      OpenAI::Providers.azure(endpoint: "https://provider.example.test", api_key: "azure-key"),
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-key")
    ]
    providers.each do |provider|
      error = assert_raises(ArgumentError) { OpenAI::Client.new(provider: provider, data_residency: :eu) }
      assert_match(/cannot be combined with `provider`/, error.message)
      client = OpenAI::Client.new(provider: provider, http_client: @transport)
      assert_raises(ArgumentError) { client.with_options(data_residency: :eu) }
      assert_raises(ArgumentError) { new_client.with_options(provider: provider, data_residency: :eu) }
      assert_equal(client.base_url, client.with_options(data_residency: nil).base_url)

      switched = client.with_options(provider: nil, api_key: "test-key", data_residency: :eu)
      assert_equal(URLS[:eu], switched.base_url.to_s)
      assert_same(@transport, switched.requester)
      assert_equal(client.base_url, switched.with_options(provider: provider).base_url)
    end
  end

  private def new_client(**options)
    OpenAI::Client.new(api_key: "test-key", http_client: @transport, **options)
  end
end

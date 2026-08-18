# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ClientOptionsTest < Minitest::Test
  extend Minitest::Serial

  GLOBAL = "https://api.openai.com/v1"
  EU = "https://eu.api.openai.com/v1"
  US = "https://us.api.openai.com/v1"
  ENVIRONMENT_VARIABLES = %w[
    OPENAI_API_KEY OPENAI_ADMIN_KEY OPENAI_BASE_URL OPENAI_CUSTOM_HEADERS
    OPENAI_ORG_ID OPENAI_PROJECT_ID OPENAI_WEBHOOK_SECRET OPENAI_LOG OPENAI_MODEL
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
        body: [JSON.generate({
          id: "resp_test", object: "response",
          output: [{type: "message", id: "msg_test", role: "assistant", status: "completed",
                    content: [{type: "output_text", text: "Hello from the EU!", annotations: []}]}]
        })]
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

  def test_regional_copies_keep_the_original_and_rebuild_resources
    client = new_client
    eu = client.with_options(base_url: EU)
    us = eu.with_options(base_url: US)

    [eu, us, client].each do |selected|
      selected.responses.create(model: "gpt-4.1-mini", input: "Hello")
    end

    assert_equal([EU, US, GLOBAL].map { "#{_1}/responses" }, @transport.requests.map { _1.url.to_s })
    assert_equal(GLOBAL, client.base_url.to_s)
    assert_equal(EU, eu.base_url.to_s)
    assert_same(@transport, eu.requester)
    refute_same(client.responses, eu.responses)
    assert(@transport.requests.all? { _1.headers["authorization"] == "Bearer test-key" })
  end

  def test_copy_without_overrides_preserves_every_constructor_option
    logger = Logger.new(StringIO.new)
    callback = ->(_event) { nil }
    client = new_client(
      admin_api_key: "admin-key", organization: "org", project: "project", webhook_secret: "secret",
      default_headers: {"x-test" => "value"}, max_retries: 4, timeout: nil,
      initial_retry_delay: 0.1, max_retry_delay: 2.0,
      logger: logger, log_level: :debug, on_retry: callback
    )
    copy = client.with_options

    [:api_key, :admin_api_key, :organization, :project, :webhook_secret, :base_url, :headers, :max_retries,
     :timeout, :initial_retry_delay, :max_retry_delay, :logger, :log_level, :on_retry, :requester].each do |name|
      expected = client.public_send(name)
      actual = copy.public_send(name)
      expected.nil? ? assert_nil(actual, "#{name} was not inherited") : assert_equal(expected, actual, "#{name} was not inherited")
    end
    refute_same(client, copy)
    refute_same(client.headers, copy.headers)
    assert_same(callback, copy.on_retry)
    constructor_options = OpenAI::Client.instance_method(:initialize).parameters.filter_map do |kind, name|
      name if [:key, :keyreq].include?(kind)
    end
    # Residency is normalized into base_url, never retained as competing state.
    assert_equal((constructor_options - [:data_residency]).sort, client.instance_variable_get(:@copy_options).keys.sort)
  end

  def test_copy_preserves_subclass_request_behavior
    client_class = Class.new(OpenAI::Client) do
      private def auth_headers(security:)
        super.merge("x-subclass-auth" => "preserved")
      end

      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(headers: prepared[:headers].merge("x-subclass-request" => "preserved"))
      end
    end
    original = client_class.new(api_key: "test-key", base_url: GLOBAL, http_client: @transport)
    copy = original.with_options(base_url: EU)
    copy.responses.create(model: "gpt-4.1-mini", input: "Hello")

    assert_instance_of(client_class, copy)
    assert_instance_of(client_class, copy.with_options)
    assert_same(@transport, copy.requester)
    refute_same(original.responses, copy.responses)
    assert_equal("#{EU}/responses", @transport.requests.last.url.to_s)
    assert_equal("preserved", @transport.requests.last.headers["x-subclass-auth"])
    assert_equal("preserved", @transport.requests.last.headers["x-subclass-request"])
    assert_equal(GLOBAL, original.base_url.to_s)
  end

  def test_subclasses_with_extra_constructor_state_must_handle_copying
    client_class = Class.new(OpenAI::Client) do
      def initialize(label:, **options)
        raise ArgumentError, "missing label" if label.empty?
        super(**options)
      end
    end
    original = client_class.new(label: "shared", api_key: "test-key", http_client: @transport)

    assert_raises(ArgumentError) { original.with_options(base_url: EU) }
  end

  def test_subclasses_with_private_constructors_must_handle_copying
    client_class = Class.new(OpenAI::Client)
    original = client_class.new(api_key: "test-key", http_client: @transport)
    client_class.private_class_method(:new)

    assert_raises(NoMethodError) { original.with_options(base_url: EU) }
  end

  def test_eu_example_runs_with_the_mock_transport
    original_new = OpenAI::Client.method(:new)
    constructor = ->(**options) { original_new.call(api_key: "test-key", http_client: @transport, **options) }
    stdout, = capture_io do
      OpenAI::Client.stub(:new, constructor) do
        load(File.expand_path("../../examples/eu_residency.rb", __dir__))
      end
    end

    assert_equal("Hello from the EU!\n", stdout)
    assert_equal(["#{EU}/responses"], @transport.requests.map { _1.url.to_s })
  end

  def test_explicit_nil_and_transport_replacement
    client = new_client(organization: "org", project: "project", timeout: 30)
    replacement = Capture.new
    copy = client.with_options(organization: nil, project: nil, timeout: nil, http_client: replacement)

    assert_nil(copy.organization)
    assert_nil(copy.project)
    assert_nil(copy.timeout)
    assert_same(replacement, copy.requester)
    assert_equal(30, client.timeout)
    refute_same(@transport, client.with_options(http_client: nil).requester)
    assert_raises(ArgumentError) { client.with_options(not_an_option: true) }
  end

  def test_headers_merge_remove_and_clear_without_mutating_the_original
    client = new_client(default_headers: {"X-One" => "one", "X-Two" => "two"})
    copy = client.with_options(default_headers: {:"x-one" => "changed", "x-two" => nil})
    probe(copy)
    headers = @transport.requests.last.headers

    assert_equal("changed", headers["x-one"])
    refute_includes(headers, "x-two")
    assert_equal("one", client.headers["x-one"])
    assert_equal("two", client.headers["x-two"])
    probe(copy.with_options(default_headers: nil))
    refute_includes(@transport.requests.last.headers, "x-one")
    assert_equal("Bearer test-key", @transport.requests.last.headers["authorization"])
  end

  def test_copies_do_not_reread_environment_defaults
    ENV["OPENAI_API_KEY"] = "initial-key"
    ENV["OPENAI_ORG_ID"] = "initial-org"
    ENV["OPENAI_CUSTOM_HEADERS"] = "x-initial: initial\nx-remove: original"
    client = OpenAI::Client.new(http_client: @transport, default_headers: {"x-remove" => nil})
    ENV["OPENAI_API_KEY"] = "changed-key"
    ENV["OPENAI_ORG_ID"] = "changed-org"
    ENV["OPENAI_BASE_URL"] = US
    ENV["OPENAI_CUSTOM_HEADERS"] = "x-added: unwanted\nx-initial: changed\nx-remove: resurrected"
    probe(client.with_options(base_url: EU))

    headers = @transport.requests.last.headers
    assert_equal("Bearer initial-key", headers["authorization"])
    assert_equal("initial-org", headers["openai-organization"])
    assert_equal("initial", headers["x-initial"])
    refute_includes(headers, "x-added")
    refute_includes(headers, "x-remove")
  end

  def test_workload_identity_configuration_is_retained_and_can_be_replaced
    identity = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "provider", service_account_id: "account", provider: Object.new
    )
    client = new_client(api_key: nil, workload_identity: identity)
    copy = client.with_options(base_url: EU)

    refute_nil(copy.workload_identity_auth)
    assert_same(identity, copy.instance_variable_get(:@copy_options)[:workload_identity])
    assert_nil(copy.with_options(api_key: "new-key").workload_identity_auth)
    assert_nil(new_client.with_options(workload_identity: identity).instance_variable_get(:@copy_options)[:api_key])
    assert_raises(ArgumentError) { client.with_options(api_key: "key", workload_identity: identity) }
  end

  def test_changing_credentials_discards_inherited_credential_headers
    client = new_client(default_headers: {"x-api-key" => "old-secret", "x-label" => "keep"})
    probe(client.with_options(api_key: "new-key"))
    headers = @transport.requests.last.headers

    assert_equal("Bearer new-key", headers["authorization"])
    refute_includes(headers, "x-api-key")
    assert_equal("keep", headers["x-label"])
    assert_equal("old-secret", client.headers["x-api-key"])
  end

  def test_provider_copies_keep_provider_authentication_and_validation
    provider = OpenAI::Providers.azure(endpoint: "https://example.openai.azure.com", api_key: "azure-key")
    client = OpenAI::Client.new(provider: provider, http_client: @transport)
    copy = client.with_options(timeout: 12)
    probe(copy)

    assert_equal("https://example.openai.azure.com/openai/v1/probe", @transport.requests.last.url.to_s)
    assert_equal("azure-key", @transport.requests.last.headers["api-key"])
    assert_same(@transport, copy.requester)
    assert_raises(ArgumentError) { client.with_options(base_url: EU) }
    assert_raises(ArgumentError) { client.with_options(api_key: "openai-key") }
  end

  def test_switching_providers_does_not_leak_previous_configuration
    original = new_client(
      admin_api_key: "admin-key", organization: "org", project: "project",
      default_headers: {"x-api-key" => "old-secret", "x-private" => "old-value"}
    )
    provider = OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-key")
    bedrock = original.with_options(provider: provider)
    probe(bedrock)
    headers = @transport.requests.last.headers

    assert_equal("Bearer bedrock-key", headers["authorization"])
    %w[x-api-key x-private openai-organization openai-project].each { refute_includes(headers, _1) }
    assert_raises(ArgumentError) { bedrock.with_options(provider: nil) }
    probe(bedrock.with_options(provider: nil, api_key: "new-key", base_url: EU))
    assert_equal("#{EU}/probe", @transport.requests.last.url.to_s)
    assert_equal("Bearer new-key", @transport.requests.last.headers["authorization"])
    assert_equal("admin-key", original.admin_api_key)
  end

  private def new_client(**options)
    OpenAI::Client.new(api_key: "test-key", base_url: GLOBAL, http_client: @transport, **options)
  end

  private def probe(client)
    client.request(method: :get, path: "probe", security: {bearer_auth: true})
  end
end

# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::VertexProviderTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @old_env = %w[OPENAI_API_KEY OPENAI_ADMIN_KEY OPENAI_BASE_URL OPENAI_ORG_ID].to_h { [_1, ENV[_1]] }
    ENV["OPENAI_API_KEY"] = "fake-ambient-key"
    ENV["OPENAI_ADMIN_KEY"] = "fake-ambient-admin"
    ENV["OPENAI_BASE_URL"] = "https://wrong.invalid/v1"
    ENV["OPENAI_ORG_ID"] = "fake-ambient-org"
  end

  def teardown
    WebMock.reset!
    @old_env.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_responses_routing_and_refresh_per_attempt
    base = "https://us-east5-aiplatform.googleapis.com/v1/projects/test/locations/us-east5/publishers/openai/v1"
    beta = base.sub("/v1/projects/", "/v1beta1/projects/")
    calls = 0
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(
        project: "test",
        location: "us-east5",
        token_provider: -> { "fake-#{calls += 1}" }
      ),
      max_retries: 1
    )
    stub_request(:post, "#{base}/responses")
      .with(headers: {"Authorization" => "Bearer fake-1"})
      .to_return(status: 503, headers: {"retry-after" => "0"})
    stub_request(:post, "#{base}/responses")
      .with(headers: {"Authorization" => "Bearer fake-2"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})
    stub_request(:get, "#{beta}/responses/resp_test")
      .with(headers: {"Authorization" => "Bearer fake-3"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})
    stub_request(:delete, "#{beta}/responses/resp_test")
      .with(headers: {"Authorization" => "Bearer fake-4"})
      .to_return_json(status: 200, body: {id: "resp_test", deleted: true})
    assert_equal("resp_test", client.responses.create(model: "caller-model", input: "hello").id)
    assert_equal("resp_test", client.responses.retrieve("resp_test").id)
    client.responses.delete("resp_test")
    assert_equal(4, calls)
    assert_requested(:post, "#{base}/responses", times: 2) do |request|
      assert_nil(request.headers["Openai-Organization"])
      assert_equal("caller-model", JSON.parse(request.body).fetch("model"))
      true
    end
  end

  def test_domain_scoped_project_routes_responses
    %w[global us-east5].each do |location|
      host = location == "global" ? "aiplatform.googleapis.com" : "#{location}-aiplatform.googleapis.com"
      base = "https://#{host}/v1/projects/example.com:my-project/locations/#{location}/publishers/openai/v1"
      stub_request(:post, "#{base}/responses")
        .with(headers: {"Authorization" => "Bearer fake-token"})
        .to_return_json(status: 200, body: {id: "resp_test", output: []})
      client = OpenAI::Client.new(
        provider: OpenAI::Providers.vertex(
          project: "example.com:my-project",
          location: location,
          token_provider: -> { "fake-token" }
        ),
        max_retries: 0
      )
      assert_equal("resp_test", client.responses.create(model: "caller-model").id)
      assert_requested(:post, "#{base}/responses", times: 1)
    end
  end

  def test_project_and_location_reject_url_delimiters
    [nil, "", "../other", "project/other", "project?query", "project#fragment", "project%2Fother", "project\\other"].each do |
        value
      |
      assert_raises(ArgumentError) do
        OpenAI::Providers.vertex(project: value, location: "global", token_provider: -> { "fake-token" })
      end

      assert_raises(ArgumentError) do
        OpenAI::Providers.vertex(
          project: "example.com:my-project",
          location: value,
          token_provider: -> { "fake-token" }
        )
      end
    end

    %w[example.com example:443].each do |location|
      assert_raises(ArgumentError) do
        OpenAI::Providers.vertex(project: "test", location: location, token_provider: -> { "fake-token" })
      end
    end
  end

  def test_vertex_constructor_and_copy_reject_openai_residency_before_auth
    calls = 0
    provider = OpenAI::Providers.vertex(
      project: "test",
      location: "global",
      token_provider: -> { "fake-#{calls += 1}" }
    )
    assert_raises(ArgumentError) { OpenAI::Client.new(provider: provider, data_residency: :eu) }
    client = OpenAI::Client.new(provider: provider)
    assert_raises(ArgumentError) { client.with_options(data_residency: :eu) }
    assert_equal(0, calls)
    assert_not_requested(:post, "https://eu.api.openai.com/v1/responses")
    assert_not_requested(
      :post,
      "https://aiplatform.googleapis.com/v1/projects/test/locations/global/publishers/openai/v1/responses"
    )
  end

  def test_explicit_conflicts_and_redirects_do_not_send_credentials_elsewhere
    calls = 0
    provider = OpenAI::Providers.vertex(
      base_url: "https://trusted.example/v1",
      token_provider: -> { "fake-#{calls += 1}" }
    )
    assert_raises(ArgumentError) { OpenAI::Client.new(provider: provider, api_key: "fake-other") }
    assert_raises(ArgumentError) { OpenAI::Client.new(provider: provider, base_url: "https://wrong.invalid/v1") }

    client = OpenAI::Client.new(provider: provider, max_retries: 0)
    assert_raises(OpenAI::Errors::Error) do
      client
        .responses
        .create(model: "caller-model", request_options: {extra_headers: {"Authorization" => "Bearer fake-other"}})
    end

    assert_raises(OpenAI::Errors::Error) do
      client.responses.create(model: "caller-model", request_options: {extra_headers: {"aPi-KeY" => "fake-other"}})
    end

    inherited = OpenAI::Client.new(provider: provider, default_headers: {"Api-Key" => "fake-other"})
    assert_raises(OpenAI::Errors::Error) { inherited.responses.create(model: "caller-model") }

    assert_equal(0, calls)
    stub_request(:post, "https://trusted.example/v1/responses")
      .to_return(status: 307, headers: {"Location" => "https://wrong.invalid/v1/responses"})
    assert_raises(OpenAI::Errors::APIStatusError) { client.responses.create(model: "caller-model") }
    assert_equal(1, calls)
    assert_not_requested(:post, "https://wrong.invalid/v1/responses")
  end

  def test_remote_http_base_url_supports_test_roots
    base_url = "http://vertex.example.test/v1"
    stub_request(:post, "#{base_url}/responses")
      .with(headers: {"Authorization" => "Bearer fake-token"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})

    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(base_url: base_url, token_provider: -> { "fake-token" }),
      max_retries: 0
    )
    assert_equal("resp_test", client.responses.create(model: "caller-model").id)
  end

  def test_exhausted_timeout_rejects_before_authentication
    calls = 0
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(
        base_url: "https://trusted.example/v1",
        token_provider: -> { "fake-#{calls += 1}" }
      ),
      max_retries: 0
    )

    [-0.01, 0.0].each do |timeout|
      assert_raises(OpenAI::Errors::APITimeoutError) do
        client.responses.create(model: "caller-model", request_options: {timeout: timeout})
      end
    end

    assert_equal(0, calls)
    assert_not_requested(:post, "https://trusted.example/v1/responses")
  end

  def test_disabled_timeout_still_resolves_credentials
    calls = 0
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(
        base_url: "https://trusted.example/v1",
        token_provider: -> { "fake-#{calls += 1}" }
      ),
      max_retries: 0
    )
    stub_request(:post, "https://trusted.example/v1/responses")
      .with(headers: {"Authorization" => "Bearer fake-1"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})
    response = client.responses.create(model: "caller-model", request_options: {timeout: nil})
    assert_equal("resp_test", response.id)
    assert_equal(1, calls)
  end

  def test_native_credentials_use_quota_and_cancel_credential_resolution
    calls = 0
    # Matches the public Google Auth apply!/quota interface without loading
    # optional gems into the normal OpenAI client dependency set.
    credentials = Object.new
    credentials.define_singleton_method(:quota_project_id) { "fake-billing" }
    credentials.define_singleton_method(:apply!) do |headers|
      calls += 1
      headers[:authorization] = "Bearer fake-#{calls}"
    end

    provider = OpenAI::Providers.vertex(base_url: "https://trusted.example/v1", credentials: credentials)
    client = OpenAI::Client.new(provider: provider, organization: "fake-org", project: "fake-project", max_retries: 0)
    stub_request(:post, "https://trusted.example/v1/responses")
      .with do |req|
        req.headers["Authorization"] == "Bearer fake-1" &&
          req.headers["X-Goog-User-Project"] == "fake-billing" &&
          !req.headers.key?("Openai-Project") &&
          !req.headers.key?("Openai-Organization")
      end
      .to_return_json(status: 200, body: {id: "resp_test", output: []})
    assert_equal(
      "resp_test",
      client
        .responses
        .create(
          model: "caller-model",
          request_options: {extra_headers: {"OpenAI-Project" => "fake-method", "OpenAI-Organization" => "fake-method"}}
        )
        .id
    )
    assert_raises(ArgumentError) do
      OpenAI::Providers.vertex(
        base_url: "https://trusted.example/v1",
        credentials: credentials,
        token_provider: -> { "fake" }
      )
    end

    stalled = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(
        base_url: "https://trusted.example/v1",
        token_provider: -> {
          _sleep(10)
          "fake"
        }
      ),
      timeout: 0.05,
      max_retries: 0
    )
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    assert_raises(OpenAI::Errors::APITimeoutError) { stalled.responses.create(model: "caller-model") }
    assert_operator(Process.clock_gettime(Process::CLOCK_MONOTONIC) - started, :<, 1)
    assert_requested(:post, "https://trusted.example/v1/responses", times: 1)
  end

  def test_credentials_are_serialized_across_clients_using_one_provider
    assert_shared_credentials_are_serialized { |provider, _client|
      OpenAI::Client.new(provider: provider, max_retries: 0)
    }
  end

  def test_credentials_are_serialized_with_options
    assert_shared_credentials_are_serialized { |_provider, client| client.with_options(max_retries: 0) }
  end

  private def assert_shared_credentials_are_serialized
    release = nil
    first = nil
    entered = Queue.new
    release = Queue.new
    calls = 0
    credentials = Object.new
    credentials.define_singleton_method(:apply!) do |headers|
      calls += 1
      if calls == 1
        entered << true
        release.pop
      end

      headers[:authorization] = "Bearer fake-token"
    end

    provider = OpenAI::Providers.vertex(base_url: "https://trusted.example/v1", credentials: credentials)
    client = OpenAI::Client.new(provider: provider, max_retries: 0)
    other = yield(provider, client)
    stub_request(:post, "https://trusted.example/v1/responses")
      .with(headers: {"Authorization" => "Bearer fake-token"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})

    first = Thread.new { client.responses.create(model: "caller-model") }
    Timeout.timeout(5) { entered.pop }
    assert_raises(OpenAI::Errors::APITimeoutError) do
      other.responses.create(model: "caller-model", request_options: {timeout: 0.05})
    end

    assert_equal(1, calls)
    release << true
    assert_equal("resp_test", Timeout.timeout(5) { first.value }.id)
    assert_equal("resp_test", other.responses.create(model: "caller-model").id)
    assert_equal(2, calls)
  ensure
    release << true if release
    first&.kill
    first&.join
  end

  def test_stream_tool_wire_shape_and_partial_error_are_not_replayed
    response = {id: "resp_test", object: "response", status: "in_progress", output: []}
    events = [
      {type: "response.created", response: response},
      {type: "error", code: "unsupported_feature", message: "fake unsupported", param: nil, sequence_number: 1}
    ]
    body = events.map { "event: #{_1.fetch(:type)}\ndata: #{JSON.generate(_1)}\n\n" }.join
    stub_request(:post, "https://trusted.example/v1/responses")
      .to_return(status: 200, body: body, headers: {"content-type" => "text/event-stream"})
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(base_url: "https://trusted.example/v1", token_provider: -> { "fake" }),
      max_retries: 3
    )
    stream = client.responses.stream(
      model: "caller-model",
      input: "hello",
      tools: [{type: :function, name: "lookup", parameters: {type: :object, properties: {}}}]
    )
    seen = []
    surfaced = false
    begin
      stream.each { seen << _1.type }
    rescue OpenAI::Errors::Error
      # The existing stream parser may raise once it receives an error event.
      surfaced = true
    ensure
      stream.close
    end

    assert_includes(seen, :"response.created")
    assert(surfaced || seen.include?(:error) || seen.include?(:"response.failed"), "stream silently dropped its error")
    assert_requested(:post, "https://trusted.example/v1/responses", times: 1) do |request|
      json = JSON.parse(request.body)
      assert_equal(true, json.fetch("stream"))
      assert_equal("caller-model", json.fetch("model"))
      assert_equal("lookup", json.fetch("tools").first.fetch("name"))
      true
    end
  end

  def test_googleauth_native_refresh_if_optional_gem_is_installed
    begin
      require "googleauth"

    rescue LoadError
      skip("Run with BUNDLE_GEMFILE=gemfiles/vertex.gemfile for real googleauth ADC tests")
    end

    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: "fake-id",
      client_secret: "fake-secret",
      refresh_token: "fake-refresh",
      project_id: "fake-project",
      quota_project_id: "fake-billing",
      scope: "https://www.googleapis.com/auth/cloud-platform",
      token_credential_uri: "https://oauth2.googleapis.com/token"
    )
    token_url = "https://oauth2.googleapis.com/token"
    stub_request(:post, token_url).to_return_json(
      body: {access_token: "fake-access", token_type: "Bearer", expires_in: 3600}
    )
    stub_request(:post, "https://trusted.example/v1/responses")
      .with(headers: {"Authorization" => "Bearer fake-access", "X-Goog-User-Project" => "fake-billing"})
      .to_return_json(status: 200, body: {id: "resp_test", output: []})
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.vertex(base_url: "https://trusted.example/v1", credentials: credentials)
    )
    assert_equal("resp_test", client.responses.create(model: "caller-model").id)
    assert_equal("resp_test", client.responses.create(model: "caller-model").id)
    assert_requested(:post, token_url, times: 1)
    credentials.expires_at = Time.now - 1
    assert_equal("resp_test", client.responses.create(model: "caller-model").id)
    assert_requested(:post, token_url, times: 2)
  end

end

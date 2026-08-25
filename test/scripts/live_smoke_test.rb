# frozen_string_literal: true

require "minitest/autorun"
require "minitest/mock"
require "open3"
require "rbconfig"
require "stringio"
require "yaml"

require_relative "../../scripts/live-smoke"

class LiveSmokeTest < Minitest::Test
  Page = Data.define(:data)
  Response = Data.define(:output_text)

  MODEL = "fake-smoke-model"
  PARAMETERS = {model: MODEL, input: "Reply with exactly OK.", max_output_tokens: 32}.freeze

  def test_exercises_model_listing_regular_responses_and_completed_streaming
    stream = Minitest::Mock.new
    stream.expect(:get_output_text, "fake streamed text")
    responses = Minitest::Mock.new
    responses.expect(:create, Response.new("fake response text"), [], **PARAMETERS)
    responses.expect(:stream, stream, [], **PARAMETERS)
    models = Minitest::Mock.new
    models.expect(:list, Page.new([Object.new]))
    client = Minitest::Mock.new
    client.expect(:models, models)
    client.expect(:responses, responses)
    client.expect(:responses, responses)
    output = StringIO.new

    OpenAILiveSmoke::Runner.new(client: client, model: MODEL, output: output).run

    [client, models, responses, stream].each(&:verify)
    assert_includes(output.string, "authenticated model listing succeeded")
    assert_includes(output.string, "non-streaming response succeeded")
    assert_includes(output.string, "streaming response completed")
    refute_includes(output.string, "fake response text")
    refute_includes(output.string, "fake streamed text")
  end

  def test_rejects_an_empty_model_listing_before_model_requests
    models = Minitest::Mock.new
    models.expect(:list, Page.new([]))
    client = Minitest::Mock.new
    client.expect(:models, models)

    error = assert_raises(OpenAILiveSmoke::Failure) do
      OpenAILiveSmoke::Runner.new(client: client, model: MODEL, output: StringIO.new).run
    end

    assert_equal("model listing returned no accessible models", error.message)
    [client, models].each(&:verify)
  end

  def test_rejects_an_empty_non_streaming_response
    models = Minitest::Mock.new
    models.expect(:list, Page.new([Object.new]))
    responses = Minitest::Mock.new
    responses.expect(:create, Response.new(" \n"), [], **PARAMETERS)
    client = Minitest::Mock.new
    client.expect(:models, models)
    client.expect(:responses, responses)

    error = assert_raises(OpenAILiveSmoke::Failure) do
      OpenAILiveSmoke::Runner.new(client: client, model: MODEL, output: StringIO.new).run
    end

    assert_equal("response creation returned no output text", error.message)
    [client, models, responses].each(&:verify)
  end

  def test_rejects_an_empty_completed_response_stream
    stream = Minitest::Mock.new
    stream.expect(:get_output_text, "")
    responses = Minitest::Mock.new
    responses.expect(:create, Response.new("fake response text"), [], **PARAMETERS)
    responses.expect(:stream, stream, [], **PARAMETERS)
    models = Minitest::Mock.new
    models.expect(:list, Page.new([Object.new]))
    client = Minitest::Mock.new
    client.expect(:models, models)
    client.expect(:responses, responses)
    client.expect(:responses, responses)

    error = assert_raises(OpenAILiveSmoke::Failure) do
      OpenAILiveSmoke::Runner.new(client: client, model: MODEL, output: StringIO.new).run
    end

    assert_equal("response stream returned no completed output text", error.message)
    [client, models, responses, stream].each(&:verify)
  end

  def test_unexpected_errors_never_print_sensitive_exception_messages
    sensitive_message = "FAKE_PRIVATE_RESPONSE sk-fake-test-token"
    models = Minitest::Mock.new
    models.expect(:list, nil) { raise StandardError, sensitive_message }
    client = Minitest::Mock.new
    client.expect(:models, models)
    output = StringIO.new
    error_output = StringIO.new

    success = OpenAILiveSmoke.run_cli(
      client: client,
      model: MODEL,
      output: output,
      error_output: error_output
    )

    refute(success)
    assert_equal("[live-smoke] StandardError\n", error_output.string)
    refute_includes(output.string, sensitive_message)
    refute_includes(error_output.string, sensitive_message)
    [client, models].each(&:verify)
  end

  def test_api_errors_report_only_the_status_and_exception_class
    sensitive_message = "FAKE_PRIVATE_RESPONSE fake-bearer-token"
    failure = OpenAI::Errors::APIError.new(
      url: URI("https://api.openai.com/v1/models?secret=fake-secret"),
      status: 403,
      message: sensitive_message
    )
    models = Minitest::Mock.new
    models.expect(:list, nil) { raise failure }
    client = Minitest::Mock.new
    client.expect(:models, models)
    error_output = StringIO.new

    refute(
      OpenAILiveSmoke.run_cli(
        client: client,
        model: MODEL,
        output: StringIO.new,
        error_output: error_output
      )
    )

    assert_equal("[live-smoke] OpenAI::Errors::APIError (HTTP 403)\n", error_output.string)
    refute_includes(error_output.string, sensitive_message)
    refute_includes(error_output.string, "fake-secret")
    [client, models].each(&:verify)
  end

  def test_untrusted_status_values_cannot_leak_secrets_or_inject_log_lines
    sensitive_status = "403\nfake-sensitive-status-token"
    failure = StandardError.new("fake-sensitive-exception-message")
    failure.define_singleton_method(:status) { sensitive_status }
    models = Minitest::Mock.new
    models.expect(:list, nil) { raise failure }
    client = Minitest::Mock.new
    client.expect(:models, models)
    error_output = StringIO.new

    refute(
      OpenAILiveSmoke.run_cli(
        client: client,
        model: MODEL,
        output: StringIO.new,
        error_output: error_output
      )
    )

    assert_equal("[live-smoke] StandardError\n", error_output.string)
    refute_includes(error_output.string, "fake-sensitive")
    [client, models].each(&:verify)
  end

  def test_client_initialization_errors_never_print_sensitive_base_urls
    sensitive_base_url = "https://[fake-sensitive-base-url-token"
    environment = {
      "OPENAI_API_KEY" => "sk-fake-live-smoke-test",
      "OPENAI_BASE_URL" => sensitive_base_url
    }
    path = File.expand_path("../../scripts/live-smoke.rb", __dir__)

    output, error_output, status = Open3.capture3(environment, RbConfig.ruby, path)

    refute(status.success?)
    assert_empty(output)
    assert_equal("[live-smoke] URI::InvalidURIError\n", error_output)
    refute_includes(error_output, sensitive_base_url)
    refute_includes(error_output, environment.fetch("OPENAI_API_KEY"))
  end

  def test_cli_disables_sdk_debug_logs_even_when_enabled_in_the_environment
    sensitive_body = "fake-sensitive-response-body"
    response = OpenAI::HTTPClient::Response.new(
      status: 400,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(error: {message: sensitive_body})
    )
    transport = OpenAI::NetHTTPClient.new
    requests = []
    dispatch = lambda do |request|
      requests << request
      response
    end

    constructor = OpenAI::Client.method(:new)
    constructed = nil
    factory = lambda do |**options|
      constructed = constructor.call(
        api_key: "sk-fake-live-smoke-test",
        http_client: transport,
        max_retries: 0,
        **options
      )
    end

    previous_log_level = ENV["OPENAI_LOG"]
    ENV["OPENAI_LOG"] = "debug"

    output, error_output = capture_io do
      transport.stub(:execute, dispatch) do
        OpenAI::Client.stub(:new, factory) do
          refute(OpenAILiveSmoke.run_cli(model: MODEL, output: $stdout, error_output: $stderr))
        end
      end
    end

    assert_equal("", output)
    assert_equal("[live-smoke] OpenAI::Errors::BadRequestError (HTTP 400)\n", error_output)
    refute_includes(error_output, sensitive_body)
    assert_equal(:off, constructed.log_level)
    assert_nil(constructed.logger)
    assert_instance_of(OpenAI::HTTPClient::Request, requests.fetch(0))
  ensure
    transport&.close
    previous_log_level.nil? ? ENV.delete("OPENAI_LOG") : ENV["OPENAI_LOG"] = previous_log_level
  end

  def test_manual_workflow_preserves_protected_environment_and_secret_isolation
    path = File.expand_path("../../.github/workflows/live-smoke.yml", __dir__)
    workflow = YAML.safe_load_file(path, aliases: false)
    trigger = workflow.fetch("on", workflow[true])
    jobs = workflow.fetch("jobs")
    api_job = jobs.fetch("live-smoke")
    x509_job = jobs.fetch("x509-live-smoke")
    api_steps = api_job.fetch("steps")
    x509_steps = x509_job.fetch("steps")
    api_step = api_steps.find { _1["name"] == "Smoke-test authenticated API requests and streaming" }
    x509_step = x509_steps.find { _1["name"] == "Smoke-test enrolled X.509 workload identity" }

    assert_equal(["workflow_dispatch"], trigger.keys)
    inputs = trigger.fetch("workflow_dispatch").fetch("inputs")
    assert_equal(["include_x509"], inputs.keys)
    assert_equal(false, inputs.fetch("include_x509").fetch("default"))
    assert_equal({}, workflow.fetch("permissions"))
    assert_equal(%w[live-smoke x509-live-smoke], jobs.keys)
    assert_equal("ci", api_job.fetch("environment"))
    assert_equal("x509-live-smoke", x509_job.fetch("environment"))
    assert_equal("live-smoke", x509_job.fetch("needs"))
    assert_includes(x509_job.fetch("if"), "inputs.include_x509")

    [api_job, x509_job].each do |job|
      assert_equal({"contents" => "read"}, job.fetch("permissions"))
      assert_includes(job.fetch("if"), "github.ref == 'refs/heads/main'")
      assert_includes(job.fetch("if"), "github.repository == 'openai/openai-ruby'")
      steps = job.fetch("steps")
      assert_equal(false, steps.fetch(0).fetch("with").fetch("persist-credentials"))
      assert_equal("${{ github.sha }}", steps.fetch(0).fetch("with").fetch("ref"))
      assert(steps.none? { _1["uses"].to_s.include?("upload-artifact") })
      steps.filter_map { _1["uses"] }.each { assert_match(%r{@[0-9a-f]{40}\z}, _1) }
    end

    assert_equal(["OPENAI_API_KEY"], api_step.fetch("env").keys)
    refute(x509_step.fetch("env").key?("OPENAI_API_KEY"))
    assert_equal(
      %w[
        OPENAI_CLIENT_KEY_PASSPHRASE
        OPENAI_X509_CLIENT_CERTIFICATE_CHAIN_PEM
        OPENAI_X509_CLIENT_PRIVATE_KEY_PEM
        OPENAI_X509_IDENTITY_PROVIDER_ID
        OPENAI_X509_PROXY_MODE
        OPENAI_X509_SERVICE_ACCOUNT_ID
      ],
      x509_step.fetch("env").keys.sort
    )
    assert_equal("direct", x509_step.fetch("env").fetch("OPENAI_X509_PROXY_MODE"))
    assert_includes(x509_step.fetch("run"), "umask 077")
    assert_includes(x509_step.fetch("run"), "trap 'rm -f")
    assert_includes(
      x509_step.fetch("run"),
      "unset OPENAI_X509_CLIENT_CERTIFICATE_CHAIN_PEM OPENAI_X509_CLIENT_PRIVATE_KEY_PEM"
    )
  end
end

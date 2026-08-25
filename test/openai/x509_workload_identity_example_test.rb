# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "test_helper"

class OpenAI::Test::X509WorkloadIdentityExampleTest < Minitest::Test
  extend Minitest::Serial

  EXAMPLE_PATH = File.expand_path("../../examples/x509_workload_identity.rb", __dir__)
  SENSITIVE_VALUES = %w[
    fake-sensitive-certificate-path
    fake-sensitive-key-path
    fake-sensitive-provider
    fake-sensitive-service-account
    fake-sensitive-access-token
    fake-sensitive-api-response
  ]
    .freeze

  def test_certificate_setup_failures_do_not_expose_secret_paths_or_backtraces
    stdout, stderr, status = Open3.capture3(
      {"OPENAI_CLIENT_CERTIFICATE_CHAIN" => "/missing/fake-sensitive-certificate-path"},
      RbConfig.ruby,
      EXAMPLE_PATH
    )

    refute(status.success?)
    assert_empty(stdout)
    assert_equal("[x509] Errno::ENOENT\n", stderr)
    assert_redacted(stderr)
  end

  def test_malformed_origins_are_sanitized_after_certificate_setup
    origin = "https://[fake-sensitive-api-origin-token"
    stdout, stderr, status, client = run_example(origin: origin)

    assert_equal(1, status)
    assert_empty(stdout)
    assert_nil(client)
    assert_equal("[x509] URI::InvalidURIError\n", stderr)
    assert_redacted(stderr, origin)
  end

  def test_ambient_debug_logging_is_disabled_for_the_real_x509_client
    stdout, stderr, status, client = run_example

    assert_equal(0, status)
    assert_equal("[x509] real issuer exchange and mTLS API request succeeded\n", stdout)
    assert_empty(stderr)
    assert_equal(:off, client.log_level)
    assert_nil(client.logger)
  end

  def test_api_failures_preserve_status_without_leaking_response_or_cleanup_errors
    stdout, stderr, status, client = run_example(api_status: 400, fail_cleanup: true)

    assert_equal(1, status)
    assert_empty(stdout)
    assert_equal(:off, client.log_level)
    assert_equal("[x509] OpenAI::Errors::BadRequestError (HTTP 400)\n", stderr)
    assert_redacted(stderr, "fake-sensitive-cleanup-error")
  end

  private

  def run_example(origin: "https://mtls.api.openai.com", api_status: 200, fail_cleanup: false)
    certificate = Minitest::Mock.new
    certificate.expect(:check_private_key, true, [:fake_private_key])
    certificate.expect(:not_before, Time.now - 60)
    certificate.expect(:not_after, Time.now + 60)

    native = OpenAI::NetHTTPClient.new
    client_constructor = OpenAI::Client.method(:new)
    constructed_client = nil
    create_client = -> (**options) { constructed_client = client_constructor.call(**options) }
    create_native = -> (*_arguments, &_configuration) { native }
    execute = -> (request) { response_for(request, api_status) }
    close = -> {
      raise IOError, "fake-sensitive-cleanup-error" if fail_cleanup
    }
    environment = {
      "OPENAI_CLIENT_CERTIFICATE_CHAIN" => "fake-sensitive-certificate-path",
      "OPENAI_CLIENT_KEY" => "fake-sensitive-key-path",
      "IDENTITY_PROVIDER_ID" => "fake-sensitive-provider",
      "SERVICE_ACCOUNT_ID" => "fake-sensitive-service-account",
      "OPENAI_X509_API_ORIGIN" => origin,
      "OPENAI_LOG" => "debug"
    }
    previous_environment = environment.keys.to_h { |name| [name, ENV[name]] }
    environment.each { |name, value| ENV[name] = value }

    exit_status = 0
    stdout, stderr = capture_io do
      File.stub(:binread, "fake-certificate-or-key-pem") do
        OpenSSL::X509::Certificate.stub(:load, [certificate]) do
          OpenSSL::PKey.stub(:read, :fake_private_key) do
            native.stub(:execute, execute) do
              native.stub(:close, close) do
                OpenAI::NetHTTPClient.stub(:new, create_native) do
                  OpenAI::Client.stub(:new, create_client) do
                    load(EXAMPLE_PATH, true)
                  rescue SystemExit => error
                    exit_status = error.status
                  end
                end
              end
            end
          end
        end
      end
    end

    certificate.verify
    [stdout, stderr, exit_status, constructed_client]
  ensure
    previous_environment&.each do |name, value|
      value.nil? ? ENV.delete(name) : ENV[name] = value
    end

    native&.close
  end

  def response_for(request, api_status)
    if request.url.host == "mtls.auth.openai.com"
      body = {
        access_token: "fake-sensitive-access-token",
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      }
      status = 200
    elsif api_status == 200
      body = {
        object: "list",
        data: [{id: "fake-model", object: "model", created: 1, owned_by: "openai"}]
      }
      status = 200
    else
      body = {error: {message: "fake-sensitive-api-response", type: "invalid_request_error"}}
      status = api_status
    end

    OpenAI::HTTPClient::Response.new(
      status: status,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(body)
    )
  end

  def assert_redacted(output, *additional_values)
    (SENSITIVE_VALUES + additional_values).each do |value|
      refute_includes(output, value)
    end
  end
end

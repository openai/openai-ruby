# frozen_string_literal: true

require "fileutils"
require "open3"
require "tempfile"
require "tmpdir"

require_relative "../test_helper"

class OpenAI::Test::WorkloadIdentityErrorTypesTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_public_models_request_exposes_kubernetes_provider_failure_metadata
    missing_path = File.join(Dir.tmpdir, "synthetic-k8s-token-#{SecureRandom.hex}")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: missing_path)

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      workload_identity_client(provider).models.list
    end

    assert_equal("kubernetes", error.provider)
    assert_kind_of(Errno::ENOENT, error.cause)
  end

  def test_public_models_request_exposes_oauth_failure_metadata
    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 401,
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate(error: "invalid_grant", error_description: "Synthetic token exchange failure")
      )

    Tempfile.create("synthetic-k8s-token") do |token_file|
      token_file.write("synthetic-subject-token")
      token_file.flush
      provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: token_file.path)

      error = assert_raises(OpenAI::Errors::OAuthError) do
        workload_identity_client(provider).models.list
      end

      assert_equal(401, error.status)
      assert_equal(:invalid_grant, error.error_code)
    end

    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 1)
    assert_not_requested(:get, "https://api.openai.com/v1/models")
  end

  def test_shipped_rbi_types_error_rescues_and_metadata
    stdout, stderr, status = sorbet_typecheck(sorbet_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_incorrect_metadata_type
    source = sorbet_source.sub(
      "T.let(error.status, Integer)",
      "T.let(error.status, String)"
    )
    stdout, stderr, status = sorbet_typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "String")
  end

  def test_shipped_rbs_types_error_rescues_and_metadata
    stdout, stderr, status = steep_check(rbs_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbs_rejects_incorrect_metadata_type
    source = rbs_source.sub("error.status = 401", "error.status = nil")
    stdout, stderr, status = steep_check(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "error.status")
  end

  private

  def workload_identity_client(provider)
    identity = OpenAI::Auth::WorkloadIdentity.new(
      provider: provider,
      identity_provider_id: "ip_synthetic",
      service_account_id: "sa_synthetic"
    )
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: identity,
      organization: "org_synthetic",
      max_retries: 0
    )
  end

  def sorbet_source
    <<~RUBY
      # typed: true

      begin
        raise "synthetic"
      rescue OpenAI::Errors::SubjectTokenProviderError => error
        provider = T.let(error.provider, String)
        cause = T.let(error.cause, T.nilable(StandardError))
        puts(provider, cause&.message)
      rescue OpenAI::Errors::OAuthError => error
        code = T.let(error.error_code, T.nilable(OpenAI::Models::OAuthErrorCode::Variants))
        status = T.let(error.status, Integer)
        puts(code, status)
      end
    RUBY
  end

  def rbs_source
    <<~RUBY
      begin
        raise "synthetic"
      rescue OpenAI::Errors::SubjectTokenProviderError => error
        error.provider.upcase
        error.cause&.message
      rescue OpenAI::Errors::OAuthError => error
        error.error_code&.to_s
        error.status = 401
        error.status + 1
      end
    RUBY
  end

  def sorbet_typecheck(source)
    root = File.expand_path("../../..", __dir__)

    Tempfile.create(["workload-identity-error-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      Open3.capture3(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "typecheck",
        file.path,
        chdir: root
      )
    end
  end

  def steep_check(source)
    root = File.expand_path("../../..", __dir__)

    Dir.mktmpdir("workload-identity-error-rbs") do |directory|
      FileUtils.cp_r(File.join(root, "sig"), directory)
      File.write(File.join(directory, "probe.rb"), source)
      File.write(
        File.join(directory, "Steepfile"),
        <<~RUBY
          target :lib do
            signature "sig"
            library "net-http"
            check "probe.rb"
          end
        RUBY
      )
      Open3.capture3(
        "steep",
        "check",
        "--no-daemon",
        "--jobs=1",
        "--validate=skip",
        chdir: directory
      )
    end
  end
end

# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::SubjectTokenProviderTypesTest < Minitest::Test
  extend Minitest::Serial

  def test_shipped_rbi_types_documented_provider_configuration
    stdout, stderr, status = sorbet_typecheck(typed_configuration_source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbi_rejects_invalid_provider_arguments
    source = typed_configuration_source.sub("token_path: \"/synthetic/token\"", "token_path: 123")
    stdout, stderr, status = sorbet_typecheck(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "Expected `String`")
  end

  def test_runtime_providers_implement_interface_without_token_access
    providers = [
      OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new,
      OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new,
      OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new
    ]

    assert_equal(
      [OpenAI::Auth::TokenType::JWT, OpenAI::Auth::TokenType::JWT, OpenAI::Auth::TokenType::ID],
      providers.map(&:token_type)
    )
    providers.each do |provider|
      assert_kind_of(OpenAI::Auth::SubjectTokenProvider, provider)
      identity = OpenAI::Auth::WorkloadIdentity.new(
        provider: provider,
        identity_provider_id: "ip_synthetic",
        service_account_id: "sa_synthetic"
      )
      assert_same(provider, identity.provider)
    end
  end

  private

  def typed_configuration_source
    <<~RUBY
      # typed: true

      providers = [
        OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: "/synthetic/token"),
        OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new(resource: "synthetic", timeout: 1.0),
        OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new(audience: "synthetic", timeout: 1.0)
      ]
      providers.each do |provider|
        typed_provider = T.let(provider, OpenAI::Auth::SubjectTokenProvider)
        OpenAI::Auth::WorkloadIdentity.new(
          provider: typed_provider,
          identity_provider_id: "ip_synthetic",
          service_account_id: "sa_synthetic"
        )
        T.assert_type!(typed_provider.token_type, Symbol)
        T.assert_type!(typed_provider.get_token, String)
      end
    RUBY
  end

  def sorbet_typecheck(source)
    root = File.expand_path("../../..", __dir__)

    Tempfile.create(["subject-token-provider-sorbet", ".rb"]) do |file|
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

end

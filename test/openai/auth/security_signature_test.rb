# frozen_string_literal: true

require "open3"
require "tempfile"
require "rbs"

require_relative "../test_helper"

class OpenAI::Test::SecuritySignatureTest < Minitest::Test
  extend Minitest::Serial

  def test_sorbet_accepts_actual_sparse_security_hashes
    stdout, stderr, status = typecheck(
      <<~RUBY_SOURCE
        auth_headers(security: {})
        auth_headers(security: {bearer_auth: true})
        auth_headers(security: {admin_api_key_auth: true})
        auth_headers(security: {bearer_auth: false, admin_api_key_auth: true})
      RUBY_SOURCE
    )
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_sorbet_rejects_non_boolean_security_values
    stdout, stderr, status = typecheck(
      <<~RUBY_SOURCE
        invalid = T.let({bearer_auth: "true"}, T::Hash[Symbol, String])
        auth_headers(security: invalid)
      RUBY_SOURCE
    )
    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "T::Boolean")
  end

  def test_sorbet_accepts_sparse_security_in_request
    stdout, stderr, status = typecheck(
      <<~RUBY_SOURCE
        request(:post, "responses", security: {})
        request(:post, "responses", security: {bearer_auth: true})
        request(:post, "responses", security: {admin_api_key_auth: true})
        request(:post, "responses", security: {bearer_auth: false, admin_api_key_auth: true})
        components = T.let(T.unsafe({}), OpenAI::Internal::Transport::BaseClient::RequestComponents)
        components[:security] = {bearer_auth: true}
      RUBY_SOURCE
    )
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_sorbet_rejects_non_boolean_request_security
    stdout, stderr, status = typecheck(
      <<~RUBY_SOURCE
        invalid = T.let({bearer_auth: "true"}, T::Hash[Symbol, String])
        request(:post, "responses", security: invalid)
      RUBY_SOURCE
    )
    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes("#{stdout}\n#{stderr}", "T::Boolean")
  end

  def test_rbs_security_keys_are_optional_ordinary_symbols
    root = File.expand_path("../../..", __dir__)
    source = File.read(File.join(root, "sig/openai/client.rbs"))
    record = source.match(/private def auth_headers:\s*\(\s*security:\s*(\{[^}]*\})/m)
    refute_nil(record)
    type = RBS::Parser.parse_type(record[1])
    assert_empty(type.fields, "Security schemes may be omitted")
    assert_equal([:admin_api_key_auth, :bearer_auth], type.optional_fields.keys.sort)
    type.optional_fields.each_value { |value| assert_instance_of(RBS::Types::Bases::Bool, value) }
  end

  private

  def typecheck(calls)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["security-signature", ".rb"]) do |file|
      file.write(
        <<~SOURCE
          # typed: true
          class SecuritySignatureProbe < OpenAI::Client
            extend T::Sig
            sig { void }
            def probe
              #{calls}
            end
          end
        SOURCE
      )
      file.flush
      Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
    end
  end
end

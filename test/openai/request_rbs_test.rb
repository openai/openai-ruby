# frozen_string_literal: true

require "fileutils"
require "open3"
require "tmpdir"

require_relative "test_helper"

class OpenAI::Test::RequestRBSTest < Minitest::Test
  def test_shipped_rbs_types_documented_custom_request_call
    source = <<~RUBY
      client = OpenAI::Client.new(api_key: "test-key")
      client.request(
        method: :post,
        path: "/undocumented/endpoint",
        query: {dog: "woof"},
        headers: {useful_header: "interesting-value"},
        body: {"hello" => "world"},
        security: {bearer_auth: true}
      )
      client.request(
        method: :post,
        path: "/undocumented/endpoint",
        query: {"dog" => "woof"},
        headers: {"useful-header" => "interesting-value"},
        body: {"hello" => "world"}
      )
      client.request(
        method: :post,
        path: "/undocumented/endpoint",
        security: {admin_api_key_auth: true}
      )
    RUBY

    stdout, stderr, status = steep_check(source)

    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  def test_shipped_rbs_rejects_invalid_custom_request_security
    source = <<~RUBY
      client = OpenAI::Client.new(api_key: "test-key")
      client.request(
        method: :post,
        path: "/undocumented/endpoint",
        security: {bearer_auth: true, admin_api_key_auth: "false"}
      )
    RUBY

    stdout, stderr, status = steep_check(source)

    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_includes(stdout, "Ruby::ArgumentTypeMismatch")
  end

  private

  def steep_check(source)
    root = File.expand_path("../..", __dir__)

    Dir.mktmpdir("custom-request-rbs") do |directory|
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

# frozen_string_literal: true

require "fileutils"
require "open3"
require "tmpdir"

require_relative "test_helper"

class OpenAI::Test::RequestRBSTest < Minitest::Test
  def test_shipped_rbs_types_documented_custom_request_call
    root = File.expand_path("../..", __dir__)
    source = <<~RUBY
      client = OpenAI::Client.new(api_key: "test-key")
      client.request(
        method: :post,
        path: "/undocumented/endpoint",
        query: {"dog" => "woof"},
        headers: {"useful-header" => "interesting-value"},
        body: {"hello" => "world"}
      )
    RUBY

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
      stdout, stderr, status = Open3.capture3(
        "steep",
        "check",
        "--no-daemon",
        "--jobs=1",
        "--validate=skip",
        chdir: directory
      )

      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end

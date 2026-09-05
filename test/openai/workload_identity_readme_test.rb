# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "test_helper"

class OpenAI::Test::WorkloadIdentityReadmeTest < Minitest::Test
  extend Minitest::Serial

  README_PATH = File.expand_path("../../README.md", __dir__)
  LIB_PATH = File.expand_path("../../lib", __dir__)
  HEADINGS = [
    "Kubernetes Service Account",
    "Azure Managed Identity",
    "GCP Metadata Server",
    "Custom Token Providers"
  ].freeze
  CHILD_SCRIPT = <<~RUBY
    require "openai"
    require "webmock"

    WebMock.enable!
    WebMock.disable_net_connect!

    client = eval(ARGV.fetch(0), binding, "README.md", 1)
    abort "README setup did not construct workload identity" if client.workload_identity_auth.nil?
  RUBY
    .freeze
  ISOLATED_ENVIRONMENT = {
    "OPENAI_ADMIN_KEY" => nil,
    "OPENAI_API_KEY" => nil,
    "OPENAI_BASE_URL" => nil,
    "OPENAI_ORG_ID" => "org_synthetic_readme",
    "OPENAI_PROJECT_ID" => "proj_synthetic_readme",
    "IDENTITY_PROVIDER_ID" => "idp_synthetic_readme",
    "SERVICE_ACCOUNT_ID" => "svc_synthetic_readme",
    "RUBYLIB" => $LOAD_PATH.join(File::PATH_SEPARATOR)
  }.freeze

  def test_workload_identity_setup_snippets_construct_with_or_without_ambient_api_key
    snippets = setup_snippets

    HEADINGS.each do |heading|
      [nil, "sk-synthetic-ambient-key"].each do |api_key|
        _stdout, stderr, status = Open3.capture3(
          ISOLATED_ENVIRONMENT.merge("OPENAI_API_KEY" => api_key),
          RbConfig.ruby,
          "-I",
          LIB_PATH,
          "-e",
          CHILD_SCRIPT,
          "--",
          snippets.fetch(heading),
          unsetenv_others: true
        )

        assert(
          status.success?,
          "#{heading} setup failed with OPENAI_API_KEY=#{api_key.nil? ? "unset" : "set"}: #{stderr}"
        )
      end
    end
  end

  private

  def setup_snippets
    readme = File.read(README_PATH)

    HEADINGS.to_h do |heading|
      section = readme.split("### #{heading}\n", 2).fetch(1).split(/^###? /, 2).first
      code = section.match(/```ruby\n(.*?)\n```/m)[1]

      # This verifies README setup only, not live cloud authentication. Stop
      # before the Kubernetes snippet's documented API request.
      [heading, code.split("\nresponse = client.chat.completions.create(", 2).first]
    end
  end
end

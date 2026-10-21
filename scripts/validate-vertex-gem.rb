# frozen_string_literal: true

require "rbconfig"
require "tmpdir"

def validate_installed(mode)
  require "openai"

  gem_root = File.realpath(Gem.loaded_specs.fetch("openai").full_gem_path)
  unless gem_root.start_with?("#{File.realpath(ENV.fetch("GEM_HOME"))}/")
    raise "Loaded openai outside the isolated gem home"
  end

  base_url = "https://vertex.example/v1"
  auth = if mode == "plain"
    raise "The base gem installed googleauth" unless Gem::Specification.find_all_by_name("googleauth").empty?

    begin
      OpenAI::Client.new(provider: OpenAI::Providers.vertex(base_url: base_url))
    rescue LoadError => error
      raise unless error.message == "Vertex ADC requires optional gem \"googleauth\"; add it to your Gemfile."
    else
      raise "Vertex ADC should require googleauth"
    end

    {token_provider: -> { "fixture-token" }}
  else
    require "googleauth"

    {credentials: Google::Auth::UserRefreshCredentials.new(access_token: "fixture-token", expires_at: Time.now + 3600)}
  end

  transport = Class
    .new(OpenAI::HTTPClient) do
      def execute(request)
        raise "Unexpected authorization header" unless request.headers.fetch("authorization") == "Bearer fixture-token"

        OpenAI::HTTPClient::Response.new(
          status: 200,
          headers: {"content-type" => "application/json"},
          body: "{\"id\":\"resp_fixture\",\"output\":[]}"
        )
      end
    end
    .new
  client = OpenAI::Client.new(provider: OpenAI::Providers.vertex(base_url: base_url, **auth), http_client: transport)
  raise "Unexpected response" unless client.responses.create(model: "fixture", input: "hello").id == "resp_fixture"
end

def validate_package
  packages = Dir["pkg/*.gem"]
  raise "Expected one built gem in pkg/, found: #{packages.inspect}" unless packages.size == 1

  package = File.expand_path(packages.fetch(0))
  script = File.expand_path(__FILE__)
  Dir.mktmpdir("openai-vertex-gem-") do |directory|
    env = {
      "GEM_HOME" => directory,
      "GEM_PATH" => directory,
      "BUNDLE_GEMFILE" => nil,
      "RUBYOPT" => nil,
      "RUBYLIB" => nil
    }
    run = -> (*args) { system(env, RbConfig.ruby, *args, chdir: directory, exception: true) }
    run.call("-S", "gem", "install", "--no-document", package)
    run.call(script, "plain")
    run.call("-S", "gem", "install", "--no-document", "googleauth", "--version", "~> 1")
    run.call(script, "vertex")
  end
end

case ARGV
when []
  validate_package
when ["plain"], ["vertex"]
  validate_installed(ARGV.fetch(0))
else
  abort("usage: validate-vertex-gem.rb [plain | vertex]")
end

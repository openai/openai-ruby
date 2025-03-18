# frozen_string_literal: true

require_relative "lib/openai/version"

Gem::Specification.new do |s|
  s.name = "openai"
  s.version = OpenAI::VERSION
  s.summary = "Ruby library to access the OpenAI API"
  s.authors = ["OpenAI"]
  s.email = "support@openai.com"
  s.files = Dir["lib/**/*.rb", "rbi/**/*.rbi", "sig/**/*.rbs", "manifest.yaml"]
  s.extra_rdoc_files = ["README.md"]
  s.required_ruby_version = ">= 3.0.0"
  s.add_dependency "connection_pool"
  s.homepage = "https://gemdocs.org/gems/openai"
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/openai/openai-ruby"
  s.metadata["rubygems_mfa_required"] = "false"
end

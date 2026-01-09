# frozen_string_literal: true

require_relative "lib/openai/version"

Gem::Specification.new do |s|
  s.name = "openai"
  s.version = OpenAI::VERSION
  s.summary = "Ruby library to access the OpenAI API"
  s.authors = ["OpenAI"]
  s.email = "support@openai.com"
  s.homepage = "https://gemdocs.org/gems/openai"
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/openai/openai-ruby"
  s.metadata["rubygems_mfa_required"] = false.to_s
  s.required_ruby_version = ">= 3.2.0"
  s.license = "Apache-2.0"

  s.files = Dir[
    "lib/**/*.rb",
    "rbi/**/*.rbi",
    "sig/**/*.rbs",
    "manifest.yaml",
    "SECURITY.md",
    "CHANGELOG.md",
    ".ignore"
  ]
  s.extra_rdoc_files = ["README.md"]
  s.add_dependency "base64"
  s.add_dependency "cgi"
  s.add_dependency "connection_pool"
end

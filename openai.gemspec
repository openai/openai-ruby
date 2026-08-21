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
  s.metadata["rubygems_mfa_required"] = "true"
  s.required_ruby_version = ">= 3.3.0"
  s.license = "Apache-2.0"

  s.files = Dir[
    "lib/**/*.rb",
    "rbi/**/*.rbi",
    "sig/**/*.rbs",
    "manifest.yaml",
    "SECURITY.md",
    "CHANGELOG.md",
    ".ignore"
  ] +
    [
      "examples/mtls_custom_http_client.rb",
      "examples/realtime/README.md",
      "examples/realtime/function_calling.rb",
      "examples/realtime/image_input.rb",
      "examples/realtime/mcp_approval.rb",
      "examples/realtime/websocket_transcription.rb",
      "examples/realtime/websocket_text.rb",
      "examples/realtime/websocket_voice_turn.rb"
    ]
  s.extra_rdoc_files = [
    "README.md",
    "VERSIONING.md",
    "azure.md",
    "bedrock.md",
    "realtime.md",
    "examples/realtime/README.md"
  ]
  s.add_dependency("connection_pool", ">= 2.2.3")
  s.add_dependency("logger")
end

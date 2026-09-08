# frozen_string_literal: true

require_relative "lib/openai_audio"

Gem::Specification.new do |spec|
  spec.name = "openai-audio"
  spec.version = OpenAIAudio::VERSION
  spec.platform = Gem::Platform::CURRENT
  spec.summary = "Optional native local audio worker for the OpenAI Ruby SDK"
  spec.authors = ["OpenAI"]
  spec.license = "Apache-2.0"
  spec.required_ruby_version = ">= 3.3.0"
  spec.homepage = "https://github.com/openai/openai-ruby"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.files = Dir[
    "lib/**/*.rb",
    "bin/openai-audio-worker*",
    "native/**/*",
    "CMakeLists.txt",
    "README.md",
    "LICENSE",
    "THIRD_PARTY.md"
  ]
  spec.require_paths = ["lib"]
end

#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.azure(
    endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
    api_key: ENV.fetch("AZURE_OPENAI_API_KEY")
  )
)

response = client.responses.create(
  model: ENV.fetch("AZURE_OPENAI_DEPLOYMENT"),
  input: "Say hello!"
)

pp(response)

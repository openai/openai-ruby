#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: ENV["AWS_REGION"] || ENV["AWS_DEFAULT_REGION"]
  )
)

response = client.responses.create(
  model: ENV.fetch("BEDROCK_MODEL"),
  input: "Say hello from Amazon Bedrock!"
)

puts(response.output_text)

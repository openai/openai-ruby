#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    endpoint: :runtime,
    region: ENV["AWS_REGION"] || ENV["AWS_DEFAULT_REGION"]
  )
)
model = ENV.fetch("BEDROCK_MODEL", "us.openai.gpt-5.6-sol")

completion = client.chat.completions.create(
  model: model,
  messages: [{role: :user, content: "Say hello from Amazon Bedrock Runtime!"}]
)
puts(completion.choices.first.message.content)

response = client.responses.create(
  model: model,
  input: "Say hello from Amazon Bedrock Runtime!"
)
puts(response.output_text)

if ENV["BEDROCK_STREAM"] == "1"
  stream = client.chat.completions.stream(
    model: model,
    messages: [{role: :user, content: "Write a short greeting."}]
  )
  stream.text.each { |text| print(text) }
  puts
end

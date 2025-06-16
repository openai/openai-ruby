#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/openai"

class GetWeather < OpenAI::BaseModel
  required :location, String, doc: "City and country e.g. Bogotá, Colombia"
end

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

response = client.responses.create(
  model: "gpt-4o-2024-08-06",
  input: [
    {
      role: :user,
      content: "What's the weather like in Paris today?"
    }
  ],
  tools: [GetWeather]
)

response
  .output
  .each do |output|
    # parsed is an instance of `GetWeather`
    pp(output.parsed)
  end

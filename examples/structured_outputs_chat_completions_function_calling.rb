#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

class GetWeather < OpenAI::BaseModel
  required :location, String, doc: "City and country e.g. Bogotá, Colombia"
end

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

chat_completion = client.chat.completions.create(
  model: "gpt-4o-2024-08-06",
  messages: [
    {
      role: :user,
      content: "What's the weather like in Paris today?"
    }
  ],
  tools: [GetWeather]
)

chat_completion
  .choices
  .reject { _1.message.refusal }
  .flat_map { _1.message.tool_calls.to_a }
  .each do |tool_call|
    # parsed is an instance of `GetWeather`
    pp(tool_call.function.parsed)
  end

#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

class GetWeather < OpenAI::BaseModel
  required :location, String
end

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  tools: [GetWeather],
  messages: [
    {role: :user, content: "Call get_weather with location San Francisco in JSON."}
  ]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatFunctionToolCallArgumentsDeltaEvent
    puts("delta: #{event.arguments_delta}")
    pp(event.parsed)
  when OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent
    puts("--- Tool call finalized ---")
    puts("name: #{event.name}")
    puts("args: #{event.arguments}")
    pp(event.parsed)
  end
end

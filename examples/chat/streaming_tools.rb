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
  tool_choice: {type: :function, function: {name: "GetWeather"}},
  messages: [
    {role: :user, content: "Call get_weather with location San Francisco in JSON."}
  ]
)

tool_call_received = false
stream.each do |event|
  case event
  when OpenAI::Streaming::ChatFunctionToolCallArgumentsDeltaEvent
    puts("delta: #{event.arguments_delta}")
    pp(event.parsed)
  when OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent
    abort("The finalized tool call did not contain parsed arguments") unless event.parsed.is_a?(GetWeather)

    tool_call_received = true
    puts("--- Tool call finalized ---")
    puts("name: #{event.name}")
    puts("args: #{event.arguments}")
    pp(event.parsed)
  end
end
abort("The stream ended without a finalized tool call") unless tool_call_received

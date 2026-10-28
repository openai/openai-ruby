#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

class WeatherArguments < OpenAI::BaseModel
  required :city, String
end

client = OpenAI::Client.new
calls = 0
completion = client.chat.completions.run_tools(
  model: "gpt-4o-mini",
  messages: [{role: :user, content: "What is the weather in Seattle? Use the provided weather tool."}],
  tools: [WeatherArguments],
  tool_choice: {type: :function, function: {name: "WeatherArguments"}},
  tool_handlers: {
    "WeatherArguments" => -> (arguments) do
      calls += 1
      # Replace this synthetic result with your weather service.
      {city: arguments.fetch("city"), temperature_c: 18, condition: "rain"}
    end
  },
  max_rounds: 5
)

unless calls.positive? &&
    completion.choices.first.finish_reason == :stop &&
    !completion.choices.first.message.content.to_s.empty?
  abort("Expected a weather callback and a final answer")
end

puts("Tool runner completed.")

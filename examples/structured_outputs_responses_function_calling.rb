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
  tools: [GetWeather],
  tool_choice: {type: :function, name: "GetWeather"}
)

parsed_tool_call_count = 0
response
  .output
  .each do |output|
    case output
    when OpenAI::Models::Responses::ResponseFunctionToolCall
      # parsed is an instance of `GetWeather`
      parsed = output.parsed
      next unless parsed.is_a?(GetWeather)

      parsed_tool_call_count += 1
      pp(parsed)
    end
  end

abort("The response did not contain a parsed GetWeather tool call") if parsed_tool_call_count.zero?

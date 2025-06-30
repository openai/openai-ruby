#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# Defining structured output models.
class Step < OpenAI::BaseModel
  required :explanation, String
  required :output, String
end

class MathResponse < OpenAI::BaseModel
  required :steps, OpenAI::ArrayOf[Step]
  required :final_answer, String
end

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "solve 8x + 31 = 2",
  model: "gpt-4o-2024-08-06",
  text: MathResponse
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ResponseTextDoneEvent
    puts
    puts("--- Parsed object ---")
    pp(event.parsed)
  end
end

response = stream.get_final_response

puts
puts("----- parsed outputs from final response -----")
response
  .output
  .flat_map { _1.content }
  .each do |content|
    # parsed is an instance of `MathResponse`
    pp(content.parsed)
  end

#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

class Step < OpenAI::BaseModel
  required :explanation, String
  required :output, String
end

class MathResponse < OpenAI::BaseModel
  required :steps, OpenAI::ArrayOf[Step]
  required :final_answer, String
end

client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  response_format: MathResponse,
  messages: [
    {role: :user, content: "solve 8x + 31 = 2, show all steps"}
  ]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    puts
    puts("--- parsed object ---")
    pp(event.parsed)
  end
end

response = stream.get_final_completion

puts
puts("----- parsed outputs from final response -----")
response
  .choices
  .each do |choice|
    # parsed is an instance of `MathResponse`
    pp(choice.message.parsed)
  end

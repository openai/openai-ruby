#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  messages: [
    {role: :user, content: "Write a creative haiku about the ocean."}
  ]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    puts
  end
end

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

content_received = false
stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    content_received ||= !event.delta.strip.empty?
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    puts
  end
end

puts("Streamed content received.") if content_received

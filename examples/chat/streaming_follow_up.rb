#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

# This example demonstrates how to start a new streamed chat completion that includes prior turns by
# resending the conversation messages.
#
# 1. Start with an initial user turn and stream the assistant reply.
messages = [
  {role: :user, content: "Tell me a short story about a robot. Stop after 2 sentences."}
]

puts "First streamed completion:"
assistant_text = ""
first_stream_completed = false

stream1 = client.chat.completions.stream(
  model: "gpt-4o-mini",
  messages: messages
)

stream1.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    assistant_text += event.delta
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    first_stream_completed = true
    puts
  end
end

abort("The first stream completed without content") if assistant_text.strip.empty?
abort("The first stream ended before its content completed") unless first_stream_completed

# 2. Start a new streamed completion that includes the prior assistant turn
#    and adds a follow-up user instruction.
messages << {role: :assistant, content: assistant_text}
messages << {role: :user, content: "Continue the story with 2 more sentences while keeping the same style."}

puts
puts "Second streamed completion (with prior turns included):"

stream2 = client.chat.completions.stream(
  model: "gpt-4o-mini",
  messages: messages
)

follow_up_text = ""
follow_up_stream_completed = false
stream2.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    follow_up_text += event.delta
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    follow_up_stream_completed = true
    puts
  end
end

abort("The follow-up stream completed without content") if follow_up_text.strip.empty?
abort("The follow-up stream ended before its content completed") unless follow_up_stream_completed

puts
puts "Done. The second stream is a new completion that used the prior turns as context."

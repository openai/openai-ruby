#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

begin
  # Non-streaming:
  pp("----- standard request -----")

  completion = client.chat.completions.create(
    model: "gpt-4",
    messages: [
      {
        role: "user",
        content: "Say this is a test"
      }
    ]
  )

  content = completion.choices.first&.message&.content
  abort("The standard request completed without content") if content.to_s.strip.empty?
  pp(content)
end

begin
  # Streaming:
  pp("----- streaming request -----")

  stream = client.chat.completions.stream_raw(
    model: "gpt-4",
    messages: [
      {
        role: "user",
        content: "How do I output all files in a directory using Python?"
      }
    ]
  )

  streamed_content = String.new
  stream.each do |chunk|
    next if chunk.choices.to_a.empty?

    content = chunk.choices.first&.delta&.content
    streamed_content << content.to_s
    pp(content)
  end
  abort("The streaming request completed without content") if streamed_content.strip.empty?
end

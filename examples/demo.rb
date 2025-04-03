#!/usr/bin/env -S -- ruby
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

  pp(completion.choices.first&.message&.content)
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

  stream.each do |chunk|
    next if chunk.choices.to_a.empty?

    pp(chunk.choices.first&.delta&.content)
  end
end

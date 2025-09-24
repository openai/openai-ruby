#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  messages: [
    {role: :user, content: "List three fun facts about dolphins."}
  ]
)

stream.text.each do |text|
  print(text)
end
puts

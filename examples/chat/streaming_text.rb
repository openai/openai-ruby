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

content_received = false
stream.text.each do |text|
  content_received ||= !text.strip.empty?
  print(text)
end
puts

abort("The text stream completed without content") unless content_received
completion = stream.get_final_completion
finished_choice_received = completion.choices.any? { |choice| !choice.finish_reason.nil? }
abort("The text stream ended before content completion") unless finished_choice_received
puts("Streamed content received.")

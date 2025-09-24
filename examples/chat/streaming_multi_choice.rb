#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  n: 2,
  messages: [
    {role: :user, content: "Give me two short taglines for a beach resort."}
  ]
)

choice_contents = {}
choice_finished = {}

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatChunkEvent
    # Access the full snapshot with all choices:
    event.snapshot.choices.each_with_index do |choice, index|
      if choice.message.content
        choice_contents[index] = choice.message.content
      end

      next unless choice.finish_reason && !choice_finished[index]
      choice_finished[index] = true
      # Print the complete content for this choice when it finishes:
      puts("[choice #{index}] complete:")
      puts(choice_contents[index])
      puts("--- choice #{index} done ---")
      puts
    end
  end
end

puts("------ final choices ------")
choice_contents.keys.sort.each do |i|
  puts("[#{i}] #{choice_contents[i]}")
end

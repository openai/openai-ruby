#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../../lib/openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-4o-2024-08-06"
)

stream.text.each do |text|
  print(text)
end

puts

# Get all of the text that was streamed with .get_output_text
puts "Character count: #{stream.get_output_text.length}"

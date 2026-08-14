#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../../lib/openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-4o-2024-08-06"
)

streamed_text_received = T.let(false, T::Boolean)
stream.text.each do |text|
  streamed_text_received ||= !text.strip.empty?
  print(text)
end
abort("The response stream completed without yielding text") unless streamed_text_received

puts

# Get all of the text that was streamed with .get_output_text
puts "Character count: #{stream.get_output_text.length}"

#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require_relative "../../lib/openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-4o-2024-08-06"
)

streamed_text = String.new
completed_response_id = ""
stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    streamed_text << event.delta
    print(event.delta)
  when OpenAI::Streaming::ResponseTextDoneEvent
    puts("\n--------------------------")
  when OpenAI::Streaming::ResponseCompletedEvent
    completed_response_id = event.response.id
  end
end

abort("The response stream completed without text") if streamed_text.strip.empty?
abort("The response stream ended before completion") if completed_response_id.empty?
puts("Response completed! (response id: #{completed_response_id})")

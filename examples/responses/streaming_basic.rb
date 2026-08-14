#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require_relative "../../lib/openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-4o-2024-08-06"
)

text_received = T.let(false, T::Boolean)
completed_response_id = T.let(nil, T.nilable(String))
stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    text_received ||= !event.delta.strip.empty?
    print(event.delta)
  when OpenAI::Streaming::ResponseTextDoneEvent
    puts("\n--------------------------")
  when OpenAI::Streaming::ResponseCompletedEvent
    completed_response_id = event.response.id
  end
end

abort("The response stream completed without text") unless text_received
abort("The response stream ended before completion") unless completed_response_id
puts("Response completed! (response id: #{completed_response_id})")

#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require_relative "../../lib/openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-4o-2024-08-06"
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ResponseTextDoneEvent
    puts("\n--------------------------")
  when OpenAI::Streaming::ResponseCompletedEvent
    puts("Response completed! (response id: #{event.response.id})")
  end
end

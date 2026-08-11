#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"

def stream_response(connection)
  started_response = false
  connection.each do |event|
    case event
    when OpenAI::Realtime::SessionCreatedEvent
      puts("[realtime] session.created")
    when OpenAI::Realtime::SessionUpdatedEvent
      puts("[realtime] session.updated")
    when OpenAI::Realtime::ResponseTextDeltaEvent
      print("[assistant] ") unless started_response
      started_response = true
      print(event.delta)
      $stdout.flush
    when OpenAI::Realtime::ResponseDoneEvent
      puts if started_response
      status = event.response.status
      raise "Realtime response ended with status #{status.inspect}" unless status == :completed

      puts("[realtime] response.done status=completed")
      break
    when OpenAI::Realtime::RealtimeErrorEvent
      raise "Realtime API error: #{event.error.message}"
    end
  end
end

client = OpenAI::Client.new
model = ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1")
prompt = ENV.fetch("OPENAI_REALTIME_PROMPT", "Say hello from Ruby.")
timeout = Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))
session = {
  type: :realtime,
  output_modalities: [:text],
  instructions: "Be concise and friendly."
}
item = {
  type: :message,
  role: :user,
  content: [{type: :input_text, text: prompt}]
}

puts("[realtime] connecting with #{model}")

Timeout.timeout(timeout) do
  client.realtime.connect(model: model) do |connection|
    puts("[realtime] connected; sending prompt: #{prompt.inspect}")
    connection.session.update(**session)
    connection.conversation.items.create(**item)
    connection.response.create
    stream_response(connection)
  end
end

puts("[realtime] smoke test passed")

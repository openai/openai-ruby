#!/usr/bin/env ruby
# frozen_string_literal: true

require "openai"

# Entry means transport-open. Choose session configuration, then wait for the
# server's session.started before sending application commands.
client = OpenAI::Client.new
client.live.connect do |connection|
  connection.send_event(type: "session.start", session: {model: "gpt-live-1", store: false})
  connection.each do |event|
    case event
    when OpenAI::Live::SessionStartedEvent
      puts("Live session started")
      connection.send_event(type: "session.close")
    when OpenAI::Live::ErrorEvent
      # Do not log audio, session configuration, or unredacted server errors.
      warn("Live reported a session error; check the event in your application.")
    when OpenAI::Live::SessionClosedEvent
      puts("Live session closed")
      break
    end
  end
end

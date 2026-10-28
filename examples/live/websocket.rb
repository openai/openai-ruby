#!/usr/bin/env ruby
# frozen_string_literal: true

require "openai"

# Entry means transport-open. Choose session configuration, then wait for the
# server's session.started before sending application commands.
client = OpenAI::Client.new
finished = false
session_error = false
client.live.connect do |connection|
  connection.send_event(type: "session.start", session: {model: "gpt-live-1", store: false})
  connection.each do |event|
    case event
    when OpenAI::Live::SessionStartedEvent
      puts("Live session started")
      connection.send_event(type: "session.close")
    when OpenAI::Live::ErrorEvent
      # Do not log audio, session configuration, or unredacted server errors.
      session_error = true
    when OpenAI::Live::SessionClosedEvent
      puts("Live session closed")
      finished = true
      break
    end
  end
end

raise "Live disconnected before session.closed; finalization was not confirmed." unless finished
raise "Live reported a session error; check the event in your application." if session_error

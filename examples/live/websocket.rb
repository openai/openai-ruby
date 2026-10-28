#!/usr/bin/env ruby
# frozen_string_literal: true

require "openai"
require "timeout"

# Entry means transport-open. Choose session configuration, then wait for the
# server's session.started before sending application commands.
client = OpenAI::Client.new
finished = false
started = false
session_error = false
# Use an example-local timeout exception so older Ruby schedulers cannot turn
# a deadline into a transport failure while interrupting a socket read.
deadline_error = Class.new(Exception) # rubocop:disable Lint/InheritException
client.live.connect do |connection|
  # Bound this short demonstration's start-and-close exchange. Choose a
  # deadline appropriate for your application when doing real session work.
  Timeout.timeout(30, deadline_error) do
    connection.send_event(type: "session.start", session: {model: "gpt-live-1", store: false})
    connection.each do |event|
      case event
      when OpenAI::Live::SessionStartedEvent
        started = true
        puts("Live session started")
        connection.send_event(type: "session.close")
      when OpenAI::Live::ErrorEvent
        # Do not log audio, session configuration, or unredacted server errors.
        session_error = true
        raise "Live reported a session error; check the event in your application." unless started
      when OpenAI::Live::SessionClosedEvent
        puts("Live session closed")
        finished = true
        break
      end
    end
  end
rescue deadline_error
  raise "Live did not confirm session.closed before the deadline.", cause: nil
end

raise "Live disconnected before session.closed; finalization was not confirmed." unless finished
raise "Live reported a session error; check the event in your application." if session_error

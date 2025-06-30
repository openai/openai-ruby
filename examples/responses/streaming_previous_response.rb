#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# This example demonstrates how to resume a streaming response.

client = OpenAI::Client.new

# Request 1: Create a new streaming response with store=true
puts "Creating a new streaming response..."
stream = client.responses.stream(
  model: "o4-mini",
  input: "Tell me a short story about a robot learning to paint.",
  instructions: "You are a creative storyteller.",
  background: true
)

events = []
response_id = ""

stream.each do |event|
  events << event
  puts "Event from initial stream: #{event.type} (seq: #{event.sequence_number})"
  case event

  when OpenAI::Models::Responses::ResponseCreatedEvent
    response_id = event.response.id if response_id.empty?
    puts("Captured response ID: #{response_id}")
  end

  # Simulate stopping after a few events
  if events.length >= 5
    puts "Terminating after #{events.length} events"
    break
  end
end

stream.close

puts
puts "Collected #{events.length} events"
puts "Response ID: #{response_id}"
puts "Last event sequence number: #{events.last.sequence_number}.\n"

# Give the background response some time to process more events.
puts "Waiting a moment for the background response to progress...\n"
sleep(2)

# Request 2: Resume the stream using the captured response_id.
puts "Resuming stream from sequence #{events.last.sequence_number}..."

resumed_stream = client.responses.stream(
  previous_response_id: response_id,
  starting_after: events.last.sequence_number
)

resumed_events = []
resumed_stream.each do |event|
  resumed_events << event
  puts "Event from resumed stream: #{event.type} (seq: #{event.sequence_number})"
  # Stop when we get the completed event or collect enough events.
  if event.is_a?(OpenAI::Models::Responses::ResponseCompletedEvent)
    puts "Response completed!"
    break
  end

  break if resumed_events.length >= 10
end

puts "\nCollected #{resumed_events.length} additional events"

# Show that we properly resumed from where we left off.
if resumed_events.any?
  first_resumed_event = resumed_events.first
  last_initial_event = events.last
  puts "First resumed event sequence: #{first_resumed_event.sequence_number}"
  puts "Should be greater than last initial event: #{last_initial_event.sequence_number}"
end

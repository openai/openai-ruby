#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# This example demonstrates how to resume a streaming response.

client = OpenAI::Client.new

begin
  puts "----- resuming stream from a previous response -----"

  # Request 1: Create a new streaming response with background=true
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

  puts "Collected #{events.length} events"
  puts "Response ID: #{response_id}"
  puts "Last event sequence number: #{events.last.sequence_number}.\n"

  # Give the background response some time to process more events.
  puts "Waiting a moment for the background response to progress...\n"
  sleep(3)

  # Request 2: Resume the stream using the captured response_id.
  puts
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

  puts "Collected #{resumed_events.length} additional events"

  # Show that we properly resumed from where we left off.
  if resumed_events.any?
    first_resumed_event = resumed_events.first
    last_initial_event = events.last
    puts "First resumed event sequence: #{first_resumed_event.sequence_number}"
    puts "Should be greater than last initial event: #{last_initial_event.sequence_number}"
  end
end

begin
  puts "\n----- resuming stream with structured outputs -----"

  class Step < OpenAI::BaseModel
    required :explanation, String
    required :output, String
  end

  class MathResponse < OpenAI::BaseModel
    required :steps, OpenAI::ArrayOf[Step]
    required :final_answer, String
  end

  puts "Creating a background streaming response with structured output..."
  stream = client.responses.stream(
    input: "solve 8x + 31 = 2",
    model: "gpt-4o-2024-08-06",
    text: MathResponse,
    background: true
  )

  events = []
  response_id = ""

  stream.each do |event|
    events << event

    case event
    when OpenAI::Models::Responses::ResponseCreatedEvent
      response_id = event.response.id if response_id.empty?
    end

    if events.length >= 5
      break
    end
  end

  puts "Waiting for the background response to complete...\n"
  sleep(3)

  puts
  puts "Resuming stream from sequence #{events.last.sequence_number}..."

  resumed_stream = client.responses.stream(
    previous_response_id: response_id,
    starting_after: events.last.sequence_number,
    # NOTE: You must pass the structured output format when resuming to access parsed
    # outputs in the resumed stream.
    text: MathResponse
  )

  resumed_stream.each do |event|
    case event
    when OpenAI::Streaming::ResponseTextDeltaEvent
      print(event.delta)
    when OpenAI::Streaming::ResponseTextDoneEvent
      puts
      puts("--- Parsed object from resumed stream ---")
      pp(event.parsed)
    when OpenAI::Models::Responses::ResponseCompletedEvent
      puts("Response completed.")
      break
    end
  end

  puts "\nFinal response parsed outputs:"
  response = resumed_stream.get_final_response
  response
    .output
    .flat_map { _1.content }
    .each do |content|
      pp(content.parsed)
    end
end

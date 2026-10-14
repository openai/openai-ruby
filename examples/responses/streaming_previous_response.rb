#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# This example demonstrates how to resume a streaming response.

client = OpenAI::Client.new

begin
  puts("----- resuming stream from a previous response -----")

  # Request 1: Create a new streaming response with background=true
  puts("Creating a new streaming response...")
  stream = client.responses.stream(
    model: "o4-mini",
    input: "Tell me a short story about a robot learning to paint.",
    instructions: "You are a creative storyteller.",
    background: true
  )

  events = []
  response_id = ""
  last_sequence_number = nil

  stream.each do |event|
    events << event
    last_sequence_number = event.sequence_number unless event.sequence_number.nil?
    puts("Event from initial stream: #{event.type} (seq: #{event.sequence_number})")
    case event

    when OpenAI::Models::Responses::ResponseCreatedEvent
      response_id = event.response.id if response_id.empty?
      puts("Captured response ID: #{response_id}")
    end

    # Simulate stopping after a few events
    if events.length >= 5
      puts("Terminating after #{events.length} events")
      break
    end
  end

  abort("The initial stream completed without events") if events.empty?
  abort("The initial stream did not include a response ID") if response_id.empty?
  abort("The initial stream did not include a resumable sequence number") if last_sequence_number.nil?

  puts("Collected #{events.length} events")
  puts("Response ID: #{response_id}")
  puts("Last resumable sequence number: #{last_sequence_number}.\n")

  # Give the background response some time to process more events.
  puts("Waiting a moment for the background response to progress...\n")
  sleep(3)

  # Request 2: Resume the stream using the captured response_id.
  puts
  puts("Resuming stream from sequence #{last_sequence_number}...")

  resumed_stream = client.responses.stream(
    response_id: response_id,
    starting_after: last_sequence_number
  )

  resumed_events = []
  resumed_stream.each do |event|
    resumed_events << event
    puts("Event from resumed stream: #{event.type} (seq: #{event.sequence_number})")
    # Stop when we get the completed event or collect enough events.
    if event.is_a?(OpenAI::Models::Responses::ResponseCompletedEvent)
      puts("Response completed!")
      break
    end

    break if resumed_events.length >= 10
  end

  puts("Collected #{resumed_events.length} additional events")

  # Show that we properly resumed from where we left off.
  abort("The resumed stream completed without events") if resumed_events.empty?

  first_resumed_event = resumed_events.find { |event| !event.sequence_number.nil? }
  abort("The resumed stream did not include an event with a sequence number") if first_resumed_event.nil?

  unless first_resumed_event.sequence_number > last_sequence_number
    abort("The resumed stream repeated an event from the initial stream")
  end

  puts("First resumed event sequence: #{first_resumed_event.sequence_number}")
  puts("Verified it is greater than the last usable initial sequence: #{last_sequence_number}")
end

begin
  puts("\n----- resuming stream with structured outputs -----")

  class Step < OpenAI::BaseModel
    required :explanation, String
    required :output, String
  end

  class MathResponse < OpenAI::BaseModel
    required :steps, OpenAI::ArrayOf[Step]
    required :final_answer, String
  end

  puts("Creating a background streaming response with structured output...")
  stream = client.responses.stream(
    input: "solve 8x + 31 = 2",
    model: "gpt-4o-2024-08-06",
    text: MathResponse,
    background: true
  )

  events = []
  response_id = ""
  last_sequence_number = nil

  stream.each do |event|
    events << event
    last_sequence_number = event.sequence_number unless event.sequence_number.nil?

    case event
    when OpenAI::Models::Responses::ResponseCreatedEvent
      response_id = event.response.id if response_id.empty?
    end

    if events.length >= 5
      break
    end
  end

  abort("The structured initial stream completed without events") if events.empty?
  abort("The structured initial stream did not include a response ID") if response_id.empty?
  if last_sequence_number.nil?
    abort("The structured initial stream did not include a resumable sequence number")
  end

  puts("Waiting for the background response to complete...\n")
  sleep(3)

  puts
  puts("Resuming stream from sequence #{last_sequence_number}...")

  resumed_stream = client.responses.stream(
    response_id: response_id,
    starting_after: last_sequence_number,
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

  puts("\nFinal response parsed outputs:")
  response = resumed_stream.get_final_response
  parsed_output_received = false
  response
    .output
    .grep(OpenAI::Models::Responses::ResponseOutputMessage)
    .flat_map(&:content)
    .grep(OpenAI::Models::Responses::ResponseOutputText)
    .each do |content|
      parsed = content.parsed
      next unless parsed.is_a?(MathResponse)

      parsed_output_received = true
      pp(parsed)
    end

  abort("The resumed response did not contain a parsed MathResponse") unless parsed_output_received
end

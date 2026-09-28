#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai/helpers/live/transcript_grouper"

# Offline demonstration: replace these events with your session's typed events.
events = [
  OpenAI::Live::InputTranscriptDeltaEvent.new(event_id: "input_1", delta: "Hello", start_ms: 0, end_ms: 200),
  OpenAI::Live::InputTranscriptDeltaEvent.new(event_id: "input_2", delta: " there.", start_ms: 200, end_ms: 400),
  OpenAI::Live::OutputTranscriptDeltaEvent.new(event_id: "output_1", delta: "Hi!", start_ms: 1000, end_ms: 1200)
]
grouper = OpenAI::Live::TranscriptGrouper.new(
  on_segment_updated: -> (segment) { puts("#{segment.speaker}: #{segment.text}") },
  on_segment_closed: -> (event) { puts("Final #{event.segment.speaker}: #{event.reason}") }
)
begin
  events.each { |event| grouper.push(event) }
ensure
  grouper.close
end

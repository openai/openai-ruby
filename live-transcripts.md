# Live transcript grouping

`OpenAI::Live::TranscriptGrouper` turns typed Live transcript deltas into
immutable display segments. Load it explicitly and feed it events from your
existing session:

```ruby
require "openai/helpers/live/transcript_grouper"

grouper = OpenAI::Live::TranscriptGrouper.new(
  on_segment_updated: ->(segment) { update_text(segment.id, segment.text) },
  on_segment_closed: ->(event) { mark_final(event.segment.id, event.reason) }
)
begin
  events.each do |event|
    grouper.push(event)
    # The original typed event remains available for other processing.
  end
ensure
  grouper.close
end
```

The callbacks above stand for your application's display functions. Every
update contains the complete text so far: replace the displayed text instead
of appending it. Segment `id` and `previous_id` are local display identifiers,
not server conversation-item IDs. Snapshots and their strings are frozen;
earlier snapshots never change. Each emitted segment closes once and is never
reopened. `start_ms` and `end_ms` describe its source transcript intervals.

The default policy groups speakers and overlapping intervals and suppresses
short acknowledgments such as “mhm” when the user continues. Constructor options
use milliseconds:

| Option | Default | Meaning |
| --- | ---: | --- |
| `min_turn_separation_ms` | 500 | Gap before promoting buffered assistant text |
| `assistant_silence_ms` | 2000 | Assistant transcript inactivity before closure |
| `backchannel_max_duration_ms` | 1000 | Maximum suppressed acknowledgment duration; zero disables suppression |
| `backchannel_isolation_ms` | 2000 | Window distinguishing acknowledgments from replies |

`additional_acknowledgments: ["understood"]` adds copied phrases to the built-in
list. Matching normalizes case, hyphens, whitespace and surrounding punctuation.
Timing options accept finite numbers between 0 and 2147483647.

This is a display heuristic, not a lossless transcript, voice-activity detector,
playback monitor or reconstruction of server conversation history. Only
`InputTranscriptDeltaEvent`, `OutputTranscriptDeltaEvent` and `SessionClosedEvent`
are consumed. Duplicate transcript IDs, empty text and unrelated/future events
are ignored. Invalid fields raise `ArgumentError` or the generated model's
`OpenAI::Errors::ConversionError`. Initial speaker changes settle for up to
50 ms. A monotonic local clock supplies an inactivity fallback when source
timestamps stop arriving, so delivery delays can affect grouping.

Successive updates within a burst may be coalesced for up to 50 ms. The first
snapshot of a segment, periodic complete updates and its final snapshot are
still delivered. This avoids copying an entire long turn for every tiny delta;
it does not limit transcript size.

Create one helper per session and close it on transport loss or teardown.
`SessionClosedEvent` also finalizes it. Closing flushes buffered text, cancels
the timer and rejects further `push` calls; it never closes or reconnects a
transport. Close reasons are `:speaker_change`, `:inactivity`, `:timestamp_reset`,
`:session_closed` and `:manual`. None proves that audible speech has finished.

Callbacks are serialized and may call `push` or `close`. They run on the calling
thread or the helper's single timer thread; hand slow display work to your
application's queue. A running callback can finish after another thread closes
the helper. Callback exceptions propagate to the caller or terminate the timer
thread with Ruby's normal exception reporting; close the helper after a callback
failure. Always use `ensure` for cleanup.

The [offline example](examples/live/transcripts.rb) uses generated event models
without opening a session or making an API request.

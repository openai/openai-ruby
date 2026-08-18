# Realtime WebSocket examples

This directory contains runnable examples for the Realtime WebSocket surface:

- `websocket_text.rb` creates a typed text session, sends one user message,
  streams assistant text, verifies a completed response, and exits.
- `websocket_transcription.rb` uploads raw 24 kHz mono PCM16 audio, explicitly
  commits one input turn, streams transcription deltas, verifies the matching
  completed transcript, and exits.

Add the optional transport dependency and set an API key:

```sh
bundle add async-websocket
export OPENAI_API_KEY="your-key"
```

Run the text example from the repository root:

```sh
bundle exec ruby examples/realtime/websocket_text.rb
```

A successful run prints `session.created`, `session.updated`, streamed
assistant text, `response.done status=completed`, and finally
`[realtime] smoke test passed`. Early connection closure, a non-completed
response, or a completed response without text is treated as a failure.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to `Say hello from Ruby.` and is not
  echoed to diagnostic output.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `30`.

## Transcribe one committed audio turn

Convert an audio file to the input format required by the Realtime API, then
run the transcription example:

```sh
ffmpeg -i input.wav -f s16le -acodec pcm_s16le -ac 1 -ar 24000 speech.pcm
bundle exec ruby examples/realtime/websocket_transcription.rb speech.pcm
```

The example defaults to `gpt-transcribe`, which is intended for an explicitly
committed audio turn over a Realtime WebSocket. It correlates transcription
events using `item_id` and treats an early close, failed transcription, empty
completion, or completion for the wrong item as a failure.

Optional environment variables:

- `OPENAI_REALTIME_TRANSCRIPTION_MODEL` — defaults to `gpt-transcribe`.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `60`.

This example intentionally reads a file and drains its result after commit. It
does not claim continuous microphone captioning or concurrent reader/writer
support; those require a separately reviewed lifecycle boundary.

See the repository's [Realtime WebSocket guide](../../realtime.md) for the
public connection API, custom transports, proxy behavior, and TLS setup.

# Realtime WebSocket examples

This directory contains runnable examples for the Realtime WebSocket surface:

- `websocket_text.rb` creates a typed text session, sends one user message,
  streams assistant text, verifies a completed response, and exits.
- `websocket_transcription.rb` uploads raw 24 kHz mono PCM16 audio, explicitly
  commits one input turn, streams transcription deltas, verifies the matching
  completed transcript, and exits.
- `websocket_voice_turn.rb` uploads one raw 24 kHz mono PCM16 turn, explicitly
  commits it, collects the assistant's streamed audio transcript, saves the PCM
  response, verifies a completed response, and exits.

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

## Send one voice turn and save the response

Convert an audio file to 24 kHz mono PCM16, run the voice-turn example, then
play the raw response:

```sh
ffmpeg -i input.wav -f s16le -acodec pcm_s16le -ac 1 -ar 24000 input.pcm
bundle exec ruby examples/realtime/websocket_voice_turn.rb input.pcm response.pcm
ffplay -f s16le -ar 24000 -ac 1 response.pcm
```

The output path must not already exist. This prevents accidental truncation,
including when the input and output paths refer to the same file. The example
stages audio privately and publishes the path only after success, so a failed
or timed-out run leaves no partial response behind and the command can be
retried. `WebSocketVoiceTurn.run` returns the assistant transcript explicitly;
diagnostic output never includes it. The executable boundary also suppresses
payload-bearing parser causes from malformed protocol events. A successful run
writes non-empty response audio, observes `response.done status=completed`,
publishes the requested file, and only then prints
`[realtime] voice turn smoke test passed`.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_VOICE` — defaults to `marin`.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `60`.

This is an explicit, committed file turn. It does not capture a microphone,
play audio while it arrives, or claim full-duplex conversation support; those
require a separately reviewed concurrency and device-lifecycle boundary.

See the repository's [Realtime WebSocket guide](../../realtime.md) for the
public connection API, custom transports, proxy behavior, and TLS setup.

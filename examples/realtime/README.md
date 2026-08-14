# Realtime examples

These examples run against the live OpenAI service with `OPENAI_API_KEY` set.
They default to `gpt-realtime-2.1`; override `OPENAI_REALTIME_MODEL` when needed.

## Browser voice conversation (recommended)

For natural hands-free conversation, use the WebRTC example. Ruby keeps the
standard API key private, accepts the browser's SDP offer, configures the
Realtime call, and returns the SDP answer. The browser owns the media peer and
requests acoustic echo cancellation, noise suppression, and automatic gain
control.

```sh
bundle exec ruby examples/realtime/webrtc_conversation.rb
```

Open `http://127.0.0.1:4567`, click **Start conversation**, and allow microphone
access. Talk normally and speak over the model to interrupt it. Click **Stop**
to close the peer and ask Ruby to hang up the call. No API key is sent to the
browser. Override the port with `REALTIME_DEMO_PORT`.

## WebSocket microphone loop (advanced)

`realtime_conversation.rb` keeps one full-duplex WebSocket session open. It
streams 100 ms microphone chunks continuously, uses server VAD to detect turn
boundaries and create responses automatically, and plays output audio as deltas
arrive. There is no push-to-talk control.

This low-level path has no acoustic echo cancellation. It is useful for server
audio pipelines and protocol debugging, but it is not a laptop speakerphone.
Install FFmpeg (which also supplies `ffplay`) and **use headphones** so the
microphone does not capture the model's voice:

```sh
brew install ffmpeg
bundle exec ruby examples/realtime/realtime_conversation.rb
```

Start speaking after `Connected` appears. Speak again whenever you want to
interrupt: the service cancels the response and the example immediately clears
local playback, drops already-queued audio deltas, and truncates the unheard
audio from conversation history. A bounded single-writer queue serializes the
microphone and truncation events sent over the socket. Press Control-C to end
the session. If that writer fails, the example stops microphone capture,
unblocks any queued producer, and reports the original connection error.

On macOS, the default microphone is AVFoundation audio device `0`. List devices
and select a different index if necessary:

```sh
ffmpeg -f avfoundation -list_devices true -i ""

REALTIME_MIC_DEVICE=:1 \
bundle exec ruby examples/realtime/realtime_conversation.rb
```

macOS may ask for microphone permission for your terminal on the first run.
Customize the voice or spoken behavior with `OPENAI_REALTIME_VOICE` and
`OPENAI_REALTIME_INSTRUCTIONS`. The example defaults to the recommended `marin`
voice. Linux defaults to PulseAudio's `default` device; override
`REALTIME_AUDIO_INPUT_FORMAT` and `REALTIME_MIC_DEVICE` for another FFmpeg input.

For a deterministic live smoke test, provide paced PCM input and capture output
instead of opening audio devices:

```sh
REALTIME_INPUT_PCM=input.pcm \
REALTIME_OUTPUT_PCM=response.pcm \
OPENAI_REALTIME_TIMEOUT=30 \
bundle exec ruby examples/realtime/realtime_conversation.rb
```

This bounded mode exits successfully only after the requested `response.done`;
a clean EOF before that event fails the smoke test.

## WebSocket text

```sh
bundle exec ruby examples/realtime/websocket_text.rb
```

A successful run prints `session.created`, `session.updated`, streamed assistant
text, and `response.done status=completed`. An EOF before the completed
`response.done`, or a completed response without a non-empty text delta, is
reported as a failed smoke test.

## Image input

Send a PNG or JPEG as a Realtime conversation item and stream the model's text
description:

```sh
REALTIME_INPUT_IMAGE=photo.png \
OPENAI_REALTIME_PROMPT='Describe the important details in this image.' \
bundle exec ruby examples/realtime/image_input.rb
```

The example inspects the file signature instead of trusting its extension,
builds the required data URI, and rejects other formats before opening a
session. A successful run requires non-empty text and a completed
`response.done`; early EOF is a failed smoke test.

## Local function calling

Run a complete local tool round trip using the example's deterministic weather
function:

```sh
OPENAI_REALTIME_PROMPT='What is the weather in Paris?' \
bundle exec ruby examples/realtime/function_calling.rb
```

The example forces the first response to call `lookup_weather`, validates and
executes its arguments, sends a typed `function_call_output` conversation item,
then requests a final response with tools disabled. It succeeds only after the
follow-up response emits non-empty text and a completed `response.done`.

## WebSocket audio

The input must be raw, headerless, mono 24 kHz PCM16 little-endian audio. For
example, convert a WAV file with:

```sh
ffmpeg -i input.wav -f s16le -acodec pcm_s16le -ac 1 -ar 24000 input.pcm
```

Then run the example and play its output:

```sh
REALTIME_INPUT_PCM=input.pcm \
REALTIME_OUTPUT_PCM=response.pcm \
bundle exec ruby examples/realtime/websocket_audio.rb

ffplay -f s16le -ar 24000 -ch_layout mono response.pcm
```

A successful run exits with status 0 only after writing audio bytes and seeing a
completed `response.done`. EOF before completion, or completion without an
audio delta, is reported as a failed smoke test. The example disables automatic
turn detection and waits for `session.updated` before uploading, so its explicit
buffer commit and `response.create` cannot race server VAD.

## Realtime transcription

Use the same raw mono 24 kHz PCM16 input format as the audio example:

```sh
REALTIME_INPUT_PCM=input.pcm \
OPENAI_REALTIME_TRANSCRIPTION_MODEL=gpt-live-transcribe \
bundle exec ruby examples/realtime/websocket_transcription.rb
```

A successful run streams transcript deltas, then prints the completed
transcript with its `item_id`. Completion events for different input turns may
arrive out of order, so applications should correlate them by `item_id`.
The example opens a dedicated connection with `connect_transcription`.
Configure its transcription model with `OPENAI_REALTIME_TRANSCRIPTION_MODEL`.
An EOF before the completed transcription event is reported as a failed smoke
test.

## Realtime translation

Translation uses the same raw PCM input format and reads translated transcript
and audio while input is still being uploaded:

```sh
REALTIME_INPUT_PCM=input.pcm \
REALTIME_OUTPUT_PCM=translation.pcm \
TARGET_LANGUAGE=es \
bundle exec ruby examples/realtime/translation.rb
```

A successful run prints the translated transcript, exits after
`session.closed`, and writes non-empty translated PCM audio. An EOF before
`session.closed`, or a closed session with no translated audio, is reported as
incomplete instead of silently succeeding. If upload and graceful close both
fail, the upload error remains the primary failure so the interrupted input
operation is not hidden by cleanup.
If the reader fails while input is still being uploaded, the example cancels
the uploader immediately instead of draining the rest of the file. If the
reader has already failed on buffered input or EOF, upload never starts.

## MCP approval

Point the example at a Streamable HTTP MCP server. This invocation uses the
public OpenAI developer-documentation server:

```sh
MCP_SERVER_URL=https://developers.openai.com/mcp \
OPENAI_REALTIME_PROMPT='Search the OpenAI docs for the Realtime WebSocket URL.' \
bundle exec ruby examples/realtime/mcp_approval.rb
```

The example waits for tool import, selects an advertised tool on the first
`response.create` without replacing the configured MCP server, approves the
request, waits for the tool to finish, and asks the model for the final answer.
It disables parallel tool calls because the example intentionally demonstrates
one approval lifecycle. A successful run prints all five checkpoints and
reaches the final completed `response.done`; a response without the required
MCP call, a final response without non-empty text, or EOF before the final
completion fails the smoke test. Set `OPENAI_REALTIME_DEBUG=1` to print every
event type.

## WebRTC call creation

`webrtc_call.rb` is the server endpoint core: send a browser-generated SDP offer
on stdin, return stdout as `application/sdp`, and retain the call ID printed on
stderr.

```sh
bundle exec ruby examples/realtime/webrtc_call.rb < offer.sdp > answer.sdp
```

The recommended `webrtc_conversation.rb` example above exercises this exchange
end to end with a real `RTCPeerConnection`. `webrtc_call.rb` remains a minimal
stdin/stdout building block for integrating the same SDK call into another web
framework.

## Sideband control

Use the call ID from WebRTC call creation or a verified incoming SIP webhook:

```sh
OPENAI_REALTIME_CALL_ID=rtc_... \
bundle exec ruby examples/realtime/sideband.rb
```

For a bounded smoke test, set `OPENAI_REALTIME_STOP_AFTER=session.updated` and
`OPENAI_REALTIME_TIMEOUT=30`. A real paired test keeps the browser or SIP peer
connected while this process attaches to the same call. EOF before the selected
event fails the bounded smoke test.

## SIP

The SIP example requires an OpenAI project with SIP configured and a real
incoming call. Obtain `OPENAI_REALTIME_CALL_ID` from a verified
`realtime.call.incoming` webhook, then run:

```sh
OPENAI_REALTIME_CALL_ID=rtc_... \
bundle exec ruby examples/realtime/sip.rb
```

The script accepts the call, attaches a sideband WebSocket, and prints the audio
transcript. `OPENAI_REALTIME_STOP_AFTER` and `OPENAI_REALTIME_TIMEOUT` provide
bounded smoke-test controls. Once accepted, the call is hung up during cleanup,
including after a timeout or sideband failure; an already-ended call is treated
as successfully cleaned up. EOF before the selected event fails a bounded run.
Without a carrier-originated incoming call, the same accept-then-attach
orchestration is covered by the local example and HTTP resource tests, but that
is not a substitute for the final telephony smoke test.

## Local protocol coverage

The test suite exercises the examples' orchestration and the documented local
WebSocket lifecycle, including text, image input, local function calling,
transcription, full-duplex translation, MCP approval, fragmented frames, normal
and abnormal closure, sideband control, and SIP accept-then-attach behavior:

```sh
./scripts/test
```

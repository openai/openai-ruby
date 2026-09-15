# Voice and transcription: example direction

Decision record, rechecked September 15, 2026 against official API guidance and
Ruby `origin/main` at `5bdc477abc7e9e040debca40dd14e530b1c80ff1`.

## Decision

**Do not ship the proposed overlapping committed-turn captions example.**
Keep the existing small committed-turn example for its specific protocol use
case. Prioritize a Live conversation reference for talking with an assistant;
consider a separate streaming-transcription reference only for users who need
text from ongoing speech without an assistant response.

The proposed example sent multiple completed audio turns with `gpt-transcribe`.
It would demonstrate scheduling and item correlation, but neither captions
while speech arrives nor interruption handling. Calling it “continuous
captions,” or positioning it as a prerequisite for full-duplex voice, would make
API selection harder. The additional concurrency code is not justified by an
identified customer need for overlapping committed turns.

The unfinished prototype and its dedicated tests have been removed. The earlier
reader/writer architecture approval request is superseded by this reassessment.
A subsequent user decision authorized the [Live conversation example](../live/README.md).
No new SDK API is introduced.

## Choose the workflow before the example

| User goal | Model and service entry point | Ruby starting point / example decision |
| --- | --- | --- |
| Talk with an assistant that listens while speaking and handles interruptions | `gpt-live-1`; Live API. Browser session creation: `POST /v1/live/sessions`. Server audio: `wss://api.openai.com/v1/live/sessions`. | Prefer a Live reference. Browser control starts with `client.live.create` and [`../live/webrtc.rb`](../live/webrtc.rb); see the availability qualification below. |
| Show captions as someone speaks, without an assistant reply | `gpt-live-transcribe`; **Realtime transcription**, despite “live” in the model name. The existing Ruby WebSocket helper opens `/v1/realtime?intent=transcription`; configure `type: :transcription` and the model in `session.update`. | `client.realtime.connect_transcription`. A future example must demonstrate captions before commit and serve a distinct transcription-only need. |
| Transcribe an explicitly completed turn within a Realtime session | `gpt-transcribe`; the same Realtime transcription WebSocket, with explicit audio-buffer commit. | Keep [`websocket_transcription.rb`](websocket_transcription.rb), clearly labeled as a committed-turn protocol example. Do not promote it as the default live-caption workflow. |
| Transcribe an existing recording | A file-transcription model such as `gpt-transcribe`; `POST /v1/audio/transcriptions`. | `client.audio.transcriptions.create` or `create_streaming`; prefer this simpler path for recorded files. Streaming the transcript response does not make the source a live microphone session. |

[GPT-Live model guidance](https://developers.openai.com/api/docs/models/gpt-live-1)
identifies simultaneous listening/speaking and interruption handling.
[Live session creation](https://developers.openai.com/api/reference/typescript/resources/live/methods/create)
and the [Live WebSocket guide](https://developers.openai.com/api/docs/guides/voice-websockets?api=live)
document its distinct endpoints. The
[Realtime transcription guide](https://developers.openai.com/api/docs/guides/realtime-transcription)
recommends `gpt-live-transcribe` for incoming speech and reserves `gpt-transcribe`
for transcription after commit or detected-language output.
[GPT-Transcribe model guidance](https://developers.openai.com/api/docs/models/gpt-transcribe)
also supports the recorded-file workflow.

Ordinary Realtime conversation remains a separate supported choice:
`client.realtime.connect(model: "gpt-realtime-2.1")` uses
`/v1/realtime?model=...`. This recommendation does not deprecate that API or claim
that interruption is exclusive to Live. Prefer Live for the new full-duplex
voice reference because that is its intended conversation model; keep existing
Realtime workflows for customers who need their protocol and behavior.

## What landed in Ruby, and what remains to verify

The checked source includes the generated `client.live.create` resource and a
small browser-offer/backend-answer example. Its request carries
`session: {model: "gpt-live-1"}` and `transport: {type: :webrtc, sdp: offer}`.
The response supplies the session ID and answer SDP. This is session creation,
not a complete conversation or media-lifecycle example.

The checked Ruby tree does **not** expose a Live WebSocket `connect` helper;
`Live::Sideband` is an empty generated resource. Published Live WebSocket
support and the SDK's existing bidirectional Realtime transport therefore must
not be described as an already shipped Ruby Live socket workflow. Recheck the
installed release and any subsequently merged Live helper before implementing
a reference; do not invent a method name or route Live through
`client.realtime.connect`. Live startup uses `session.start` / `session.started`,
which differs from Realtime session configuration.

The existing `connect_transcription` still yields the broad public
`OpenAI::Realtime::Connection`. Keep its methods and matching signatures intact.
An example-selection problem does not justify a transcription-specific public
type, discriminator wrapper, or changes to generated ownership.

## What would justify future examples

### Live conversation

Coordinate with the task owning browser/server examples and extend one canonical
Live reference. In a browser, native `RTCPeerConnection`, `getUserMedia`, media
tracks, and the data channel own negotiation and media. Ruby authenticates the
application and performs supported session/control operations. Do not implement
WebRTC, SDP negotiation, codecs, or a media engine in Ruby.

A reference must demonstrate startup readiness, an audible reply, interruption,
user stop, and failure cleanup. It must release microphone/playback resources and
follow the Live protocol's lifecycle and acknowledgements rather than copy the
ordinary Realtime cancel/truncate/clear sequence. Model interruption does not
remove application lifecycle responsibilities. In particular, stopping speech
does not automatically cancel a delegated backend task; the application owns
that policy. See [Getting started with GPT-Live](https://developers.openai.com/api/docs/guides/live).

### Standalone streaming captions

Keep this as a separate candidate, not a required stage before voice. Add it only
when it fills an identified gap in the existing examples and official guide:
ongoing speech in, provisional captions before commit, corrected final text out.
A model-name substitution in the rejected prototype is insufficient: incoming
transcript events and turn identification must work before commit acknowledgement.

Scope capture and turn detection explicitly. Test correlation across interleaved
turns, terminal/error handling, one reader and serialized writes, backpressure,
owned tasks, finite deadlines, and prompt cancellation. Prove caption timing with
the intended model and representative audio before claiming live performance;
offline event fixtures alone cannot establish that behavior.

## Boundaries

The [Live conversation example](../live/README.md) implements the subsequently
approved browser workflow; standalone streaming captions remain a separate candidate.
It changes no shipped runtime, models, signatures, dependencies, reconnect behavior,
or existing example defaults. Conversational reconnect is not transcription
reconnect or session resumption. SIP, translation, shared live CI, and browser
signaling remain with their respective owners. The shared Notion roadmap and
Realtime guide are not edited here; this decision can inform coordinated updates.

# Live conversation in a browser

This example uses `gpt-live-1` for simultaneous listening and speaking, including
natural interruptions. Ruby creates the session through `client.live.create`;
the browser's native WebRTC APIs own microphone audio, playback, and negotiation.
It does not use the ordinary Realtime conversation protocol or a Ruby media engine.

## Run locally

From this repository, install the development bundle and run:

```sh
bundle install
export OPENAI_API_KEY="your-key"
bundle exec ruby examples/live/conversation.rb
```

Open **http://127.0.0.1:4567** (use that exact host). Choose **Start conversation**,
allow microphone access, and wait for **Connected**. Ask for a short story, then
interrupt to change its setting. Use the audio Play control if autoplay is blocked.
Choose **Stop** and wait for **Session finalized** before leaving the page.

The example uses `async-http`, included by the optional `async-websocket`
dependency in the repository's development bundle. In a separate application,
add those optional example dependencies as needed. No dependency is added to the
SDK runtime. Ruby 3.3 or newer and a modern browser are required.

Optional settings:

- `PORT`: local port, default `4567`; binding remains `127.0.0.1`.
- `OPENAI_LIVE_MODEL`: default `gpt-live-1`.
- `OPENAI_LIVE_BACKEND_MODEL`: default `gpt-5.6-luna`, for managed Responses delegation.

Voice sessions and delegated model usage are billed separately. The backend has
no tools; it handles reasoning questions without requiring a custom worker.
Session recording storage is disabled. Audio still goes to OpenAI when you start.

## Ownership and limits

This is a local development example, not a deployable authentication service.
It checks the exact Host and Origin before creating sessions, keeps the API key
on Ruby's side, restricts frontend commands to `session.close`, and returns generic
errors. It serves a fixed asset list and never logs SDP, transcripts, session IDs,
or service errors. Remote creation has zero retries, a 15-second request timeout,
and a 20-second application deadline. Only one creation runs at a time per server.
A deployed application needs user authentication, authorization and spend controls.

Startup has a 30-second browser deadline. Stop during startup releases local
resources, aborts the browser request, and ignores stale completions. Late-granted
microphone tracks are stopped. Once connected, Stop disables microphone input,
sends `session.close`, and retains the media/data channel until `session.closed`
or a 15-second finalization deadline. The five-minute demo timer requests the same
shutdown. A transient connection loss gets ten seconds to recover; terminal loss
releases resources immediately. All timers belong to their individual run.

Only `session.closed` confirms finalization and final voice duration. It does not
include all delegated backend billing. If startup, shutdown, navigation, or network
failure loses the final event, the UI reports finalization as unconfirmed. In
particular, aborting a browser fetch cannot undo a server-side session creation,
and the server may receive an allocation after the browser has left. This demo
has no independently verified WebRTC-session reclamation endpoint and does not
repurpose the SIP hangup method. Do not automatically retry an uncertain creation.
Closing the local server also does not terminate an already connected browser.

Interruptions are handled by Live over native audio; there is no Realtime
cancel/truncate/clear sequence here. Stopping speech does not imply cancellation
of a delegated backend response. On graceful close, Live may drain active managed
work before the final event. See the official [Live lifecycle guide](https://developers.openai.com/api/docs/guides/live-conversations).

## Verification

Offline checks:

```sh
bundle exec ruby test/openai/live/conversation_example_test.rb
node --test test/examples/live/conversation.test.mjs
bundle exec rake test:examples:inventory
```

The Ruby tests cover session configuration through the generated resource and
local HTTP security boundaries. JavaScript tests exercise application lifecycle
using native-API test doubles; they do not prove media negotiation or model quality.

For live acceptance, use authorized model access and your own microphone. Verify
an audible response, speak over it and hear the changed reply, Stop with a final
event, denied microphone permission, and network loss. Offline tests and a browser
render are not evidence of successful live audio or interruption behavior.

[`webrtc.rb`](webrtc.rb) remains the smaller backend SDP handoff example for
applications that already have a browser UI. See the
[workflow decision](../realtime/continuous_captions.md) for Live versus standalone
transcription, and the official [Live WebRTC guide](https://developers.openai.com/api/docs/guides/voice-webrtc?api=live)
for the service contract.

## Backend WebSocket attachment and forks

For an eligible existing Live session, its backend can attach using the credential
bound to that session or its observer. A connection opens the transport; the
service may replay recent events instead of sending a new `session.started`.
Do not send `session.start` or input audio on the sideband. It accepts normal
session commands such as muting, delegation updates, and instruction appends:

```ruby
client.live.sideband.connect(live_session_id, graceful_close: true) do |sideband|
  sideband.send_event(type: "session.input_audio.mute")
  sideband.each do |event|
    break if event.is_a?(OpenAI::Live::SessionClosedEvent) || event.is_a?(OpenAI::Live::ErrorEvent)
    # Process reflected audio, transcripts, or delegated responses.
  end
end
```

`graceful_close: true` opts into the service's graceful closing handshake.
Pass `false` to opt out, or omit it to use the server's default.

A project-owned stored recording must be available and finalized before it can
be forked. A fork inherits the source session's model and history. Send
`session: {}` to keep its stored configuration, or use `ForkSessionConfig` for
supported overrides. A WebSocket fork cannot override the model or WebRTC
frontend client configuration:

```ruby
client.live.forks.connect(stored_session_id) do |fork|
  fork.send_event(OpenAI::Live::ForkSessionStartEvent.new(session: {}))
  ready = fork.receive
  if ready.is_a?(OpenAI::Live::SessionStartedEvent)
    fork.send_event(type: "session.input_audio.append", audio: encoded_pcm)
  end
end
```

These methods use the same optional `async-websocket` dependency as the primary
`client.live.connect`. They preserve `request_options` headers and timeouts,
including an explicitly selected observer credential in `extra_headers`. The
service owns authorization and session eligibility; project access alone does
not guarantee attachment or a stored fork. Reopening a transport does not
restore a session or replay commands.

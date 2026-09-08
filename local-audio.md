# Local audio

Local audio is opt-in. `require "openai"` alone never loads native audio support,
opens devices, records speech, or starts a subprocess.

## Run the local examples

With `OPENAI_API_KEY` configured, FFmpeg/FFplay on `PATH`, and permission to use
your microphone and speakers:

```sh
bundle exec ruby examples/audio/record_and_play.rb
```

For an interactive Realtime conversation, also build/install the optional native
companion and install `async-websocket`. Use headphones, then run:

```sh
bundle exec ruby examples/realtime/local_audio.rb
```

Ctrl-C closes the conversation. `AUDIO_MAX_PLAYBACKS=1` exits after the first
assistant audio item finishes playing; zero (the default) keeps listening.

### Live API end-to-end verification without physical devices

Build the simulated worker using the [companion build instructions](packages/openai-audio/README.md),
then run the actual example scripts through this opt-in runner:

```sh
OPENAI_AUDIO_TEST_WORKER=/tmp/openai-audio-build/openai-audio-test-worker \
  bundle exec ruby scripts/test-local-audio-examples.rb
```

This makes paid live API calls using `OPENAI_API_KEY`. It generates a known speech
fixture, runs FFmpeg capture from that fixture, uploads it for transcription,
generates speech, and plays it with FFplay's dummy output driver. It also runs the
managed Realtime example through the real WebSocket, native worker subprocess,
resampler and playback clock, with a simulated PortAudio device. The runner
requires a transcript from the recording example and successful device drain from
the Realtime example; each example has a 90-second deadline. Captured API output
and credentials are not printed. Temporary synthetic media is removed on exit.

Both paths were exercised successfully against the live API during development.
These checks cover the complete software flows, but do not validate microphone
permissions, physical speaker output, acoustic echo, or hardware timing. A host
that cannot establish a verified Realtime TLS connection cannot run this test;
certificate verification is never disabled.

## Example model choices

Checked against OpenAI documentation on September 8, 2026:

- Recorded clips use [`gpt-transcribe`](https://developers.openai.com/api/docs/guides/speech-to-text), the recommended general-purpose file transcription model.
- Speech output and synthetic test speech use [`gpt-4o-mini-tts`](https://developers.openai.com/api/docs/guides/text-to-speech) with `marin`, one of the recommended voices for quality.
- Voice conversations use [`gpt-realtime-2.1`](https://developers.openai.com/api/docs/models/gpt-realtime-2.1), which improves recognition, noise handling and interruptions over GPT-Realtime-2. Set `OPENAI_REALTIME_MODEL` to choose another compatible Realtime model.

## Record and play a clip

Install FFmpeg and FFplay separately and put their executables on `PATH`.

```ruby
require "openai"
require "openai/helpers/local_audio"

client = OpenAI::Client.new
clip = OpenAI::LocalAudio.record(duration: 5, timeout: 10)
text = client.audio.transcriptions.create(model: "gpt-transcribe", file: clip)
puts text.text
speech = client.audio.speech.create(model: "gpt-4o-mini-tts", voice: "marin", input: "Hello.")
OpenAI::LocalAudio.play(speech, timeout: 30)
```

`record` returns a `FilePart` containing a finalized mono 24 kHz PCM16 WAV.
It buffers the recording in memory. `duration` must be positive and finite;
`timeout`, when supplied, bounds the complete operation. Cleanup terminates and
reaps the owned child. No total-audio-size limit is imposed; recordings exceeding
classic WAV's length fields use RF64.

`play` accepts `IO`, `StringIO`, or a `FilePart` containing either an IO or bytes.
It consumes from the current position, leaves the caller's stream open, and
returns after the player exits. For raw mono 24 kHz little-endian PCM16, specify
`format: :pcm`; otherwise WAV, MP3, Ogg, AAC and FLAC are allowed. Strings are not
interpreted as filenames or URLs. Network protocols and playlists are disabled.

Capture selectors differ from live-device IDs:

- macOS: AVFoundation audio index/name; `nil` selects its default input.
- Linux: ALSA device name, or an integer expanded to `hw:N`; default is `default`.
- Windows: an explicit DirectShow audio-device name is required.

## Live devices

Live devices require the optional `openai-audio` companion. Its source and build
instructions are in [packages/openai-audio](packages/openai-audio/README.md).
This change does not publish that package. Platform binary releases and physical
device timing measurements remain release gates; the current automated tests use
simulated devices and real resampling/subprocesses.

```ruby
require "openai/helpers/local_audio"

OpenAI::LocalAudio.devices.each do |device|
  puts "#{device.name}: #{device.max_input_channels} inputs, #{device.max_output_channels} outputs"
end

OpenAI::LocalAudio::Microphone.open do |microphone|
  microphone.each { |pcm| consume(pcm) }
end

OpenAI::LocalAudio::Player.open do |player|
  playback = player.begin_playback
  playback.write(pcm_bytes)
  position = playback.finish.wait
end
```

Device IDs are opaque, local enumeration identities. A stale identity fails;
reopening never silently selects a different default device. Opening a microphone
acquires the device; consuming `each` starts capture. Frames are frozen binary
Strings of mono 24 kHz PCM16. Default frame duration is 20 ms and input staging is
250 ms. `stop` discards unread capture and releases the device. Each microphone
has one consumer and cannot restart after stopping.

A player owns one sequential lane. `write` applies bounded backpressure with
100 ms staging by default and preserves partial samples across writes. `finish`
rejects an incomplete final sample. `wait` requires `finish` and waits for device
drain. `interrupt` aborts output, releases blocked writes, and returns a frozen
`PlaybackPosition`; repeated interruption returns the same terminal position.
`played_frames` counts source frames, excluding silence and resampler padding.
The timing quality is `:device_clock_estimate`, not proof of what a person heard.
Unreliable timing or device continuity fails explicitly.

## Managed Realtime conversation

Install `async-websocket` separately, alongside the native companion.

```ruby
require "openai/helpers/realtime_audio"

client.realtime.connect_audio(model: "gpt-realtime-2.1", voice: "marin") do |audio|
  audio.start
  audio.each do |event|
    case event
    when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
      print event.delta
    end
  end
end
```

The factory opens a new socket, configures PCM24k and the requested voice, and
waits for the server's effective configuration acknowledgement. It yields in
`:ready`. `start` opens local devices and enables the selected input policy.
The factory returns the block's result after cleanup. `each` and `wait` are
alternative single consumers; `wait` discards application events. Breaking from
`each` closes the session. Controls may be called from other application threads.

Modes are `:server_vad`, `:semantic_vad`, and `:push_to_talk`. In VAD modes the
server detects/commits turns while the helper owns response creation and
interruption. Server auto-response flags and idle-timeout prompts are excluded.
The `session` hash preserves ordinary settings such as instructions and tools;
conflicting format, voice, modality or turn-policy settings fail before connecting.

```ruby
client.realtime.connect_audio(model: "gpt-realtime-2.1", voice: "marin", mode: :push_to_talk) do |audio|
  audio.start
  turn = audio.start_turn
  # Application waits for its release gesture while recording continues.
  turn.commit # Or turn.discard; a confirmed repeat of the same action is a no-op.
  audio.wait
end
```

`mute` clears uncommitted input; `unmute` resumes according to the current policy.
The acquired microphone stays active while muted or waiting for a push-to-talk
turn; these gates discard captured frames and prevent their transmission.
Neither retracts already committed speech. Native capture generations and device
input timestamps keep pre-gate buffered audio out of newly opened input turns.
A correlated short-input rejection raises `RealtimeAudioTurnError` with the original
server event in `event`, clears that failed turn, and allows a new turn. `interrupt` stops local output before
waiting for cancellation and truncation acknowledgements. `send_text(text)` uses
the same history barrier and requests a new response. Generated audio completion
and device playback completion remain separate events.

Tools stay application-owned. `submit_tool_output(call_id:, output:)` accepts an
output for a known tool call; `respond` explicitly requests continuation. The
helper never runs tools or replays an uncertain write. Managed sessions disable
reconnection; establish a new session explicitly after disconnection.

### Buffering, events and cleanup

`audio_options` accepts `frame_duration`, `input_buffer_duration`,
`output_buffer_duration`, `control_timeout`, `cleanup_timeout`,
`half_duplex_tail_duration`, `playback_directory`, and `event_queue_capacity`.
Defaults are 0.02, 0.25, 0.10, 5, 2, 0.15 seconds, `nil`, and `nil`, respectively.
Times must be positive and finite, except the echo tail may be zero. Frame duration
must represent a whole number of 24 kHz samples. Unknown options fail.

Device staging is bounded; pending generated audio has no fixed total-size cap.
It uses memory by default. A caller-selected `playback_directory` enables private
per-item PCM temporary files, removed on drain, interruption and close. Hard
process termination can leave files there; the directory owner manages recovery.

Application events exclude consumed raw audio deltas and retain other server
and unknown events. Local events under `AudioSession` are `PlaybackStarted`,
`PlaybackFinished`, `PlaybackInterrupted`, `InputStateChanged`, and `Closed`.
The lossless application queue uses memory by default. A positive caller-selected
`event_queue_capacity` makes a slow consumer fail explicitly. Fatal errors wake
consumers and controls even when the event queue is full.

Use headphones for `playback_policy: :duplex`. `:half_duplex` gates capture during
speaker output and the echo tail; it cannot detect voice barge-in while gated.
Explicit interruption and PTT remain available. Neither policy implements AEC.

Device revocation/unplugging, capture overflow, worker failures and unreliable
playback clocks raise `LocalAudio::Error` subclasses. Managed protocol/state/event
queue failures use `OpenAI::Errors::RealtimeAudioSessionError` subclasses;
existing SDK network/authentication errors retain their types. Block exit closes
all owned resources and preserves a caller exception if cleanup also fails.

See the [full design](docs/architecture/local-audio.md) for the lifecycle and
interruption contracts, source evidence, and remaining native release validation.

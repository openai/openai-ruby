# Local recording and playback

Use `OpenAI::LocalAudio` to record a finite microphone clip or play generated
speech. These helpers run separately installed FFmpeg and FFplay executables.
They do not add native gem dependencies. Loading `openai` or the helper does not
open a device; calling `record` or `play` starts the corresponding operation.

## Setup

Install FFmpeg and FFplay and make both executables available on `PATH`. Your
FFmpeg build must include the capture backend for your operating system. Allow
microphone access in your operating system when recording.

With `OPENAI_API_KEY` configured, run:

```sh
bundle exec ruby examples/audio/record_and_play.rb
```

The example records five seconds, uploads the clip for transcription, prints the
transcript, and plays generated speech. Models and voice are constants at the top
of the example so they are easy to change.

## Record a clip

```ruby
require "openai"
require "openai/helpers/local_audio"

client = OpenAI::Client.new
clip = OpenAI::LocalAudio.record(duration: 5, timeout: 10)
transcript = client.audio.transcriptions.create(model: "gpt-transcribe", file: clip)
puts(transcript.text)
```

`record(duration:, device: nil, timeout: nil)` returns an `OpenAI::FilePart`
containing a rewound `StringIO`, named `audio.wav` with content type `audio/wav`.
The audio is mono, 24 kHz, signed 16-bit PCM. The helper buffers the recording in
memory, so memory use grows with recording duration.

`duration` is required and must be positive and finite. `timeout` is an optional
positive, finite wall-clock deadline in seconds. An expired deadline raises an
error rather than returning a partial recording.

### Choose a microphone

On macOS and Linux, omitting `device:` uses the capture backend's default device.
To select another microphone, pass `device:` directly:

```ruby
# macOS: AVFoundation audio device index (or its device name).
clip = OpenAI::LocalAudio.record(duration: 5, device: 0)

# Linux: ALSA device name; integer 0 is shorthand for "hw:0".
clip = OpenAI::LocalAudio.record(duration: 5, device: "hw:0")

# Windows: DirectShow requires an explicit audio device name.
clip = OpenAI::LocalAudio.record(duration: 5, device: "Microphone (USB Audio)")
```

For Windows, add the appropriate `device:` argument to the example's `record`
call. There is no device environment variable to configure. Device names and
indices are local to your machine and may change when hardware is reconnected.

List capture devices using your platform's tools:

```sh
# macOS (FFmpeg prints the list and exits without recording)
ffmpeg -f avfoundation -list_devices true -i ""

# Linux
arecord -L

# Windows (FFmpeg prints the list and exits without recording)
ffmpeg -list_devices true -f dshow -i dummy
```

## Play speech

```ruby
speech = client.audio.speech.create(
  model: "gpt-4o-mini-tts",
  voice: "marin",
  input: "Recording complete."
)
OpenAI::LocalAudio.play(speech, timeout: 30)
```

`play(source, format: :auto, timeout: nil)` waits for FFplay to finish and returns
`nil`. It accepts `IO`, `StringIO`, or a `FilePart` containing IO or binary bytes.
It reads from the source's current position and leaves caller-owned IO open. Bare
strings are not interpreted as file paths or URLs.

The default `format: :auto` supports self-contained WAV, MP3, Ogg, AAC and FLAC
streams. For headerless mono 24 kHz signed little-endian PCM16, pass
`format: :pcm`. PCM must end on a complete two-byte sample. Playback uses FFplay's
configured output device; this helper has no output-device selector.

Both methods close their pipes and terminate/reap owned subprocesses on errors
or interruption. Errors are under `OpenAI::LocalAudio::Error`:
`DependencyError`, `UnsupportedPlatformError`, `DeviceError`, `PlaybackError`,
`FormatError`, and `TimeoutError`. Media subprocesses receive a restricted
environment without the API key, and their diagnostics are not included in
exceptions. FFplay can exit successfully despite a decoder or device error, so
the helper drains error-level diagnostics through a pipe, retaining only whether
an error occurred. Diagnostic contents are discarded and never written to disk.

## Model choices

Checked against OpenAI documentation on September 8, 2026:

- [`gpt-transcribe`](https://developers.openai.com/api/docs/guides/speech-to-text) is the recommended model for general-purpose file transcription.
- [`gpt-4o-mini-tts`](https://developers.openai.com/api/docs/guides/text-to-speech) is the current recommended speech-generation model; `marin` is one of the recommended voices for quality.

## Realtime applications

For streaming audio and conversation events, use the existing
[Realtime API helpers](realtime.md) and [Realtime examples](examples/realtime/README.md).
The finite helpers here do not manage a continuous microphone stream,
interruptible voice conversation, echo cancellation, or playback-position tracking.

## End-to-end verification

Run the actual recording example against the live API without opening physical
devices:

```sh
bundle exec ruby scripts/test-local-audio-examples.rb
```

To also run the invalid-audio regression against installed FFplay:

```sh
OPENAI_AUDIO_FFPLAY_TEST=1 bundle exec ruby test/openai/helpers/local_audio_test.rb
```

This opt-in test requires `OPENAI_API_KEY`, FFmpeg and FFplay and makes paid API
calls. It generates synthetic speech, substitutes that file for microphone input,
runs real FFmpeg capture and transcription, generates speech, and plays it through
FFplay's dummy output driver. It checks the transcription and successful example
completion with a 90-second example deadline. Captured API output is not logged;
temporary synthetic media is removed on normal exit or exceptions.

This verifies the software flow, not physical microphone permissions, speaker
output, or device compatibility. Physical hardware and platform behavior must be
checked on the intended host.

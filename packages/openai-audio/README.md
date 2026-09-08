# openai-audio companion

Development source for the optional native worker used by
`openai/helpers/local_audio`. This package is independent of the main gem and
receives no API credentials. No package has been published by this change.

## Build

Install a C++17 compiler, CMake, PortAudio and libsamplerate development files.
Review their source and licenses before building. CMake accepts explicit
`PORTAUDIO_INCLUDE_DIR`, `PORTAUDIO_LIBRARY`, `SAMPLERATE_INCLUDE_DIR` and
`SAMPLERATE_LIBRARY` paths when they are not on the default search path.

```sh
cmake -S packages/openai-audio -B /tmp/openai-audio-build -DCMAKE_BUILD_TYPE=Release
cmake --build /tmp/openai-audio-build
ctest --test-dir /tmp/openai-audio-build --output-on-failure
bundle exec ruby packages/openai-audio/test/integration_test.rb /tmp/openai-audio-build/openai-audio-test-worker
cmake --install /tmp/openai-audio-build --prefix "$PWD/packages/openai-audio"
```

For local development, add `packages/openai-audio/lib` to `RUBYLIB`. Build the
companion gem from its directory only after installing the executable into its
`bin` directory. Binary releases need platform-specific packaging and upstream
license notices. The main SDK has no dependency on this package.

## Process contract

Protocol version 1 uses independent control and media pipes. A process owns one
capture or playback stream generation. The controller's standard input accepts
numbered `start`, `gate`, `abort` and `close` lines; EOF also closes the device. Standard
output contains numbered status lines and length-framed PCM capture. Capture
packets retain a native generation derived from an input-clock fence. A gate
acknowledgement follows resampler flush and delivery of the preceding generation;
Ruby also waits for its consumer delivery marker. This prevents buffered ambient
audio from being relabeled into a later turn. In playback
mode descriptor 2 is a read-only media pipe, not a diagnostics stream. Each media
packet contains a little-endian 32-bit request ID and byte count, followed by at
most 8,192 PCM bytes; a zero-length packet ends input. This packet size bounds IPC
staging and does not limit total audio duration. No shell or network is involved.

Device callbacks use preallocated single-producer/single-consumer rings. Normal
threads resample and perform IPC. Output frames carry source positions, and the
controller advances delivery against PortAudio's device clock. Abort snapshots
before stopping the stream, conservatively excluding delivery during shutdown.
Silence does not advance the source position. Callback timestamps must agree with
the device clock direction and negotiated latency, allowing two callback buffers
of timing tolerance. Incoherent positive timestamps fail explicitly. Unreliable clocks, ring overflow,
unplugging, or transport failure terminate the operation.

## Validation limits

Automated integration uses a simulated PortAudio device with real resampling and
real subprocess pipes. It never opens a microphone or speaker. The native worker
has compiled on macOS during development. Linux/Windows builds and physical
loopback measurements remain release gates. Headphones are the duplex baseline;
this worker does not implement acoustic echo cancellation.

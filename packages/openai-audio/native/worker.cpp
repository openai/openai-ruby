#include "audio_ring.hpp"
#include <portaudio.h>
#include <samplerate.h>
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <mutex>
#include <string>
#include <thread>
#ifdef _WIN32
#include <fcntl.h>
#include <io.h>
#define READ _read
#else
#include <unistd.h>
#define READ read
#endif

namespace {
using namespace openai_audio;
using namespace std::chrono_literals;
static_assert(std::atomic<size_t>::is_always_lock_free);
static_assert(std::atomic<bool>::is_always_lock_free);
static_assert(std::atomic<uint64_t>::is_always_lock_free);

std::mutex output_mutex;
void status(uint64_t id, const char *code, uint64_t value = 0) {
  std::lock_guard<std::mutex> lock(output_mutex);
  std::cout << id << ' ' << code << ' ' << value << '\n' << std::flush;
}
bool read_exact(int fd, void *destination, size_t bytes) {
  auto *out = static_cast<char *>(destination);
  while (bytes) {
    auto count = READ(fd, out, static_cast<unsigned int>(std::min(bytes, size_t(65536))));
    if (count <= 0) return false;
    bytes -= count;
    out += count;
  }
  return true;
}
uint32_t little32(const unsigned char *bytes) {
  return uint32_t(bytes[0]) | uint32_t(bytes[1]) << 8 |
         uint32_t(bytes[2]) << 16 | uint32_t(bytes[3]) << 24;
}
std::string hex(const char *value) {
  const char *digits = "0123456789abcdef";
  std::string result;
  for (const auto *p = reinterpret_cast<const unsigned char *>(value); *p; ++p) {
    result += digits[*p >> 4]; result += digits[*p & 15];
  }
  return result;
}
std::string identity(int index) {
  const auto *device = Pa_GetDeviceInfo(index);
  const auto *host = device ? Pa_GetHostApiInfo(device->hostApi) : nullptr;
  if (!host) return "";
  return std::to_string(index) + ":" + hex(device->name) + ":" + hex(host->name);
}
struct CaptureGate { double time; uint64_t generation; uint64_t previous; };
static_assert(std::atomic<CaptureGate *>::is_always_lock_free);
struct Stream {
  explicit Stream(size_t capacity, double rate, bool capture)
      : samples(capacity), clock(capacity + size_t(rate)), rate(rate), capture(capture) {}
  Ring<Sample> samples;
  PlaybackClock clock;
  CallbackClock callback_clock;
  double latency = 0;
  double rate;
  bool capture;
  std::atomic<bool> failed{false}, stopped{false}, eof{false};
  uint64_t captured = 0;
  double last_input_time = 0;
  CaptureGate gates[2]{{0, 0, 0}, {0, 0, 0}};
  std::atomic<CaptureGate *> capture_gate{&gates[0]};
  std::atomic<uint64_t> observed_generation{0};
  std::atomic<uint64_t> produced{0}, delivered{0}, total_source{0};
};
int callback(const void *input, void *output, unsigned long count,
             const PaStreamCallbackTimeInfo *time, PaStreamCallbackFlags flags, void *context) {
  auto &stream = *static_cast<Stream *>(context);
  if (stream.stopped.load()) return paAbort;
  if (flags & (stream.capture ? paInputOverflow : paOutputUnderflow)) {
    stream.failed.store(true); return paAbort;
  }
  if (!time || !stream.callback_clock.valid(time->currentTime,
      stream.capture ? time->inputBufferAdcTime : time->outputBufferDacTime,
      stream.latency, count / stream.rate, stream.capture)) {
    stream.failed.store(true); return paAbort;
  }
  if (stream.capture) {
    if (!input) { stream.failed.store(true); return paAbort; }
    if (!std::isfinite(time->inputBufferAdcTime) || time->inputBufferAdcTime <= 0 ||
        time->inputBufferAdcTime < stream.last_input_time) {
      stream.failed.store(true); return paAbort;
    }
    stream.last_input_time = time->inputBufferAdcTime;
    const CaptureGate gate = *stream.capture_gate.load(std::memory_order_acquire);
    const auto *samples = static_cast<const float *>(input);
    for (unsigned long i = 0; i < count; ++i) {
      if (!stream.samples.push({samples[i], ++stream.captured,
                                time->inputBufferAdcTime + i / stream.rate >= gate.time ? gate.generation : gate.previous})) {
        stream.failed.store(true); return paAbort;
      }
    }
  } else {
    auto *samples = static_cast<float *>(output);
    for (unsigned long i = 0; i < count; ++i) {
      Sample sample;
      if (stream.samples.pop(sample)) {
        samples[i] = sample.value;
        if (!stream.clock.publish(time->outputBufferDacTime + (i + 1) / stream.rate, sample.source_end)) {
          stream.failed.store(true); return paAbort;
        }
        stream.delivered.fetch_add(1, std::memory_order_release);
      } else samples[i] = 0;
    }
  }
  return paContinue;
}
// Conversion and all IPC run on ordinary worker threads, never in the callback.
void playback_input(Stream &stream) {
  int error = 0;
  SRC_STATE *converter = src_new(SRC_SINC_FASTEST, 1, &error);
  if (!converter) { stream.failed.store(true); return; }
  std::vector<unsigned char> bytes(8192);
  std::vector<float> input(4096), output(65536);
  uint64_t source_frames = 0, output_frames = 0;
  while (!stream.stopped.load()) {
    unsigned char header[8];
    if (!read_exact(2, header, sizeof(header))) { stream.failed.store(true); break; }
    const uint32_t id = little32(header), length = little32(header + 4);
    if (length > bytes.size() || length % 2) { stream.failed.store(true); break; }
    if (!read_exact(2, bytes.data(), length)) { stream.failed.store(true); break; }
    for (size_t i = 0; i < length / 2; ++i) {
      const uint16_t sample = uint16_t(bytes[i * 2]) | uint16_t(bytes[i * 2 + 1]) << 8;
      input[i] = (sample >= 32768 ? int(sample) - 65536 : int(sample)) / 32768.0f;
    }
    source_frames += length / 2;
    long consumed = 0;
    do {
      SRC_DATA data{};
      data.data_in = input.data() + consumed;
      data.input_frames = long(length / 2) - consumed;
      data.data_out = output.data(); data.output_frames = long(output.size());
      data.src_ratio = stream.rate / 24000.0; data.end_of_input = length == 0;
      if (src_process(converter, &data)) { stream.failed.store(true); break; }
      consumed += data.input_frames_used;
      for (long i = 0; i < data.output_frames_gen && !stream.stopped.load(); ++i) {
        const auto position = std::min(source_frames, uint64_t(std::floor(++output_frames * 24000.0 / stream.rate)));
        while (!stream.samples.push({output[i], position}) && !stream.stopped.load())
          std::this_thread::sleep_for(1ms);
        stream.produced.fetch_add(1, std::memory_order_release);
      }
      if (!data.output_frames_gen && !data.input_frames_used) break;
    } while (consumed < long(length / 2) || length == 0);
    if (stream.stopped.load() || stream.failed.load()) break;
    status(id, "accepted", length);
    if (!length) { stream.total_source.store(source_frames); stream.eof.store(true); break; }
  }
  src_delete(converter);
}
void capture_samples(Stream &stream, const float *samples, long count, uint64_t generation,
                     std::vector<char> &frame, size_t &filled) {
  for (long i = 0; i < count && !stream.stopped.load(); ++i) {
    short sample;
    src_float_to_short_array(samples + i, &sample, 1);
    frame[filled++] = char(uint16_t(sample) & 255);
    frame[filled++] = char(uint16_t(sample) >> 8);
    if (filled == frame.size()) {
      std::lock_guard<std::mutex> lock(output_mutex);
      std::cout << generation << " pcm " << filled << '\n';
      std::cout.write(frame.data(), filled); std::cout.flush();
      filled = 0;
    }
  }
}
void capture_flush(Stream &stream, SRC_STATE *converter, uint64_t generation,
                   std::vector<float> &output, std::vector<char> &frame, size_t &filled) {
  while (!stream.stopped.load()) {
    SRC_DATA data{};
    float empty = 0;
    data.data_in = &empty; data.data_out = output.data();
    data.output_frames = long(output.size()); data.end_of_input = 1;
    data.src_ratio = 24000.0 / stream.rate;
    if (src_process(converter, &data)) { stream.failed.store(true); return; }
    capture_samples(stream, output.data(), data.output_frames_gen, generation, frame, filled);
    if (!data.output_frames_gen) break;
  }
  if (filled) {
    std::lock_guard<std::mutex> lock(output_mutex);
    std::cout << generation << " pcm " << filled << '\n';
    std::cout.write(frame.data(), filled); std::cout.flush();
    filled = 0;
  }
}
void capture_output(Stream &stream, size_t frame_samples) {
  int error = 0;
  SRC_STATE *converter = src_new(SRC_SINC_FASTEST, 1, &error);
  if (!converter) { stream.failed.store(true); return; }
  std::vector<float> input(1024), output(65536);
  std::vector<char> frame(frame_samples * 2);
  size_t filled = 0;
  uint64_t generation = 0;
  Sample held;
  bool has_held = false;
  while (!stream.stopped.load() && !stream.failed.load()) {
    size_t count = 0;
    Sample sample;
    while (count < input.size()) {
      if (has_held) { sample = held; has_held = false; }
      else if (!stream.samples.pop(sample)) break;
      if (sample.capture_generation != generation) {
        if (count) { held = sample; has_held = true; break; }
        capture_flush(stream, converter, generation, output, frame, filled);
        generation = sample.capture_generation;
        src_reset(converter);
        stream.observed_generation.store(generation, std::memory_order_release);
      }
      input[count++] = sample.value;
    }
    if (!count) { std::this_thread::sleep_for(1ms); continue; }
    size_t consumed = 0;
    do {
      SRC_DATA data{};
      data.data_in = input.data() + consumed; data.input_frames = long(count - consumed);
      data.data_out = output.data(); data.output_frames = long(output.size());
      data.src_ratio = 24000.0 / stream.rate;
      if (src_process(converter, &data)) { stream.failed.store(true); break; }
      consumed += data.input_frames_used;
      capture_samples(stream, output.data(), data.output_frames_gen, generation, frame, filled);
      if (!data.input_frames_used && !data.output_frames_gen) break;
    } while (consumed < count);
  }
  src_delete(converter);
}
}

int main(int argc, char **argv) {
#ifdef _WIN32
  _setmode(0, _O_BINARY); _setmode(1, _O_BINARY); _setmode(2, _O_BINARY);
#endif
  // No diagnostics, credentials, paths or audio are included in error frames.
  if (argc == 2 && std::string(argv[1]) == "version") { std::cout << "1\n"; return 0; }
  if (Pa_Initialize() != paNoError) return 1;
  if (argc == 2 && std::string(argv[1]) == "devices") {
    for (int i = 0; i < Pa_GetDeviceCount(); ++i) {
      const auto *device = Pa_GetDeviceInfo(i);
      std::cout << identity(i) << ' ' << device->maxInputChannels << ' ' << device->maxOutputChannels << ' ' << (i == Pa_GetDefaultInputDevice()) << ' ' << (i == Pa_GetDefaultOutputDevice()) << '\n';
    }
    Pa_Terminate(); return 0;
  }
  if (argc != 5) { Pa_Terminate(); return 1; }
  const bool capture = std::string(argv[1]) == "capture";
  if (!capture && std::string(argv[1]) != "playback") { Pa_Terminate(); return 1; }
  const std::string selector = argv[2];
  int device = capture ? Pa_GetDefaultInputDevice() : Pa_GetDefaultOutputDevice();
  if (selector != "default") {
    device = -1;
    for (int i = 0; i < Pa_GetDeviceCount(); ++i)
      if (identity(i) == selector) device = i;
  }
  const auto *info = Pa_GetDeviceInfo(device);
  char *end = nullptr;
  const double buffer_seconds = std::strtod(argv[3], &end);
  if (!info || !end || *end || !std::isfinite(buffer_seconds) || buffer_seconds <= 0 ||
      (capture ? info->maxInputChannels : info->maxOutputChannels) < 1) { Pa_Terminate(); return 1; }
  const double frame_value = std::strtod(argv[4], &end);
  if (!end || *end || !std::isfinite(frame_value) || frame_value < 1 ||
      frame_value != std::floor(frame_value) || frame_value >= double(SIZE_MAX / 2)) return 1;
  const auto frame_samples = size_t(frame_value);
  const double rate = info->defaultSampleRate;
  if (!src_is_valid_ratio(rate / 24000.0) || !src_is_valid_ratio(24000.0 / rate)) return 1;
  const double capacity = std::ceil(rate * buffer_seconds);
  if (!std::isfinite(capacity) || capacity > double(SIZE_MAX / sizeof(Sample) - 1)) return 1;
  Stream stream(size_t(capacity), rate, capture);
  PaStreamParameters parameters{device, 1, paFloat32,
    capture ? info->defaultLowInputLatency : info->defaultLowOutputLatency, nullptr};
  PaStream *handle = nullptr;
  if (Pa_OpenStream(&handle, capture ? &parameters : nullptr, capture ? nullptr : &parameters,
                    rate, paFramesPerBufferUnspecified, paNoFlag, callback, &stream) != paNoError) {
    Pa_Terminate(); return 1;
  }
  const auto *stream_info = Pa_GetStreamInfo(handle);
  if (!stream_info || stream_info->sampleRate != rate) {
    Pa_CloseStream(handle); Pa_Terminate(); return 1;
  }
  stream.latency = capture ? stream_info->inputLatency : stream_info->outputLatency;
  if (!std::isfinite(stream.latency) || stream.latency < 0) {
    Pa_CloseStream(handle); Pa_Terminate(); return 1;
  }
  status(0, "ready");
  // Exactly one stream generation per process. EOF on control terminates the
  // device even if the media pipe is blocked or its owner disappears.
  std::mutex command_mutex;
  int command = 0;
  uint64_t command_id = 0;
  std::atomic<bool> control_closed{false};
  std::thread([&] {
    std::string line;
    char character;
    while (read_exact(0, &character, 1)) {
      if (character != '\n') {
        if (line.size() >= 128) break;
        line += character; continue;
      }
      unsigned long long id; char operation[16], trailing;
      if (std::sscanf(line.c_str(), "%llu %15s %c", &id, operation, &trailing) != 2) break;
      int value = std::strcmp(operation, "start") == 0 ? 1 :
                  std::strcmp(operation, "abort") == 0 ? 2 :
                  std::strcmp(operation, "close") == 0 ? 3 :
                  std::strcmp(operation, "gate") == 0 ? 4 : 0;
      {
        std::lock_guard<std::mutex> lock(command_mutex);
        if (!value || command != 0) break;
        command_id = id; command = value;
      }
      line.clear();
    }
    control_closed.store(true);
  }).detach();
  bool started = false, terminal = false, requested_close = false;
  uint64_t played = 0, pending_fence = 0, fence_id = 0;
  while (true) {
    int action;
    uint64_t action_id;
    {
      std::lock_guard<std::mutex> lock(command_mutex);
      action = command; action_id = command_id; command = 0;
    }
    if (action == 3 || control_closed.load()) { requested_close = true; break; }
    if (stream.failed.load() || !std::cout.good()) break;
    if (action == 1) {
      if (started || terminal || Pa_StartStream(handle) != paNoError) break;
      started = true;
      if (capture) std::thread(capture_output, std::ref(stream), frame_samples).detach();
      else std::thread(playback_input, std::ref(stream)).detach();
      status(action_id, "started");
    }
    if (action == 4) {
      if (!started || !capture || pending_fence) break;
      const auto now = Pa_GetStreamTime(handle);
      if (!std::isfinite(now) || now <= 0) break;
      const auto *previous = stream.capture_gate.load(std::memory_order_acquire);
      auto *next = previous == &stream.gates[0] ? &stream.gates[1] : &stream.gates[0];
      *next = {now, previous->generation + 1, previous->generation};
      // Reuse a gate slot only after the preceding fence was observed by the
      // capture consumer. The callback which read that older slot has therefore
      // completed, so the callback can copy this immutable snapshot without locks.
      stream.capture_gate.store(next, std::memory_order_release);
      pending_fence = next->generation; fence_id = action_id;
    }
    if (pending_fence && stream.observed_generation.load(std::memory_order_acquire) >= pending_fence) {
      status(fence_id, "fenced", pending_fence); pending_fence = 0;
    }
    if (started && !capture) {
      played = stream.clock.advance(Pa_GetStreamTime(handle));
      if (!stream.clock.valid()) break;
    }
    if (action == 2) {
      stream.stopped.store(true);
      // Snapshot before abort: returning an underestimate is conservative;
      // samples delivered during the abort call must never be overcounted.
      if (started && Pa_AbortStream(handle) != paNoError) break;
      started = false; terminal = true;
      status(action_id, "interrupted", played);
    }
    if (started && Pa_IsStreamActive(handle) != 1) break;
    if (!capture && started && stream.eof.load() &&
        stream.delivered.load() == stream.produced.load() && stream.clock.settled()) {
      if (Pa_StopStream(handle) != paNoError) break;
      played = stream.total_source.load();
      started = false; terminal = true;
      status(0, "finished", played);
    }
    std::this_thread::sleep_for(1ms);
  }
  stream.stopped.store(true);
  if (started) Pa_AbortStream(handle);
  Pa_CloseStream(handle); Pa_Terminate();
  status(0, requested_close ? "closed" : (capture ? "capture_error" : "playback_error"));
  // Media/control threads may be blocked in pipe reads. Process teardown closes
  // those descriptors after the device has been synchronously stopped.
  std::_Exit(0);
}

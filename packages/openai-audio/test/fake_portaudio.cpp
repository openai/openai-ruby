// Deterministic device substitute for the worker integration tests. This file is
// linked only into a test executable; it is never part of the companion package.
#include <portaudio.h>
#include <atomic>
#include <chrono>
#include <thread>
#include <vector>

namespace {
struct FakeStream {
  PaStreamCallback *callback;
  void *context;
  bool capture;
  double rate;
  int device;
  std::atomic<bool> active{false};
  std::thread thread;
};
double clock_now() {
  return std::chrono::duration<double>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
PaDeviceInfo device{2, "Test device", 0, 1, 1, .01, .01, .1, .1, 48000};
PaDeviceInfo future_device{2, "Future DAC clock", 0, 0, 1, .01, .01, .1, .1, 48000};
PaDeviceInfo past_device{2, "Past DAC clock", 0, 0, 1, .01, .01, .1, .1, 48000};
PaStreamInfo stream_info{1, .01, .01, 48000};
PaHostApiInfo host{1, paInDevelopment, "Test host", 1, 0, 0};
}
extern "C" {
PaError Pa_Initialize() { return paNoError; }
PaError Pa_Terminate() { return paNoError; }
PaDeviceIndex Pa_GetDeviceCount() { return 3; }
PaDeviceIndex Pa_GetDefaultInputDevice() { return 0; }
PaDeviceIndex Pa_GetDefaultOutputDevice() { return 0; }
const PaDeviceInfo *Pa_GetDeviceInfo(PaDeviceIndex index) {
  return index == 0 ? &device : index == 1 ? &future_device : index == 2 ? &past_device : nullptr;
}
const PaStreamInfo *Pa_GetStreamInfo(PaStream *) { return &stream_info; }
const PaHostApiInfo *Pa_GetHostApiInfo(PaHostApiIndex index) { return index == 0 ? &host : nullptr; }
PaError Pa_OpenStream(PaStream **result, const PaStreamParameters *input, const PaStreamParameters *output,
                     double rate, unsigned long, PaStreamFlags, PaStreamCallback *callback, void *context) {
  *result = new FakeStream{callback, context, input != nullptr, rate, input ? input->device : output->device, false, {}};
  return paNoError;
}
PaError Pa_StartStream(PaStream *handle) {
  auto *stream = static_cast<FakeStream *>(handle);
  stream->active = true;
  stream->thread = std::thread([stream] {
    std::vector<float> input(240, .125f), output(240);
    while (stream->active) {
      const double now = clock_now();
      PaStreamCallbackTimeInfo timing{now - .01, now, now + .01};
      if (stream->device == 1) timing.outputBufferDacTime = now + 60;
      if (stream->device == 2) timing.outputBufferDacTime = now - 60;
      if (stream->callback(stream->capture ? input.data() : nullptr,
                           stream->capture ? nullptr : output.data(), 240, &timing, 0, stream->context) != paContinue) {
        stream->active = false;
        break;
      }
      std::this_thread::sleep_for(std::chrono::milliseconds(5));
    }
  });
  return paNoError;
}
PaError Pa_AbortStream(PaStream *handle) {
  auto *stream = static_cast<FakeStream *>(handle);
  stream->active = false;
  if (stream->thread.joinable()) stream->thread.join();
  return paNoError;
}
PaError Pa_StopStream(PaStream *handle) { return Pa_AbortStream(handle); }
PaError Pa_CloseStream(PaStream *handle) {
  Pa_AbortStream(handle); delete static_cast<FakeStream *>(handle); return paNoError;
}
PaTime Pa_GetStreamTime(PaStream *) { return clock_now(); }
PaError Pa_IsStreamActive(PaStream *handle) { return static_cast<FakeStream *>(handle)->active ? 1 : 0; }
}

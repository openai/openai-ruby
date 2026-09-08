#include "../native/audio_ring.hpp"
#ifdef NDEBUG
#undef NDEBUG
#endif
#include <cassert>
#include <limits>
#include <thread>

int main() {
  using namespace openai_audio;
  Ring<uint64_t> ring(3);
  assert(ring.push(1) && ring.push(2) && ring.push(3));
  assert(!ring.push(4));
  uint64_t value;
  assert(ring.pop(value) && value == 1);
  assert(ring.push(4));
  for (uint64_t expected = 2; expected <= 4; ++expected)
    assert(ring.pop(value) && value == expected);
  assert(!ring.pop(value));

  std::thread producer([&] {
    for (uint64_t i = 0; i < 100000; ++i)
      while (!ring.push(i)) std::this_thread::yield();
  });
  for (uint64_t i = 0; i < 100000; ++i) {
    while (!ring.pop(value)) std::this_thread::yield();
    assert(value == i);
  }
  producer.join();

  PlaybackClock clock(4);
  assert(clock.publish(10.01, 240));
  assert(clock.publish(10.02, 480));
  assert(clock.advance(10) == 0);
  assert(clock.advance(10.015) == 240);
  assert(clock.advance(10.02) == 480);
  assert(clock.advance(11) == 480); // silence does not advance source position
  assert(!clock.publish(10, 500));
  clock.advance(std::numeric_limits<double>::quiet_NaN());
  assert(!clock.valid());

  CallbackClock callback_clock;
  assert(callback_clock.valid(10, 10.01, .01, .005, false));
  assert(!callback_clock.valid(11, 1, .01, .005, false));
  assert(!callback_clock.valid(12, 100, .01, .005, false));
  assert(!callback_clock.valid(11, 11.01, .01, .005, false));
  assert(callback_clock.valid(13, 12.99, .01, .005, true));
  assert(!callback_clock.valid(14, 14.01, .01, .005, true));
}

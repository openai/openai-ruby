#pragma once

#include <atomic>
#include <cmath>
#include <cstdint>
#include <vector>

namespace openai_audio {
// One producer, one consumer. Storage is allocated before the device starts.
// Each output frame carries the exclusive source-frame position it represents.
struct Sample {
  float value = 0;
  uint64_t source_end = 0;
  uint64_t capture_generation = 0;
};

template <typename T> class Ring {
 public:
  explicit Ring(size_t capacity) : data_(capacity + 1) {}
  bool push(const T &value) noexcept {
    const auto head = head_.load(std::memory_order_relaxed);
    const auto next = (head + 1) % data_.size();
    if (next == tail_.load(std::memory_order_acquire)) return false;
    data_[head] = value;
    head_.store(next, std::memory_order_release);
    return true;
  }
  bool pop(T &value) noexcept {
    const auto tail = tail_.load(std::memory_order_relaxed);
    if (tail == head_.load(std::memory_order_acquire)) return false;
    value = data_[tail];
    tail_.store((tail + 1) % data_.size(), std::memory_order_release);
    return true;
  }
  bool empty() const noexcept {
    return tail_.load(std::memory_order_acquire) == head_.load(std::memory_order_acquire);
  }
 private:
  std::vector<T> data_;
  std::atomic<size_t> head_{0}, tail_{0};
};

// Callback publishes timestamps; the control thread consumes them. Never infer
// playback from accepted bytes. Underflow silence has no source position.
struct Delivery {
  double dac_time;
  uint64_t source_end;
};

// Callback times must share the device clock and fit its negotiated latency.
// Reject incoherent positive timestamps as well as missing/regressing clocks.
class CallbackClock {
 public:
  bool valid(double current, double buffer, double latency, double duration, bool capture) noexcept {
    if (!std::isfinite(current) || current <= 0 || current < last_current_ ||
        !std::isfinite(buffer) || buffer <= 0 || !std::isfinite(latency) || latency < 0 ||
        !std::isfinite(duration) || duration <= 0) return false;
    last_current_ = current;
    const double delay = capture ? current - buffer : buffer - current;
    return delay >= 0 && delay <= latency + 2 * duration;
  }
 private:
  double last_current_ = 0;
};
class PlaybackClock {
 public:
  explicit PlaybackClock(size_t capacity) : pending_(capacity) {}
  bool publish(double dac_time, uint64_t source_end) noexcept {
    if (!std::isfinite(dac_time) || dac_time <= 0 ||
        dac_time < last_dac_ || source_end < last_source_) return false;
    last_dac_ = dac_time;
    last_source_ = source_end;
    return pending_.push({dac_time, source_end});
  }
  uint64_t advance(double now) {
    if (!std::isfinite(now) || now <= 0 || now < last_now_) {
      valid_ = false;
      return played_;
    }
    last_now_ = now;
    while (true) {
      if (!has_next_) has_next_ = pending_.pop(next_);
      if (!has_next_ || next_.dac_time > now) break;
      played_ = next_.source_end;
      has_next_ = false;
    }
    return played_;
  }
  bool valid() const { return valid_; }
  bool settled() const { return !has_next_ && pending_.empty(); }
 private:
  Ring<Delivery> pending_;
  Delivery next_{};
  bool has_next_ = false, valid_ = true;
  uint64_t played_ = 0, last_source_ = 0;
  double last_now_ = 0, last_dac_ = 0;
};
}  // namespace openai_audio

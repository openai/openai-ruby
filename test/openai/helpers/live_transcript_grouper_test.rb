# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/live/transcript_grouper"
require "open3"

class OpenAI::Test::LiveTranscriptGrouperTest < Minitest::Test
  # Control only this instance's clock/worker; other tests run in parallel.
  class ClockedGrouper < OpenAI::Live::TranscriptGrouper
    def initialize(**options)
      @now = 0
      super
    end

    def advance(milliseconds)
      target = @now + milliseconds
      1000.times do
        delay = timer_delay
        unless delay && @now + [0, delay].max <= target
          @now = target
          return
        end

        @now += [0, delay].max
        should_drain = @lock.synchronize { enqueue(flush_pending + @grouping.advance(source_now)) }
        drain if should_drain
      end

      raise "Timer failed to make progress"
    end

    private

    def now_ms = @now
    def start_timer = nil
  end

  def setup
    super
    @updated = []
    @closed = []
    @groupers = []
    @next_id = 0
    @grouper = create
  end

  def teardown
    @groupers.each(&:close)
    super
  end

  def create(**options)
    grouper = ClockedGrouper.new(
      on_segment_updated: @updated.method(:push),
      on_segment_closed: @closed.method(:push),
      **options
    )
    @groupers << grouper
    grouper
  end

  def event(text, speaker = :assistant, start: 0, finish: start + 200, id: nil)
    @next_id += 1
    type = speaker == :user ? OpenAI::Live::InputTranscriptDeltaEvent : OpenAI::Live::OutputTranscriptDeltaEvent
    type.new(delta: text, start_ms: start, end_ms: finish, event_id: id || "event_#{@next_id}")
  end

  def feed(text, speaker = :assistant, **options) = @grouper.push(event(text, speaker, **options))

  def finish(*expected)
    @grouper.close
    assert_equal(expected, @closed.map { |update| [update.segment.speaker, update.segment.text] })
    assert_equal(
      [nil, *@closed.map { |update| update.segment.id }][0...@closed.size],
      @closed.map { |update| update.segment.previous_id }
    )
    assert_equal(@closed.size, @closed.map { |update| update.segment.id }.uniq.size)
    @closed.each do |update|
      snapshots = @updated.select { |segment| segment.id == update.segment.id }
      assert_equal(update.segment, snapshots.last)
      snapshots.each_cons(2) { |a, b| assert(b.text.start_with?(a.text)) }
    end
  end

  def test_snapshots_copy_and_freeze_all_strings_without_mutating_raw_events
    raw = event(+"Can you ", :user, id: +"original")
    @grouper.push(raw)
    raw.delta.replace("changed")
    raw.event_id.replace("changed")
    @grouper.push(event("ignored duplicate", :user, id: "original"))
    feed("run ls?", :user, start: 200)
    first = @updated.first
    feed("Sure.", start: 1000)
    finish([:user, "Can you run ls?"], [:assistant, "Sure."])
    assert_equal("Can you ", first.text)
    assert_equal("changed", raw.delta)
    assert_equal(400, @closed.first.segment.end_ms)
    @updated.each do |segment|
      assert(segment.frozen?)
      assert(segment.id.frozen?)
      assert(segment.text.frozen?)
      assert(segment.previous_id.frozen?) if segment.previous_id
      assert_raises(FrozenError) { segment.text << "mutation" }
    end

    assert(@closed.all?(&:frozen?))
  end

  def test_simultaneous_first_intervals_prefer_user_in_either_order
    [true, false].each do |input_first|
      @updated.clear
      @closed.clear
      @grouper = create
      pair = [event("Question", :user), event("Answer")]
      (input_first ? pair : pair.reverse).each { |part| @grouper.push(part) }
      finish([:user, "Question"], [:assistant, "Answer"])
    end
  end

  def test_overlapping_barge_in_preserves_speakers_in_either_order
    [true, false].each do |input_first|
      @updated.clear
      @closed.clear
      @grouper = create
      feed("The answer is")
      @grouper.advance(50)
      pair = [event("Wait", :user, start: 200), event(" forty-two.", start: 200)]
      (input_first ? pair : pair.reverse).each { |part| @grouper.push(part) }
      feed(", stop.", :user, start: 400)
      finish([:assistant, "The answer is forty-two."], [:user, "Wait, stop."])
    end
  end

  def test_short_acknowledgments_are_suppressed_when_user_continues
    ["mhm", "Mm-hmm.", "\ufeffYEAH\ufeff", "\u00a0uh\u2003huh!\u00a0"].each do |ack|
      @updated.clear
      @closed.clear
      @grouper = create
      feed("Tell me", :user)
      feed(ack, start: 200)
      feed("more", :user, start: 800)
      feed("Here is the answer.", start: 2000)
      finish([:user, "Tell me more"], [:assistant, "Here is the answer."])
    end
  end

  def test_split_acknowledgments_do_not_prefix_substantive_answer
    feed("Tell me", :user)
    feed("Mm-", start: 200)
    feed("hmm.", start: 400)
    feed("more", :user, start: 800)
    feed("Answer", start: 1000)
    finish([:user, "Tell me more"], [:assistant, "Answer"])
  end

  def test_substantive_text_and_non_policy_whitespace_are_preserved
    ["\u0085yeah\u0085", "\u001cyeah\u001c", "okay-ish", "thirteen", "İ"].each do |text|
      @updated.clear
      @closed.clear
      @grouper = create
      feed("Tell me", :user)
      feed(text, start: 200)
      feed("more", :user, start: 800)
      @grouper.advance(5000)
      finish([:user, "Tell me"], [:assistant, text], [:user, "more"])
    end
  end

  def test_zero_disables_suppression_and_additional_phrases_are_copied
    phrases = [+"XYZ!"]
    @grouper = create(additional_acknowledgments: phrases)
    phrases.first.replace("changed")
    phrases.clear
    feed("Tell me", :user)
    feed("xyz", start: 200)
    feed("more", :user, start: 800)
    finish([:user, "Tell me more"])

    @updated.clear
    @closed.clear
    @grouper = create(backchannel_max_duration_ms: 0)
    feed("Tell me ", :user)
    feed("mhm", start: 200)
    feed("more", :user, start: 400)
    finish([:user, "Tell me more"], [:assistant, "mhm"])
  end

  def test_isolation_suppresses_overlapping_ack_but_preserves_separate_reply
    feed("Question", :user)
    feed("okay", start: 200)
    @grouper.advance(2000)
    feed("Answer", start: 3000)
    finish([:user, "Question"], [:assistant, "Answer"])

    @updated.clear
    @closed.clear
    @grouper = create
    feed("Question", :user)
    feed("okay", start: 1000)
    @grouper.advance(3000)
    finish([:user, "Question"], [:assistant, "okay"])
  end

  def test_custom_acknowledgments_use_contextual_unicode_lowercase
    {"ΟΣ" => "ος", "AΣ\u0345" => "aς\u0345", "\u0345Σ" => "\u0345σ"}.each do |spoken, phrase|
      @updated.clear
      @closed.clear
      @grouper = create(additional_acknowledgments: [phrase])
      feed("Tell me", :user)
      feed(spoken, start: 200)
      feed("more", :user, start: 800)
      finish([:user, "Tell me more"])
    end
  end

  def test_inactivity_uses_monotonic_receipt_time_and_preserves_interval_high_water_mark
    @grouper = create(assistant_silence_ms: 200)
    feed("First", finish: 500)
    @grouper.advance(100)
    feed(" overlapping.", start: 100, finish: 120)
    @grouper.advance(199)
    assert_empty(@closed)
    @grouper.advance(1)
    assert_equal(:inactivity, @closed.first.reason)
    assert_equal(500, @closed.first.segment.end_ms)
    feed("Later.", start: 150)
    finish([:assistant, "First overlapping."], [:assistant, "Later."])
  end

  def test_fractional_deadlines_finalize_without_hanging
    source = <<~'RUBY'
      require "openai/helpers/live/transcript_grouper"
      class SourceTimeGrouper < OpenAI::Live::TranscriptGrouper
        private
        def start_timer = nil
        def now_ms = 0
      end
      scenarios = [
        [{assistant_silence_ms: 0.1}, [[:assistant, "First", 0, 200], [:assistant, "Second", 201, 300]]],
        [{min_turn_separation_ms: 0.1}, [[:user, "Question", 0, 200], [:assistant, "Answer", 200, 400], [:user, "More", 800, 1000]]],
        [{min_turn_separation_ms: 0, backchannel_isolation_ms: 0.1}, [[:user, "Question", 0, 150], [:assistant, "okay", 100, 200], [:user, " More", 800, 1000]]]
      ]
      results = scenarios.map do |options, events|
        closed = []
        grouper = SourceTimeGrouper.new(**options, on_segment_closed: ->(event) {
          closed << [event.segment.speaker, event.segment.text, event.reason]
        })
        events.each_with_index do |(speaker, text, start_ms, end_ms), index|
          type = speaker == :user ? OpenAI::Live::InputTranscriptDeltaEvent : OpenAI::Live::OutputTranscriptDeltaEvent
          grouper.push(type.new(event_id: index.to_s, delta: text, start_ms: start_ms, end_ms: end_ms))
        end
        grouper.close
        closed
      end
      puts JSON.generate(results)
    RUBY
    Open3
      .popen2e(RbConfig.ruby, "-I", File.expand_path("../../../lib", __dir__), "-e", source) do |input, output, waiter|
        input.close
        begin
          assert(waiter.join(5), "Fractional deadlines must complete without hanging")
          result = output.read
          assert(waiter.value.success?, result)
          assert_equal(
            [
              [["assistant", "First", "inactivity"], ["assistant", "Second", "manual"]],
              [
                ["user", "Question", "speaker_change"],
                ["assistant", "Answer", "speaker_change"],
                ["user", "More", "manual"]
              ],
              [["user", "Question More", "manual"]]
            ],
            JSON.parse(result)
          )
        ensure
          unless waiter.join(0)
            begin
              Process.kill("KILL", waiter.pid)
            rescue Errno::ESRCH
              # The child exited between the join and kill.
            end

            waiter.join
          end
        end
      end
  end

  def test_user_has_no_inactivity_timeout
    feed("Hello", :user)
    @grouper.advance(60_000)
    assert_empty(@closed)
    feed(" again.", :user, start: 60_000)
    finish([:user, "Hello again."])
  end

  def test_duplicate_empty_and_future_events_do_not_restart_inactivity
    raw = event("Once.")
    @grouper.push(raw)
    @grouper.advance(1900)
    @grouper.push(raw)
    feed("", start: 100_000)
    @grouper.push({type: "future.event"})
    @grouper.advance(100)
    assert_equal([:inactivity], @closed.map(&:reason))
    finish([:assistant, "Once."])
  end

  def test_timestamp_reset_closes_prior_timeline_and_restarts_inactivity
    @grouper = create(assistant_silence_ms: 200)
    feed("Old", start: 1000, finish: 1500)
    @grouper.advance(100)
    feed("New", start: 0, finish: 100)
    assert_equal(:timestamp_reset, @closed.first.reason)
    @grouper.advance(199)
    assert_equal(1, @closed.size)
    @grouper.advance(1)
    finish([:assistant, "Old"], [:assistant, "New"])
    assert_equal([:timestamp_reset, :inactivity], @closed.map(&:reason))
  end

  def test_session_closed_finalizes_once_and_rejects_further_input
    feed("Question", :user)
    feed("Answer", start: 200)
    closed = OpenAI::Live::SessionClosedEvent.new(event_id: "closed", reason: :close_requested, session: {}, usage: {})
    @grouper.push(closed)
    @grouper.close
    finish([:user, "Question"], [:assistant, "Answer"])
    assert_equal([:session_closed, :session_closed], @closed.map(&:reason))
    assert_raises(RuntimeError) { feed("Late") }
  end

  def test_invalid_fields_fail_before_reserving_event_id
    [{start: -1}, {start: 200, finish: 100}, {finish: 9_007_199_254_740_992}, {id: ""}].each do |invalid|
      assert_raises(ArgumentError) { @grouper.push(event("bad", id: "same", **invalid)) }
    end

    raw = event("bad", id: "same")
    raw.delta = nil
    assert_raises(OpenAI::Errors::ConversionError) { @grouper.push(raw) }
    feed("Valid", id: "same")
    finish([:assistant, "Valid"])
  end

  def test_constructor_validation
    [:min_turn_separation_ms, :assistant_silence_ms, :backchannel_max_duration_ms, :backchannel_isolation_ms].each do |
        name
      |
      [-1, 2_147_483_648, Float::NAN, Float::INFINITY, "20", nil].each do |value|
        assert_raises(ArgumentError) { create(**{name => value}) }
      end
    end

    assert_raises(ArgumentError) { create(additional_acknowledgments: [nil]) }
    assert_raises(ArgumentError) { create(on_segment_updated: false) }
  end

  def test_large_unicode_text_is_preserved_and_groupers_have_distinct_ids
    text = "你好 😀" * 100_000
    feed(text)
    @grouper.advance(50)
    feed(" tail", start: 200)
    finish([:assistant, text + " tail"])
    assert_equal(text, @updated.first.text)
    other = create
    other.push(event("Independent"))
    other.close
    refute_equal(@updated.first.id, @updated.last.id)
  end

  def test_reentrant_callbacks_preserve_queued_updates_and_final_events
    delivered = []
    @grouper = create(
      on_segment_updated: -> (segment) {
        delivered << [:updated, segment.text]
        @grouper.close
        delivered << [:returned, segment.text]
      },
      on_segment_closed: -> (closed) { delivered << [:closed, closed.segment.text] }
    )
    feed("Hello")
    feed(" world", start: 200)
    assert_equal(
      [
        [:updated, "Hello"],
        [:returned, "Hello"],
        [:updated, "Hello world"],
        [:returned, "Hello world"],
        [:closed, "Hello world"]
      ],
      delivered
    )
    assert_raises(RuntimeError) { feed("Late") }
  end

  def test_caller_callback_exceptions_propagate_without_stranding_queued_updates
    delivered = []
    failure = RuntimeError.new("callback failed")
    @grouper = create(
      on_segment_updated: -> (segment) {
        delivered << segment.text
        raise failure if delivered.size == 1
      }
    )
    feed("Hello")
    assert_same(failure, assert_raises(RuntimeError) { feed(" world", start: 200) })
    @grouper.close
    assert_equal(["Hello", "Hello world"], delivered)
    assert_equal("Hello world", @closed.last.segment.text)
  end

  def test_concurrent_close_does_not_block_callback_or_reorder_events
    entered = Queue.new
    release = Queue.new
    delivered = Queue.new
    @grouper = create(
      on_segment_updated: -> (segment) {
        delivered << segment.text
        if segment.text == "Hello"
          entered << true
          release.pop
        end
      },
      on_segment_closed: -> (closed) { delivered << closed.reason }
    )
    feed("Hello")
    caller = Thread.new { feed(" world", start: 200) }
    assert(entered.pop(timeout: 5))
    closer = Thread.new { @grouper.close }
    assert(closer.join(5))
    release << true
    assert(caller.join(5))
    assert_equal(["Hello", "Hello world", :manual], 3.times.map { delivered.pop(timeout: 5) })
  ensure
    release&.push(true)
    caller&.join(5)
    closer&.join(5)
  end

  def test_real_timer_finalizes_inactivity_and_exits_after_close
    completed = Queue.new
    grouper = OpenAI::Live::TranscriptGrouper.new(
      assistant_silence_ms: 50,
      on_segment_closed: -> (closed) { completed << [closed, Thread.current] }
    )
    grouper.push(event("Hello"))
    result = completed.pop(timeout: 5)
    refute_nil(result)
    closed, worker = result
    assert_equal(:inactivity, closed.reason)
    assert_equal("Hello", closed.segment.text)
    refute_equal(Thread.current, worker)
    grouper.close
    grouper.close
    assert(worker.join(5))
    refute(worker.alive?)
  ensure
    grouper&.close
  end

  def test_timer_callback_failure_is_visible_through_normal_thread_exception
    started = Queue.new
    failure = RuntimeError.new("callback failed")
    grouper = OpenAI::Live::TranscriptGrouper.new(
      on_segment_updated: -> (_segment) {
        started << Thread.current
        Thread.current.report_on_exception = false
        raise failure
      }
    )
    grouper.push(event("Hello", :user))
    worker = started.pop(timeout: 5)
    refute_nil(worker)
    assert_same(failure, assert_raises(RuntimeError) { worker.value })
  ensure
    grouper&.close
  end

  def test_close_cancels_outstanding_timer_and_drains_manual_final_event
    updated = Queue.new
    closed = []
    grouper = OpenAI::Live::TranscriptGrouper.new(
      assistant_silence_ms: 60_000,
      on_segment_updated: -> (segment) { updated << [segment, Thread.current] },
      on_segment_closed: -> (event) { closed << event }
    )
    grouper.push(event("Pending"))
    result = updated.pop(timeout: 5)
    refute_nil(result)
    worker = result.last
    grouper.close
    assert(worker.join(5))
    assert_equal([:manual], closed.map(&:reason))
    assert_equal("Pending", closed.first.segment.text)
  ensure
    grouper&.close
  end
end

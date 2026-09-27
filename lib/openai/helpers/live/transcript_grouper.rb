# frozen_string_literal: true

require_relative "../../../openai"

module OpenAI
  module Live
    # Groups public Live transcript deltas into immutable display snapshots.
    # This is a speaker/acknowledgment heuristic, not VAD or lossless history.
    # Create one per session and close it on transport loss or teardown.
    class TranscriptGrouper
      # IDs belong to this local display projection, not server turns or items.
      # Each update contains the complete text; replace the displayed text.
      Segment = Data.define(:id, :previous_id, :speaker, :text, :start_ms, :end_ms)
      ClosedSegment = Data.define(:segment, :reason)

      # @api private
      Options = Data.define(
        :min_turn_separation_ms,
        :assistant_silence_ms,
        :backchannel_max_duration_ms,
        :backchannel_isolation_ms,
        :additional_acknowledgments
      )
      # @api private
      Fragment = Data.define(:speaker, :text, :start_ms, :end_ms, :received_at)
      # @api private
      Update = Data.define(:segment, :reason)
      private_constant :Options, :Fragment, :Update

      # Timing values are milliseconds, between 0 and 2147483647.
      # Set backchannel_max_duration_ms to zero to disable suppression.
      # Callbacks are serialized outside the state lock and may reenter push/close.
      # They run on the caller or the owned timer thread; exceptions propagate.
      def initialize(
        on_segment_updated: nil,
        on_segment_closed: nil,
        min_turn_separation_ms: 500,
        assistant_silence_ms: 2000,
        backchannel_max_duration_ms: 1000,
        backchannel_isolation_ms: 2000,
        additional_acknowledgments: []
      )
        timings = [min_turn_separation_ms, assistant_silence_ms, backchannel_max_duration_ms, backchannel_isolation_ms]
        unless timings.all? { |value|
            (value.is_a?(Integer) || value.is_a?(Float)) && value.between?(0, 2_147_483_647)
          }
          raise ArgumentError, "Timing must be between 0 and 2147483647 ms"
        end

        unless additional_acknowledgments.is_a?(Array) &&
            additional_acknowledgments.all? { |value| value.is_a?(String) }
          raise ArgumentError, "additional_acknowledgments must be an array of strings"
        end

        unless [on_segment_updated, on_segment_closed].all? { |value| value.nil? || value.respond_to?(:call) }
          raise ArgumentError, "Transcript callbacks must respond to call"
        end

        options = Options.new(*timings, additional_acknowledgments)
        @grouping = Grouping.new(options, "segment_#{SecureRandom.hex(8)}")
        @on_segment_updated = on_segment_updated
        @on_segment_closed = on_segment_closed
        @lock = Mutex.new
        @wake = ConditionVariable.new
        @seen_ids = {}
        @pending = []
        @updates = []
        @closed = false
        @dispatching = false
      end

      # Consume a typed Live event. Duplicate IDs, empty text and other events
      # are ignored. Invalid transcript fields and use after close raise.
      # Original events and their strings remain owned by the caller.
      # @return [void]
      def push(event)
        should_drain = @lock.synchronize do
          raise RuntimeError, "Cannot push events after closing the transcript grouper" if @closed

          if event.is_a?(SessionClosedEvent)
            enqueue(finish(:session_closed))
          else
            speaker = case event
            when InputTranscriptDeltaEvent
              :user
            when OutputTranscriptDeltaEvent
              :assistant
            else
              return
            end

            fragment = normalize(event, speaker)
            return if @seen_ids.key?(event.event_id)

            @seen_ids[event.event_id.dup.freeze] = true
            return if fragment.text.empty?

            emitted = []
            first = @pending.first
            if first && first.start_ms == fragment.start_ms && first.end_ms == fragment.end_ms
              @pending << fragment
              emitted.concat(flush_pending) if @pending.any? { |part| part.speaker != speaker }
            else
              emitted.concat(flush_pending)
              if @grouping.speaker == speaker
                emitted.concat(commit([fragment]))
              else
                @pending << fragment
              end
            end

            start_timer
            @wake.signal
            enqueue(emitted)
          end
        end

        drain if should_drain
        nil
      end

      # Flush/finalize once and cancel the owned timer. Never closes a transport.
      # A callback already running can finish after close returns.
      # @return [void]
      def close
        should_drain = @lock.synchronize { enqueue(@closed ? [] : finish(:manual)) }
        drain if should_drain
        nil
      end

      private

      def normalize(event, speaker)
        unless event.event_id.is_a?(String) &&
            !event.event_id.empty? &&
            event.delta.is_a?(String) &&
            event.start_ms.is_a?(Integer) &&
            event.start_ms.between?(0, 9_007_199_254_740_991) &&
            event.end_ms.is_a?(Integer) &&
            event.end_ms.between?(event.start_ms, 9_007_199_254_740_991)
          raise(
            ArgumentError,
            "Invalid Live transcript delta: expected an event ID, text and nonnegative timed interval"
          )
        end

        Fragment.new(speaker, event.delta.dup.freeze, event.start_ms, event.end_ms, now_ms)
      end

      def finish(reason)
        @closed = true
        @wake.signal
        emitted = flush_pending + @grouping.close(source_now, reason)
        @seen_ids.clear
        emitted
      end

      def commit(fragments)
        first = fragments.first
        return [] unless first

        emitted = []
        if @last_start_ms && first.start_ms < @last_start_ms
          emitted.concat(@grouping.close(source_now, :timestamp_reset))
          @anchor_source_ms = nil
        end

        @last_start_ms = first.start_ms
        @anchor_source_ms = [@anchor_source_ms || 0, *fragments.map(&:end_ms)].max
        @anchor_received_at = fragments.map(&:received_at).max
        emitted.concat(@grouping.process(fragments))
      end

      def flush_pending
        pending = @pending
        @pending = []
        commit(pending)
      end

      def now_ms = Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_millisecond)

      def source_now
        @anchor_source_ms ? @anchor_source_ms + [0, now_ms - @anchor_received_at].max : 0
      end

      def timer_delay
        if (first = @pending.first)
          first.received_at + 50 - now_ms
        elsif (deadline = @grouping.deadline)
          deadline - source_now
        end
      end

      def start_timer
        return if @timer_thread&.alive?

        @timer_thread = Thread.new { timer_loop }
        @timer_thread.name = "openai-live-transcript"
      end

      def timer_loop
        loop do
          should_drain = @lock.synchronize do
            loop do
              return if @closed

              delay = timer_delay
              break enqueue(flush_pending + @grouping.advance(source_now)) if delay && delay <= 0

              @wake.wait(@lock, delay && (delay / 1000.0))
            end
          end

          drain if should_drain
        end
      end

      # Enqueue while holding the state lock so caller/timer transitions retain
      # their order. One drain owns callback delivery, including reentrant work.
      def enqueue(emitted)
        @updates.concat(emitted)
        return false if @dispatching || @updates.empty?

        @dispatching = true
      end

      def drain
        drained = false
        loop do
          update = @lock.synchronize do
            if @updates.empty?
              @dispatching = false
              drained = true
              return
            end

            @updates.shift
          end

          if update.reason
            @on_segment_closed&.call(ClosedSegment.new(update.segment, update.reason))
          else
            @on_segment_updated&.call(update.segment)
          end
        end

      ensure
        @lock.synchronize { @dispatching = false } unless drained
      end
    end
  end
end

require_relative "transcript_grouping"

# frozen_string_literal: true

module OpenAI
  module Live
    class TranscriptGrouper
      # @api private
      # The established Live display policy, driven only by public text intervals.
      class Grouping
        Turn = Struct.new(:id, :previous_id, :speaker, :text, :start_ms, :end_ms, :emitted, :can_drop, :acknowledgment) do
          def snapshot
            Segment.new(id, previous_id, speaker, text.dup.freeze, start_ms, end_ms)
          end
        end

        Acknowledgment = Data.define(:characters, :text)
        ACKNOWLEDGMENTS = [
          "aha",
          "alright",
          "gotcha",
          "hm",
          "hmm",
          "mhm",
          "mm",
          "mm hmm",
          "okay",
          "ok",
          "right",
          "sure",
          "uh huh",
          "yeah",
          "yep",
          "yes"
        ].freeze
        # Match the JavaScript/Python policy, including BOM but not NEL.
        SPACE = "\u0009\u000a\u000b\u000c\u000d\u0020\u00a0\u1680\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u2028\u2029\u202f\u205f\u3000\ufeff"
        SEPARATORS = SPACE + ".,!?;:\"'()[]{}"
        TRIM = /\A[#{Regexp.escape(SEPARATORS)}]+|[#{Regexp.escape(SEPARATORS)}]+\z/
        WHITESPACE = /[#{SPACE}]+/
        # Ruby downcase omits the contextual final sigma used by JavaScript/Python.
        FINAL_SIGMA = /([\p{Cased}&&\P{Case_Ignorable}]\p{Case_Ignorable}*)Σ(?!\p{Case_Ignorable}*[\p{Cased}&&\P{Case_Ignorable}])/

        def initialize(options, id_prefix)
          @options = options
          @id_prefix = id_prefix
          @next_id = 0
          @acknowledgments = ACKNOWLEDGMENTS +
            options.additional_acknowledgments.map { |text| normalize(text) }.reject(&:empty?)
          @max_acknowledgment_length = @acknowledgments.map(&:length).max
        end

        def speaker = @current&.speaker

        def process(fragments)
          preferred = speaker || :user
          ordered = fragments.partition { |part| part.speaker == preferred }.flatten(1)
          first = ordered.first
          return [] unless first

          emitted = []
          while (due = deadline) && due < first.start_ms
            emitted.concat(advance(due))
          end

          if @current && ordered.none? { |part| part.speaker == speaker }
            emitted.concat(advance(first.start_ms, ordered.any? { |part| part.speaker == :user }))
          end

          ordered.each { |part| emitted.concat(ingest(part)) }
          emitted
        end

        def advance(time_ms, incoming_user = false)
          # Match #deadline exactly: subtracting fractional timings can round
          # below the threshold and prevent the source-time loop from advancing.
          if @current &&
              @buffered &&
              time_ms >= @current.end_ms +
              @options.min_turn_separation_ms &&
              !keep_backchannel?(time_ms)
            @buffered = maybe_drop_backchannel(time_ms)
            return promote if @buffered
          end

          if speaker == :assistant && !incoming_user && time_ms >= @current.end_ms + @options.assistant_silence_ms
            return finish_current(:inactivity)
          end

          []
        end

        def deadline
          return unless @current
          if @buffered
            separation = @current.end_ms + @options.min_turn_separation_ms
            if might_be_backchannel? && @buffered.can_drop && !user_continued? && !recent_assistant?
              return [separation, @buffered.end_ms + @options.backchannel_isolation_ms].max
            end

            return separation
          end

          @current.end_ms + @options.assistant_silence_ms if speaker == :assistant
        end

        def close(time_ms, reason)
          pending = maybe_drop_backchannel(time_ms)
          emitted = finish_current(reason)
          @buffered = nil
          if pending && !pending.text.empty?
            emitted.concat(emit(pending)).concat(finish(pending, reason))
          end

          @last_assistant_end = nil if reason == :timestamp_reset
          emitted
        end

        private

        def ingest(fragment)
          unless @current
            @current = new_turn(fragment)
            return emit(@current)
          end

          if fragment.speaker == speaker
            append(@current, fragment, !@buffered.nil?)
            return emit(@current)
          end

          @buffered = nil if speaker == :user && user_continued?
          if speaker == :assistant
            buffer(fragment)
            return promote
          end

          within_duration = fragment.end_ms -
            (@buffered&.start_ms || fragment.start_ms) < @options.backchannel_max_duration_ms
          ack = acknowledgment(fragment, within_duration)
          normalized = ack.text if within_duration
          if fragment.start_ms < @current.end_ms + @options.min_turn_separation_ms
            can_drop = normalized &&
              !normalized.empty? &&
              @acknowledgments.any? { |phrase| phrase.start_with?(normalized) }
            buffer(fragment, !!can_drop, ack)
            return []
          end

          if normalized && @acknowledgments.include?(normalized)
            buffer(fragment, !@buffered.nil?, ack)
            return []
          end

          @buffered = maybe_drop_backchannel(nil, fragment)
          emitted = finish_current(:speaker_change)
          if @buffered
            @current = @buffered
            @buffered = nil
            append(@current, fragment)
          else
            @current = new_turn(fragment)
          end

          emitted.concat(emit(@current))
        end

        def new_turn(fragment)
          id = "#{@id_prefix}_#{@next_id}".freeze
          @next_id += 1
          Turn.new(id, nil, fragment.speaker, fragment.text, fragment.start_ms, fragment.end_ms, false, true, nil)
        end

        def append(turn, fragment, separate = false)
          separator = separate && /[\p{L}\p{N}]\z/.match?(turn.text) && /\A[\p{L}\p{N}]/.match?(fragment.text) ? " " : ""
          turn.text += separator + fragment.text
          turn.end_ms = [turn.end_ms, fragment.end_ms].max
        end

        def buffer(fragment, can_drop = nil, ack = nil)
          if @buffered
            append(@buffered, fragment)
          else
            @buffered = new_turn(fragment)
          end

          @buffered.can_drop = can_drop unless can_drop.nil?
          @buffered.acknowledgment = ack
        end

        def promote
          return [] unless @buffered

          emitted = finish_current(:speaker_change)
          @current = @buffered
          @buffered = nil
          emitted.concat(emit(@current))
        end

        def finish_current(reason)
          turn = @current
          @current = nil
          turn ? finish(turn, reason) : []
        end

        def finish(turn, reason)
          @last_assistant_end = turn.end_ms if turn.speaker == :assistant
          turn.emitted ? [Update.new(turn.snapshot, reason)] : []
        end

        def emit(turn)
          return [] if turn.text.empty?
          unless turn.emitted
            turn.previous_id = @last_id
            @last_id = turn.id
            turn.emitted = true
          end

          [Update.new(turn.snapshot, nil)]
        end

        def might_be_backchannel?
          speaker == :user &&
            @buffered&.speaker == :assistant &&
            @buffered.end_ms -
            @buffered.start_ms < @options.backchannel_max_duration_ms
        end

        def user_continued?
          might_be_backchannel? && @buffered.can_drop && @current.end_ms > @buffered.end_ms
        end

        def recent_assistant?
          @current &&
            @buffered &&
            @last_assistant_end &&
            @buffered.start_ms < @last_assistant_end +
            @options.backchannel_isolation_ms &&
            @buffered.start_ms <= @current.start_ms
        end

        def keep_backchannel?(time_ms)
          might_be_backchannel? &&
            @buffered.can_drop &&
            !user_continued? &&
            !recent_assistant? &&
            time_ms < @buffered.end_ms +
            @options.backchannel_isolation_ms
        end

        def maybe_drop_backchannel(time_ms = nil, following = nil)
          return @buffered unless might_be_backchannel?
          return nil if user_continued?
          return @buffered if recent_assistant?
          return @buffered if following && following.start_ms < @buffered.end_ms + @options.backchannel_isolation_ms
          return @buffered if !following && (!time_ms || time_ms < @buffered.end_ms + @options.backchannel_isolation_ms)

          @buffered unless @buffered.can_drop
        end

        def acknowledgment(fragment, within_duration)
          previous = @buffered&.acknowledgment
          previous_characters = previous&.characters || 0
          characters = previous_characters
          fragment.text.each_char do |character|
            break if characters > @max_acknowledgment_length

            characters += 1 unless SEPARATORS.include?(character) || character == "-"
          end

          text = if characters == previous_characters && previous&.text
            previous.text
          elsif within_duration && characters <= @max_acknowledgment_length
            normalize((@buffered&.text || "") + fragment.text)
          end

          Acknowledgment.new(characters, text)
        end

        def normalize(text)
          text = text.gsub(FINAL_SIGMA) { "#{Regexp.last_match(1)}ς" }
          text.downcase.tr("-", " ").gsub(TRIM, "").split(WHITESPACE).join(" ")
        end
      end

      private_constant :Grouping
    end
  end
end
